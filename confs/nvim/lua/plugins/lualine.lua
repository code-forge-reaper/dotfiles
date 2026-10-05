return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local opts = {
			theme = "dracula"
		}
		require("lualine").setup(opts)
	end
}
