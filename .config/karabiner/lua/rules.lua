local dji_device = {
	{ product_id = 45069, vendor_id = 11427 },
}

local volume_knob_device = {
	{ product_id = 22315, vendor_id = 1155 },
}

local command_tab_remap = {
	description = "Remap Command+Tab to Option+Tab",
	enabled = false,
	manipulators = {
		{
			from = { key_code = "tab", modifiers = { mandatory = { "command" } } },
			to = { { key_code = "tab", modifiers = { "option" } } },
			type = "basic",
		},
		{
			from = { key_code = "tab", modifiers = { mandatory = { "command", "shift" } } },
			to = { { key_code = "tab", modifiers = { "option", "shift" } } },
			type = "basic",
		},
	},
}

local hjkl_arrows = {
	description = "Map Left Option plus h/j/k/l to Arrows",
	manipulators = {
		{
			from = { key_code = "h", modifiers = { mandatory = { "left_option" }, optional = { "any" } } },
			to = { { key_code = "left_arrow" } },
			type = "basic",
		},
		{
			from = { key_code = "j", modifiers = { mandatory = { "left_option" }, optional = { "any" } } },
			to = { { key_code = "down_arrow" } },
			type = "basic",
		},
		{
			from = { key_code = "k", modifiers = { mandatory = { "left_option" }, optional = { "any" } } },
			to = { { key_code = "up_arrow" } },
			type = "basic",
		},
		{
			from = { key_code = "l", modifiers = { mandatory = { "left_option" }, optional = { "any" } } },
			to = { { key_code = "right_arrow" } },
			type = "basic",
		},
	},
}

local akimbo_cmd = {
	description = "Akimbo cmd to F12",
	manipulators = {
		{
			from = {
				simultaneous = {
					{ key_code = "left_command" },
					{ key_code = "right_command" },
				},
				simultaneous_options = {
					to_after_key_up = {
						{ key_code = "f12", modifiers = { "fn" } },
					},
				},
			},
			to = { { key_code = "vk_none" } },
			type = "basic",
		},
	},
}

local dji_mic_vol_up = {
	description = "DJI Mic 2: Volume Up \u{2192} Hyper+Tab",
	manipulators = {
		{
			conditions = {
				{ identifiers = dji_device, type = "device_if" },
			},
			from = { consumer_key_code = "volume_increment" },
			to = {
				{ key_code = "tab", modifiers = { "left_command", "left_control", "left_option", "left_shift" } },
			},
			type = "basic",
		},
	},
}

-- Helper to create a volume knob mute manipulator for double-tap mode switching
local function knob_double_tap(from_mode, to_mode, notification)
	return {
		conditions = {
			{ identifiers = volume_knob_device, type = "device_if" },
			{ name = "mute_pressed_once", type = "variable_if", value = 1 },
			{ name = "knob_mode", type = "variable_if", value = from_mode },
		},
		from = { consumer_key_code = "mute" },
		to = {
			{ set_variable = { name = "knob_mode", value = to_mode } },
			{ set_variable = { name = "mute_pressed_once", value = 0 } },
			{ shell_command = "osascript -e 'display notification \"" .. notification .. "\" with title \"Volume Knob\"'" },
		},
		type = "basic",
	}
end

-- Helper to create a volume knob single-tap mute manipulator with delayed action
local function knob_single_tap(mode, fallback_action)
	return {
		conditions = {
			{ identifiers = volume_knob_device, type = "device_if" },
			{ name = "knob_mode", type = "variable_if", value = mode },
		},
		from = { consumer_key_code = "mute" },
		to = {
			{ set_variable = { name = "mute_pressed_once", value = 1 } },
		},
		to_delayed_action = {
			to_if_canceled = {
				{ set_variable = { name = "mute_pressed_once", value = 0 } },
			},
			to_if_invoked = {
				{ set_variable = { name = "mute_pressed_once", value = 0 } },
				fallback_action,
			},
		},
		type = "basic",
	}
end

local volume_knob_mode_switch = {
	description = "Volume Knob: Mode Switch (Double-Tap Mute)",
	manipulators = {
		-- Double-tap transitions: 0→1, 1→2, 2→0
		knob_double_tap(0, 1, "Navigation Mode"),
		knob_double_tap(1, 2, "Scroll Mode"),
		knob_double_tap(2, 0, "Volume Mode"),
		-- Single-tap with delayed fallback per mode
		knob_single_tap(0, { consumer_key_code = "mute" }),
		knob_single_tap(1, { key_code = "return_or_enter" }),
		knob_single_tap(2, { key_code = "page_down" }),
	},
}

local volume_knob_navigation = {
	description = "Volume Knob: Navigation Mode (Up/Down Arrows)",
	manipulators = {
		{
			conditions = {
				{ identifiers = volume_knob_device, type = "device_if" },
				{ name = "knob_mode", type = "variable_if", value = 1 },
			},
			from = { consumer_key_code = "volume_decrement" },
			to = { { key_code = "up_arrow" } },
			type = "basic",
		},
		{
			conditions = {
				{ identifiers = volume_knob_device, type = "device_if" },
				{ name = "knob_mode", type = "variable_if", value = 1 },
			},
			from = { consumer_key_code = "volume_increment" },
			to = { { key_code = "down_arrow" } },
			type = "basic",
		},
	},
}

local volume_knob_scroll = {
	description = "Volume Knob: Scroll Mode",
	manipulators = {
		{
			conditions = {
				{ identifiers = volume_knob_device, type = "device_if" },
				{ name = "knob_mode", type = "variable_if", value = 2 },
			},
			from = { consumer_key_code = "volume_increment" },
			to = { { mouse_key = { vertical_wheel = 32 } } },
			type = "basic",
		},
		{
			conditions = {
				{ identifiers = volume_knob_device, type = "device_if" },
				{ name = "knob_mode", type = "variable_if", value = 2 },
			},
			from = { consumer_key_code = "volume_decrement" },
			to = { { mouse_key = { vertical_wheel = -32 } } },
			type = "basic",
		},
	},
}

local hyper_key = {
	description = "Caps Lock \u{2192} Hyper Key (\u{2303}\u{2325}\u{21e7}\u{2318}) | Escape if alone | Use fn + caps lock to enable caps lock",
	manipulators = {
		{
			from = { key_code = "caps_lock" },
			to = {
				{ key_code = "left_shift", modifiers = { "left_command", "left_control", "left_option" } },
			},
			to_if_alone = { { key_code = "escape" } },
			type = "basic",
		},
		{
			from = { key_code = "caps_lock", modifiers = { mandatory = { "left_command" } } },
			to = { { key_code = "escape" } },
			type = "basic",
		},
		{
			from = { key_code = "caps_lock", modifiers = { mandatory = { "left_option" } } },
			to = { { key_code = "escape" } },
			type = "basic",
		},
	},
}

return {
	command_tab_remap = command_tab_remap,
	hjkl_arrows = hjkl_arrows,
	akimbo_cmd = akimbo_cmd,
	dji_mic_vol_up = dji_mic_vol_up,
	volume_knob_mode_switch = volume_knob_mode_switch,
	volume_knob_navigation = volume_knob_navigation,
	volume_knob_scroll = volume_knob_scroll,
	hyper_key = hyper_key,
}
