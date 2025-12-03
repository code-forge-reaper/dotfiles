local opts = { noremap = true, silent = true }
keymap('n','yc','%y+<ESC>', opts)
keymap('v','y','"+y<ESC>', opts)
