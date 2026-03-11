local fns = require "helpers"
require "config.lazy"
require "draft"
-- Load all files from the keybinds folder
local keybinds_path = vim.fn.stdpath('config') .. '/lua/keybinds/'

local keybinds_files = fns.scandir(keybinds_path)

for _, file in ipairs(keybinds_files) do
	if not (file == "." or file == "..") then
		require("keybinds." .. fns.ignoreLetters(".lua", file))
	end
end


fns.cmd("set relativenumber")
fns.cmd("set softtabstop=4")
fns.cmd("set tabstop=4")
fns.cmd("set shiftwidth=4")
fns.cmd("set noswapfile")
if vim.g.neoray then
	fns.cmd("NeoraySet CursorAnimTime 0.08")
	fns.cmd("NeoraySet KeyZoomIn <C-ScrollWheelUp>")
	fns.cmd("NeoraySet KeyZoomOut <C-ScrollWheelDown>")
	fns.set("guifont", ":h18")
end
vim.opt.clipboard = "unnamedplus"

require "complete_darkness".setup()

--vim.cmd("colorscheme complete_darkness")
