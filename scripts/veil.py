#!/usr/bin/env python
import re
import sys
import argparse
import os
import textwrap
import shlex
import builtins

safe_builtins = {
    "__build_class__": builtins.__build_class__,
    "print": builtins.print,
    "input": builtins.input,
    "open": builtins.open,
    "len": builtins.len,
    "range": builtins.range,
    "str": builtins.str,
    "abs": builtins.abs,
    "bool": builtins.bool,
    "int": builtins.int,
    "float": builtins.float,
    "object": builtins.object,
    "__name__": "__main__",
    "exit": builtins.exit,
}

try:
    import black

    HAS_BLACK = True
except ImportError:
    HAS_BLACK = False
    print("⚠️  Black not installed, code formatting disabled")


def setup_cli():
    """Set up command line arguments"""
    parser = argparse.ArgumentParser(description="Veil Language Transformer")
    parser.add_argument("input_file", help="Input file to process (e.g., input.vl)")
    parser.add_argument(
        "--rules", "-r", default="lang.reg", help="Rules file (default: lang.reg)"
    )
    parser.add_argument(
        "--verbose", "-v", action="store_true", help="Enable verbose logging"
    )
    parser.add_argument("--show-rules", action="store_true", help="Show parsed rules")
    parser.add_argument(
        "--show-original", action="store_true", help="Show original transformed code"
    )
    parser.add_argument(
        "--show-formatted", action="store_true", help="Show Black-formatted code"
    )
    parser.add_argument(
        "--no-format", action="store_true", help="Disable Black code formatting"
    )
    parser.add_argument(
        "--sandbox", action="store_true", help="Enables sandboxing", default=False
    )
    parser.add_argument(
        "--save-format", help="where to save this file?", default=""
    )
    parser.add_argument(
        "--dry-run", action="store_true", help="Show transformations without executing"
    )
    parser.add_argument(
        "--print-code",
        action="store_true",
        help="Print generated code without executing",
    )
    return parser.parse_args()


def _resolve_path(base_dir, path):
    if os.path.isabs(path):
        return path
    return os.path.normpath(os.path.join(base_dir or ".", path))


def parse_rules(source_lines, base_dir=None, verbose=False):
    """
    Parse rules using indented blocks
    """
    source_lines = [x.replace(r"#(.*)\n", "") for x in source_lines]
    lines = list(source_lines)
    i = 0
    rules = []
    python_includes = []
    seen_includes = set()
    in_rule = False
    current_pattern = None
    current_replacement = []

    while i < len(lines):
        raw_line = lines[i]
        line_num = i + 1
        stripped = raw_line.strip()

        if stripped.startswith("%"):
            # parse directive safely (handles quoted paths)
            try:
                tokens = shlex.split(stripped[1:].strip())
            except ValueError:
                tokens = stripped[1:].strip().split()
            if not tokens:
                if verbose:
                    print(f"⚠ Empty directive at line {line_num}")
                i += 1
                continue

            cmd = tokens[0].lower()
            args_tok = tokens[1:] if len(tokens) > 1 else []
            if cmd == "include":
                if not args_tok:
                    print(f"⚠ %include_python missing path at line {line_num}")
                    i += 1
                    continue
                path = args_tok[0]
                resolved = _resolve_path(base_dir, path)
                if resolved in seen_includes:
                    if verbose:
                        print(f"ℹ Skipping already-included python: {resolved}")
                    i += 1
                    continue
                if not os.path.exists(resolved):
                    print(f"⚠ Python include not found: {resolved} (line {line_num})")
                    i += 1
                    continue
                try:
                    with open(resolved, "r") as f:
                        py_src = f.read()
                except Exception as e:
                    print(f"⚠ Failed to read python include {resolved}: {e}")
                    i += 1
                    continue
                seen_includes.add(resolved)
                python_includes.append(py_src)
                if verbose:
                    print(f"🐍 Queued python include: {resolved}")
                lines.pop(i)
                continue
            else:
                raise ValueError(f"Unknown preprocessing directive: {stripped}")

        # Check if this is a pattern line (no leading whitespace) and contains =>
        if not raw_line.startswith((" ", "\t")) and "=>" in stripped:
            if in_rule and current_pattern:
                try:
                    rules.append(
                        (re.compile(current_pattern), "\n".join(current_replacement))
                    )
                except Exception as e:
                    print(f"⚠ Invalid pattern: {current_pattern} (line {line_num})")
                    exit(1)
                if verbose:
                    print(f"📝 Parsed rule: {current_pattern} => ...")
            pattern_part, replacement_part = stripped.split("=>", 1)
            current_pattern = pattern_part.strip()
            current_replacement = [replacement_part.strip()]
            in_rule = True
            i += 1
            continue

        elif in_rule and (raw_line.startswith((" ", "\t")) or not stripped):
            current_replacement.append(stripped)
            i += 1
            continue
        else:
            if in_rule and current_pattern:
                try:
                    rules.append(
                        (re.compile(current_pattern), "\n".join(current_replacement))
                    )
                except Exception as e:
                    print(f"⚠ Invalid pattern: {current_pattern} (line {line_num})")
                    exit(1)

                if verbose:
                    print(f"📝 Parsed rule: {current_pattern} => ...")
                in_rule = False
            if verbose:
                print(f"⚠ Invalid or unexpected line at {line_num}: {stripped}")
            i += 1
            continue

    if in_rule and current_pattern:
        try:
            rules.append((re.compile(current_pattern), "\n".join(current_replacement)))
        except Exception as e:
            print(f"⚠ Invalid pattern: {current_pattern} (line {line_num})")
            exit(1)
        if verbose:
            print(f"📝 Parsed rule: {current_pattern} => ...")

    if verbose:
        print(f"✅ Total rules parsed: {len(rules)}")
        if python_includes:
            print(f"🐍 Total python includes queued: {len(python_includes)}")

    return rules, python_includes


