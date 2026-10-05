return {
	{
		"jinzhongjia/LspUI.nvim",
		branch = "main",
		config = function()
			require("LspUI").setup()
			vim.diagnostic.config({
				virtual_text = false,
			})
		end
	},
	{
		"j-hui/fidget.nvim"
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end
	}
}
