--local opts = { noremap = true, silent = true}
--keymap("n", "t", "FloatermToggle", opts)
--keymap("t", "<C-e>", "FloatermToggle", opts)

local betterTerm = require('betterTerm')

-- Toggle the first terminal (ID defaults to index_base, which is 0)
vim.keymap.set({"n", "t"}, "<C-t>", function() betterTerm.open() end, { desc = "Open terminal" })
vim.keymap.set("n", "t", function() betterTerm.open() end, { desc = "Open terminal" })
vim.keymap.set({"n", "t"}, "<C-G>", function() betterTerm.toggle_termwindow() end, { desc = "Toggle terminal" })

-- Cycle to the right
vim.keymap.set({"n", "t"}, "<C-PageUp>", function() betterTerm.cycle(1) end, { desc = "Cycle terminals to the right" })

-- Cycle to the left
vim.keymap.set({"n", "t"}, "<C-PageDown>", function() betterTerm.cycle(-1) end, { desc = "Cycle terminals to the left" })

-- Select a terminal to focus
vim.keymap.set("n", "<leader>tt", betterTerm.select, { desc = "Select terminal" })

-- Rename the current terminal
vim.keymap.set("n", "<leader>tr", betterTerm.rename, { desc = "Rename terminal" })

-- Toggle the tabs bar
vim.keymap.set("n", "<leader>tb", betterTerm.toggle_tabs, { desc = "Toggle terminal tabs" })
