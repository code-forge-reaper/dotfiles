return {
	"honza/vim-snippets",
	dependencies = {
		"dcampos/nvim-snippy"
	},
	config = function()
		require('snippy').setup({
			mappings = {
				is = {
					['<Tab>'] = 'expand_or_advance',
					['<S-Tab>'] = 'previous',
				},
			},
		})
	end
}
