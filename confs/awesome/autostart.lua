os.execute("bash ~/scripts/init.sh")
--[[
local apps = {
	"nitrogen --restore",
	"picom",
	"dunst",
	"mpd",
	terminal,
	"xfce4-power-manager",
	"/usr/bin/emacs --daemon"
}

for _, value in pairs(apps) do
	os.execute(value.."&")
end
]]
