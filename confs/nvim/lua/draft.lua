local reuse_last_commit = false
local last_commit_msg = nil
local function get_last_commit_message()
	local handle = io.popen("git log -1 --pretty=%B")
	if not handle then return nil end

	local result = handle:read("*a")
	handle:close()

	if result and result ~= "" then
		return result:gsub("%s+$", "")
	end
	return nil
end

function toggle_reuse_commit()
	reuse_last_commit = not reuse_last_commit
	print("Reuse last commit message: " .. (reuse_last_commit and "ON" or "OFF"))
end

function draft()
	local function commit_with(msg)
		msg = msg:gsub('"', '\\"')
		os.execute(string.format(
			'git add . && git commit -m "%s"',
			msg
		))
	end

	if reuse_last_commit then
		if not last_commit_msg then
			last_commit_msg = get_last_commit_message()
		end

		if last_commit_msg then
			commit_with(last_commit_msg)
		else
			print("No previous commit message found.")
		end
		return
	end

	vim.ui.input({
		prompt = "Commit message: "
	}, function(input)
		if not input or input == "" then
			input = os.date("%Y-%m-%d %H:%M:%S")
		end

		last_commit_msg = input
		commit_with(input)
	end)
end

vim.api.nvim_create_autocmd("FileType",{ pattern = {"markdown"}, callback = function ()
	vim.keymap.set("n", "<leader>d", draft, {buffer=true})
	vim.keymap.set("n", "<leader>td", toggle_reuse_commit, {buffer=true})
end })
