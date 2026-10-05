return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.completion").setup({
			delay = {
				completion = 100,
				info = 100,
				signature = 50,
			},
			lsp_completion = {
				source_func = "omnifunc",
				auto_setup = true,
			},
			mappings = {
				force_twostep = "<C-Space>",
				force_fallback = "<C-x><C-x>",
				fallback = "<C-n>",
			},
			window = {
				info = { height = 25, width = 80, border = "single" },
				signature = { height = 25, width = 80, border = "single" },
			},
		})
	end,
}
