local servers = {
	"lua_ls",
	"pyright",
	"ts_ls",
	"clangd",
	"ols",
	"gdscript",
	"csharp_ls",
	"qmlls"
}

local configs = {
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
	ols = {
		init_options = {
			checker_args = "-strict-style"
		}
	},
	gdscript = {
		cmd = { "godot-mono", "--headless", "--lsp" },
	},
	clangd = {

		settings = {
			clangd = {
				inlayHints = {
					parameterNames = { enabled = "all" }, -- Show all parameter name hints
					parameterTypes = { enabled = true }, -- Show parameter type hints
					variableTypes = { enabled = true }, -- Show variable type hints
					-- Add other inlay hint settings as needed
				},
			},
		},
	}
}
return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.diagnostic.config({
			update_in_insert = true,
			virtual_text = true,
		})

		for _, lsp in ipairs(servers) do
			local opts = configs[lsp] or {}
			vim.lsp.config(lsp, opts)
			vim.lsp.enable(lsp)
		end
	end,
}
