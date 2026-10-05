-- complete_darkness_neon.lua
-- Neon high-contrast colorscheme for Neovim

local M = {}

function M.setup(opts)
	opts = opts or {}
	local transparent = opts.transparent or false

	vim.o.background = "dark"
	vim.o.termguicolors = true
	vim.g.colors_name = "complete_darkness_neon"

	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	-------------------------------------------------
	-- Palette
	-------------------------------------------------

	local c = {
		bg             = transparent and "NONE" or "#1f1f1f",
		bg_alt         = "#07101a",
		bg_dim         = "#2b2f36",
		lighter_bg_dim = "#3d4451",

		fg             = "#e6f1ff",
		muted          = "#6b7280",

		pink           = "#fa00af",
		cyan           = "#00f5ff",
		yellow         = "#ffa900",
		green          = "#7cff5f",
		orange         = "#ff8c42",
		blue           = "#5aa0ff",
		violet         = "#b58cff",
		red            = "#ff5370",
		vis_line       = "#183040",
		mparen         = "#1024ab",
		param          = "#aba5a1"
	}

	-------------------------------------------------
	-- helpers
	-------------------------------------------------

	local function hl(group, spec)
		vim.api.nvim_set_hl(0, group, spec)
	end

	local function link(a, b)
		hl(a, { link = b })
	end

	-------------------------------------------------
	-- UI
	-------------------------------------------------

	hl("Normal", { fg = c.fg, bg = c.bg })
	hl("CursorLine", { bg = c.bg_dim })
	hl("CursorLineNr", { fg = c.cyan, bold = true })
	hl("LineNr", { fg = c.lighter_bg_dim })

	hl("Visual", { bg = c.vis_line })

	hl("Search", { fg = c.bg, bg = c.yellow })
	hl("IncSearch", { fg = c.bg, bg = c.orange })

	hl("MatchParen", { bg = c.mparen })

	hl("StatusLine", { fg = c.fg, bg = c.bg_alt })
	hl("StatusLineNC", { fg = c.muted, bg = c.bg_alt })

	hl("Pmenu", { fg = c.fg, bg = c.bg_alt })
	hl("PmenuSel", { fg = c.bg, bg = c.cyan, bold = true })

	hl("FloatBorder", { fg = c.violet })
	hl("NormalFloat", { fg = c.fg, bg = c.bg_alt })

	hl("Cursor", { fg = c.bg, bg = c.fg })

	-------------------------------------------------
	-- Syntax
	-------------------------------------------------

	hl("Comment", { fg = c.muted, italic = true })

	hl("Constant", { fg = c.yellow })
	hl("String", { fg = c.yellow })
	hl("Number", { fg = c.orange })
	hl("Boolean", { fg = c.orange, bold = true })

	hl("Identifier", { fg = c.blue })
	hl("Function", { fg = c.cyan })

	hl("Statement", { fg = c.pink })
	hl("Keyword", { fg = c.pink, bold = true })

	hl("Operator", { fg = c.fg })
	hl("Delimiter", { fg = c.fg })

	hl("Special", { fg = c.violet })
	hl("Type", { fg = c.blue })

	hl("Todo", { fg = c.orange, bold = true })

	-------------------------------------------------
	-- Diagnostics
	-------------------------------------------------

	hl("DiagnosticError", { fg = c.red })
	hl("DiagnosticWarn", { fg = c.orange })
	hl("DiagnosticInfo", { fg = c.cyan })
	hl("DiagnosticHint", { fg = c.green })

	hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
	hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.orange })
	hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.cyan })
	hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.green })

	-------------------------------------------------
	-- Treesitter
	-------------------------------------------------

	link("@comment", "Comment")

	hl("@string", { fg = c.yellow })
	hl("@number", { fg = c.orange })
	hl("@boolean", { fg = c.orange })

	hl("@function", { fg = c.cyan })
	hl("@keyword", { fg = c.pink, bold = true })

	hl("@variable", { fg = c.fg })
	hl("@property", { fg = c.blue })
	hl("@type", { fg = c.blue })
	hl("@parameter", { fg = c.param })

	hl("@tag", { fg = c.green })
	hl("@namespace", { fg = c.violet })
	hl("@preproc", { fg = c.violet, bold = true })

	-------------------------------------------------
	-- Diff / Git
	-------------------------------------------------
	hl("NotifyBackground", { bg = c.cyan, fg = c.red })

	hl("DiffAdd", { fg = c.green })
	hl("DiffChange", { fg = c.cyan })
	hl("DiffDelete", { fg = c.red })
	hl("DiffText", { fg = c.yellow })

	-------------------------------------------------
	-- Telescope
	-------------------------------------------------
	hl("TelescopePromptPrefix", { fg = c.cyan })
	hl("TelescopeSelection", { bg = c.vis_line })
end

return M
