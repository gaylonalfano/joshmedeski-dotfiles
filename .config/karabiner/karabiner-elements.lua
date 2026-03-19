local json = require("lua.json")
local rules = require("lua.rules")

local function write_json_file(file_path, data)
	local file = io.open(file_path, "w")
	if file == nil then
		error("Could not open file for writing: " .. file_path)
	end
	file:write(json.encode(data, { indent = true }))
	file:close()
end

local config = {
	profiles = {
		{
			name = "Default profile",
			selected = true,
			complex_modifications = {
				rules = {
					rules.command_tab_remap,
					rules.hjkl_arrows,
					rules.akimbo_cmd,
					rules.dji_mic_vol_up,
					rules.volume_knob_mode_switch,
					rules.volume_knob_navigation,
					rules.volume_knob_scroll,
					rules.hyper_key,
				},
			},
			devices = {
				{
					identifiers = {
						is_keyboard = true,
						is_pointing_device = true,
						product_id = 591,
						vendor_id = 1452,
					},
					ignore = false,
				},
				{
					identifiers = {
						is_pointing_device = true,
						product_id = 45095,
						vendor_id = 1133,
					},
					ignore = false,
				},
				{
					identifiers = {
						is_keyboard = true,
						is_pointing_device = true,
						product_id = 6505,
						vendor_id = 12951,
					},
					ignore = false,
					ignore_vendor_events = true,
					manipulate_caps_lock_led = false,
				},
				{
					identifiers = {
						is_game_pad = true,
						is_keyboard = true,
						is_pointing_device = true,
						product_id = 3616,
						vendor_id = 13364,
					},
					ignore = false,
				},
				{
					identifiers = {
						is_keyboard = true,
						is_pointing_device = true,
						product_id = 3616,
						vendor_id = 13364,
					},
					disable_built_in_keyboard_if_exists = true,
					ignore = false,
				},
				{
					identifiers = {
						is_consumer = true,
						product_id = 45069,
						vendor_id = 11427,
					},
					ignore = false,
					ignore_vendor_events = true,
				},
				{
					identifiers = {
						is_consumer = true,
						product_id = 22315,
						vendor_id = 1155,
					},
					ignore = false,
					ignore_vendor_events = true,
				},
			},
			virtual_hid_keyboard = {
				country_code = 0,
				keyboard_type_v2 = "ansi",
			},
		},
	},
}

write_json_file("karabiner.json", config)
