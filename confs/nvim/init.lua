KEYMAP_REGISTRY = {}
require "helpers"
require "vim._core.ui2".enable {
	enabled = true,
	msg = {
		target = "cmd",
		pager = { height = 0.4 },
		dialog = { height = 0.4 },
		msg = { height = 0.4, timeout = 3000 },
		cmd = { height = 0.4 }
	}
}

vim.cmd("set relativenumber")
vim.cmd("set softtabstop=4")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set noswapfile")
require "complete_darkness".setup()
vim.opt.clipboard = "unnamedplus"
if vim.g.neoray then
	vim.cmd("NeoraySet CursorAnimTime 0.08")
	vim.cmd("NeoraySet KeyZoomIn <C-ScrollWheelUp>")
	vim.cmd("NeoraySet KeyZoomOut <C-ScrollWheelDown>")
	vim.cmd 'set guifont="JetBrainsMonoNerdFontMono-Bold:h18"'
	vim.api.nvim_set_option("guifont", "JetBrainsMonoNerdFontMono-Bold:h18")
end
require "Lazy"
require "draft"

-- Load all files from the keybinds folder
local keybinds_path = vim.fn.stdpath('config') .. '/lua/keybinds/'

local keybinds_files = scandir(keybinds_path)

for _, file in ipairs(keybinds_files) do
	if not (file == "." or file == "..") then
		require("keybinds." .. ignoreLetters(".lua", file))
	end
end
