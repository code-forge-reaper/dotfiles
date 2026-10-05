local opts = { noremap = true, silent = true }
keymap('n', 'k', 'lua vim.lsp.buf.signature_help()', opts)
keymap("n", "K", "LspUI hover", opts)
keymap("n", "lR", "LspUI reference", opts)
keymap("n", "ld", "LspUI definition", opts)
keymap("n", "lD", "LspUI declaration", opts)
keymap("n", "lt", "LspUI type_definition", opts)
keymap("n", "li", "LspUI implementation", opts)
keymap("n", "lr", "LspUI rename", opts)
keymap("n", "la", "LspUI code_action", opts)
keymap("n", "lci", "LspUI call_hierarchy incoming_calls", opts)
keymap("n", "lco", "LspUI call_hierarchy outgoing_calls", opts)
keymap("n", "ldp", "LspUI diagnostic prev", opts)
keymap("n", "ldn", "LspUI diagnostic next", opts)
keymap('n', 'lwa', 'lua vim.lsp.buf.add_workspace_folder()', opts)
keymap('n', 'lwr', 'lua vim.lsp.buf.remove_workspace_folder()', opts)
keymap('n', 'lwl',
    'lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))', opts)
keymap('n', 'f', 'lua vim.lsp.buf.format()', opts) --[[ this is like, the thing i use most,
no sense putting it behind another keybind]]

