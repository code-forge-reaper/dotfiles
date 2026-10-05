return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local confs = require("nvim-treesitter.config")
		confs.setup({
			ensure_installed = { "lua", "javascript", "python" },
			highlight = { enabled = true },
			indent = { enabled = true }
		})
	end
}
