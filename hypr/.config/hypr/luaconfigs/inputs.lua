hl.config({
	cursor = {
		enable_hyprcursor = false,
		no_hardware_cursors = false,
	},
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "caps:escape, leftmeta:super",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = -0.1,
		scroll_method = 2,
		scroll_button = 274,
		scroll_factor = 1,
		touchpad = {
			natural_scroll = true,
			scroll_factor = 0.15,
			clickfinger_behavior = true,
		},
	},
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "left", action = "special", workspace = "right" })
hl.gesture({ fingers = 4, direction = "down", action = "special", workspace = "top" })
hl.gesture({ fingers = 4, direction = "up", action = "special", workspace = "bottom" })
hl.gesture({ fingers = 4, direction = "right", action = "special", workspace = "left" })

-- Plugin config stays pending until dynamic-cursors Lua API is confirmed.
