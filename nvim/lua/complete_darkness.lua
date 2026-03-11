-- complete_darkness_neon.lua
-- Neon, high-contrast colorscheme for Neovim
-- Usage:
--   require("complete_darkness_neon").setup({ transparent = true })
-- or put in colors/ and use :colorscheme complete_darkness_neon

local M = {}

function M.setup(opts)
	opts = opts or {}
	local transparent = opts.transparent or false

	-- Palette (neon-focused, high contrast)
	local palette = {
		bg          = transparent and "NONE" or "#0b0f16", -- deep near-black
		fg          = "#e6f1ff",                    -- soft white for long reads
		muted       = "#6b7280",                    -- comments / secondary text
		gray_dim    = "#2b2f36",

		neon_pink   = "#ff4dff", -- keywords / important
		neon_cyan   = "#00e5ff", -- functions / calls
		neon_yellow = "#ffd900", -- strings / literals
		neon_green  = "#7cff5f", -- success / tags
		neon_orange = "#ff8c42", -- warnings / numbers
		neon_blue   = "#5aa0ff", -- types / identifiers
		neon_violet = "#b58cff", -- preproc / meta
		error_red   = "#ff5370", -- errors
	}

	-- Basic settings
	vim.o.background = "dark"
	vim.o.termguicolors = true
	vim.g.colors_name = "complete_darkness_neon"

	-- helper: set highlight safely
	local function hl(group, opts)
		-- opts: { fg = "#hex", bg = "#hex" or "NONE", bold = bool, italic = bool, underline = bool, default = bool }
		vim.api.nvim_set_hl(0, group, opts)
	end

	-- Core UI
	hl("Normal", { fg = palette.fg, bg = palette.bg })
	hl("CursorLine", { bg = palette.gray_dim })
	hl("CursorLineNr", { fg = palette.neon_cyan, bg = palette.gray_dim, bold = true })
	hl("LineNr", { fg = "#3d4451", bg = palette.bg })
	hl("Visual", { bg = "#183040" })
	hl("Search", { fg = palette.bg, bg = palette.neon_yellow })
	hl("IncSearch", { fg = palette.bg, bg = palette.neon_orange })
	hl("MatchParen", { bg = "#14222a" })
	hl("Pmenu", { fg = palette.fg, bg = "#07101a" })
	hl("PmenuSel", { fg = palette.bg, bg = palette.neon_cyan, bold = true })
	hl("StatusLine", { fg = palette.fg, bg = "#07101a" })
	hl("StatusLineNC", { fg = "#7a7f88", bg = "#0a0f14" })
	hl("Title", { fg = palette.neon_pink, bold = true })
	hl("Type", { fg = palette.neon_blue })
	hl("Directory", { fg = palette.neon_cyan })
	hl("FloatBorder", { fg = palette.neon_violet })
	hl("NormalFloat", { fg = palette.fg, bg = "#07101a" })
	hl("Folded", { fg = "#9aa4b2", bg = "#07101a" })
	hl("Cursor", { fg = palette.bg, bg = palette.fg })

	-- Basic syntax
	hl("Comment", { fg = palette.muted, italic = true })
	hl("Constant", { fg = palette.neon_yellow })
	hl("String", { fg = palette.neon_yellow })
	hl("Character", { fg = palette.neon_yellow })
	hl("Number", { fg = palette.neon_orange })
	hl("Boolean", { fg = palette.neon_orange, bold = true })
	hl("Identifier", { fg = palette.neon_blue })
	hl("Function", { fg = palette.neon_cyan })
	hl("Statement", { fg = palette.neon_pink })
	hl("Conditional", { fg = palette.neon_pink })
	hl("Repeat", { fg = palette.neon_pink })
	hl("Operator", { fg = palette.fg })
	hl("Keyword", { fg = palette.neon_pink, bold = true })
	hl("Delimiter", { fg = palette.fg })
	hl("Special", { fg = palette.neon_violet })
	hl("Todo", { fg = palette.neon_orange, bg = palette.bg, bold = true })

	-- LSP diagnostics
	hl("DiagnosticError", { fg = palette.error_red })
	hl("DiagnosticWarn", { fg = palette.neon_orange })
	hl("DiagnosticInfo", { fg = palette.neon_cyan })
	hl("DiagnosticHint", { fg = palette.neon_green })
	hl("DiagnosticVirtualTextError", { fg = palette.error_red, bg = "NONE" })
	hl("DiagnosticVirtualTextWarn", { fg = palette.neon_orange, bg = "NONE" })
	hl("DiagnosticVirtualTextInfo", { fg = palette.neon_cyan, bg = "NONE" })
	hl("DiagnosticVirtualTextHint", { fg = palette.neon_green, bg = "NONE" })

	-- Treesitter (common captures)
	hl("@comment", { fg = palette.muted, italic = true })
	hl("@constant", { fg = palette.neon_yellow })
	hl("@string", { fg = palette.neon_yellow })
	hl("@number", { fg = palette.neon_orange })
	hl("@boolean", { fg = palette.neon_orange })
	hl("@function", { fg = palette.neon_cyan })
	hl("@function.call", { fg = palette.neon_cyan })
	hl("@keyword", { fg = palette.neon_pink, bold = true })
	hl("@keyword.function", { fg = palette.neon_pink, bold = true })
	hl("@variable", { fg = palette.fg })
	hl("@property", { fg = palette.neon_blue })
	hl("@type", { fg = palette.neon_blue })
	hl("@parameter", { fg = "#cbd5e1" })
	hl("@constant.builtin", { fg = palette.neon_violet })
	hl("@punctuation.bracket", { fg = palette.fg })
	hl("@text.note", { fg = palette.neon_green })
	hl("@tag", { fg = palette.neon_green })
	hl("@namespace", { fg = palette.neon_violet })
	hl("@preproc", { fg = palette.neon_violet, bold = true })

	-- Git signs / diff
	hl("DiffAdd", { fg = palette.neon_green })
	hl("DiffChange", { fg = palette.neon_cyan })
	hl("DiffDelete", { fg = palette.error_red })
	hl("DiffText", { fg = palette.neon_yellow })

	-- Quickfix / Telescope / plugin safe defaults
	hl("TSSelection", { bg = "#13323a" })
	hl("TelescopePromptPrefix", { fg = palette.neon_cyan })
	hl("TelescopeSelection", { fg = palette.fg, bg = "#08202a" })

	-- Make sure cursorline highlight links don't hide colors
	-- (some plugins link these groups; override aggressively)
	vim.cmd("highlight! link WhichKey Key") -- example; remove if you dislike
end

return M
