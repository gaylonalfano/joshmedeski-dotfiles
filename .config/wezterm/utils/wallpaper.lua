local wezterm = require("wezterm")
local h = require("utils/helpers")
local f = require("utils/files")
local M = {}

M.get_wallpaper = function(dir)
	local glob = wezterm.glob(dir)
	-- print("glob:", glob)
	local wallpapers = f.without_ds_store(glob)
	print("wallpapers:", wallpapers)
	-- local wallpaper = h.get_random_entry(wallpapers)
	local wallpaper = h.get_random_entry(glob)
	print("wallpaper:", wallpaper)
	return {
		source = { File = { path = wallpaper } },
		height = "Cover",
		width = "Cover",
		horizontal_align = "Center",
		repeat_x = "Repeat",
		repeat_y = "Repeat",
		opacity = 1,
	}
end

M.get_gif_wallpaper = function(dir)
	local wallpapers = {}
	for _, v in ipairs(wezterm.glob(dir)) do
		if not string.match(v, "%.DS_Store$") then
			table.insert(wallpapers, v)
		end
	end
	local wallpaper = h.get_random_entry(wallpapers)
	return {
		source = { File = { path = wallpaper } },
		height = "Cover",
		width = "Cover",
		horizontal_align = "Center",
		repeat_x = "Repeat",
		repeat_y = "Repeat",
		opacity = 0.32,
		-- speed = 1000,
	}
end

-- M.set_nvim_wallpaper = function(dir, name)
-- 	return {
-- 		source = { File = { path = os.getenv("HOME") .. "/.config/wezterm/wallpapers/nvim/" .. name } },
-- 		height = "Cover",
-- 		width = "Cover",
-- 		horizontal_align = "Center",
-- 		repeat_x = "Repeat",
-- 		repeat_y = "Repeat",
-- 		opacity = 1,
-- 		-- speed = 200,
-- 	}
-- end

-- M.set_tmux_session_wallpaper = function(value)
-- 	local path = os.getenv("HOME") .. "/.config/wezterm/wallpapers/sessions/" .. value .. ".jpeg"
-- 	print(path)
-- 	return {
-- 		source = { File = { path = path } },
-- 		height = "Cover",
-- 		width = "Cover",
-- 		horizontal_align = "Center",
-- 		repeat_x = "Repeat",
-- 		repeat_y = "Repeat",
-- 		opacity = 1,
-- 		-- speed = 200,
-- 	}
-- end

return M
