#!/usr/bin/env python
import os
import sys

# this just de-dupes paths

# you should have this be piped into eval or similar
p = os.getenv("PATH").split(":")
f = []
for pp in p:
    pp = pp.strip()
    if not pp in f:
        # print(pp, pp in f)
        f.append(pp)


# print(f)
def run(*t):
    print(*t)


shell = sys.argv[1]
if shell == "fish":
    run("set", "-x", "PATH", " ".join(f))
elif shell == "zsh" or shell == "bash":
    run("export", "PATH=" + ":".join(f))
elif shell == "elvish":
    for i in f:
        f[f.index(i)] = f'"{i}"'
    run("set", "paths", "=", f"[{" ".join(f)}]")
elif shell == "xonsh":
    for i in f:
        # f[f.index(i)] = f'"{i}"'
        run(f"$PATH.add('{i}')")
else:
    assert False, f"TODO: support this shell {shell}"
