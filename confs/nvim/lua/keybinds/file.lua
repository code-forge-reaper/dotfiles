vim.keymap.set("n", "<C-n>", function()
	vim.ui.input({
		prompt = "new file name",
	}, function(name)
		if name then
			local fd = io.open(name, "r")
			if fd then
				print("Opening existing: " .. name)
				fd:close()
			else
				print("new file: " .. name)
			end
			vim.cmd("edit " .. vim.fn.fnameescape(name))
		end
	end)
end, {})