import re
import textwrap


def fix_indentation(code: str) -> str:
    """Fixes indentation inconsistencies in Python code blocks."""
    lines = code.splitlines()
    fixed = []
    indent_stack = [0]
    last_indent = 0

    for i, line in enumerate(lines):
        # remove trailing spaces/tabs
        line = line.rstrip()

        if not line.strip():
            fixed.append("")
            continue

        # detect current indentation level (spaces only)
        leading = len(line) - len(line.lstrip(" \t"))

        # normalize tabs to 4 spaces
        line = line.replace("\t", "    ")

        stripped = line.strip()

        # ignore comments or decorators
        if stripped.startswith(("#", "@")):
            fixed.append(" " * last_indent + stripped)
            continue

        # if indentation is inconsistent (like ' push(42)')
        if leading > 0 and last_indent == 0 and not fixed[-1].strip().endswith(":"):
            leading = 0

        # reduce indentation if necessary
        if leading > last_indent + 4:
            leading = last_indent + 4
        elif leading < 0:
            leading = 0

        fixed.append(" " * leading + stripped)
        last_indent = leading

    return "\n".join(fixed).strip() + "\n"


def auto_indent_code(code_string):
    """Simple auto-indentation for generated Python code"""
    code_string = fix_indentation(code_string)
    if HAS_BLACK:
        return black.format_str(code_string, mode=black.Mode())

    lines = code_string.split("\n")
    result = []
    indent_level = 0

    for line in lines:
        stripped = line.strip()
        if not stripped:
            result.append("")
            continue

        if stripped.startswith(("return", "pass", "break", "continue", "raise")):
            pass
        elif stripped.startswith(("elif ", "else:", "except", "finally:")):
            indent_level = max(0, indent_level - 1)

        result.append("    " * indent_level + stripped)

        if stripped.endswith((":", "->")) and not stripped.startswith(("#")):
            indent_level += 1
        elif stripped in ("pass", "break", "continue"):
            indent_level = max(0, indent_level - 1)

    return "\n".join(result)


def safe_exec(code_string, env, args):
    """Safely execute code with formatted syntax"""
    try:
        if not args.no_format:
            formatted_code = auto_indent_code(code_string)
        else:
            formatted_code = code_string
            if args.verbose:
                print("ℹ️  Black formatting disabled")

        if args.show_formatted:
            print("=== Formatted Code ===")
            print(formatted_code)
            print("======================")

        if args.save_format:
            with open(args.save_format, "w") as f:
                f.write(formatted_code)
            exit(0)

        if args.dry_run:
            print("🚫 Dry run - execution skipped")
            return

        exec(formatted_code, env)

    except SyntaxError as e:
        print(f"❌ Syntax error: {e}")
        if not args.no_format:
            print("Trying with original code...")
            try:
                exec(code_string, env)
            except Exception as fallback_error:
                print(f"❌ Execution failed: {fallback_error}")
    except Exception as e:
        print(f"❌ Execution error: {e}\n{code_string}")


def main():
    args = setup_cli()

    if args.verbose:
        print(f"🚀 Starting Veil Transformer")
        print(f"📁 Input: {args.input_file}")
        print(f"📜 Rules: {args.rules}")

    # Load rules
    try:
        with open(args.rules) as f:
            langSrc = f.readlines()
    except FileNotFoundError:
        print(f"❌ Rules file not found: {args.rules}")
        sys.exit(1)

    rules_base_dir = os.path.dirname(os.path.abspath(args.rules)) or "."
    rules, python_includes = parse_rules(
        langSrc, base_dir=rules_base_dir, verbose=args.verbose
    )

    if args.show_rules:
        print("=== Parsed Rules ===")
        for i, (pattern, replacement) in enumerate(rules):
            print(f"Rule {i+1}:")
            print(f"  Pattern: {pattern.pattern}")
            print(f"  Replacement: {replacement}")
            print()

    # Load input
    try:
        with open(args.input_file) as f:
            text = f.read()
    except FileNotFoundError:
        print(f"❌ Input file not found: {args.input_file}")
        sys.exit(1)

    if args.show_original:
        print("=== Original Transformed Code ===")
        print(text)
        print("=================================")

    # Apply transformations
    transformations_applied = 0
    for pattern, replacement in rules:
        try:
            new_text = pattern.sub(replacement, text)
        except Exception as e:
            print(f"❌ Error applying rule {pattern.pattern}: {e}")
            sys.exit(1)
        if new_text != text:
            transformations_applied += 1
            if args.verbose:
                replacement_preview = replacement.replace("\n", "\\n")[:50]
                print(f"🔧 Applied: {pattern.pattern} => {replacement_preview}...")
        text = new_text

    if args.verbose:
        print(f"✅ Transformations applied: {transformations_applied}")

    # Prepare execution environment
    if args.sandbox:
        st = {"__builtins__": safe_builtins}
    else:
        st = {}

        # st = {"__builtins__": {}, "print": print, "input": input, "len": len}
    # Execute python includes first
    c = ""
    for py_src in python_includes:
        # if args.verbose:
        #    print("🐍 Executing included python chunk...")
        # safe_exec(py_src, st["var"], st["funcs"], args)
        c += py_src + "\n"

    # Execute transformed text
    if not args.print_code:
        safe_exec(c + text, st, args)
    else:
        print(c + text)


if __name__ == "__main__":
    main()
