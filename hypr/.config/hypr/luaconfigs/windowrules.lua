hl.layer_rule({
	name = "rofi",
	match = { namespace = "^(rofi)$" },
	blur = true,
	ignore_alpha = 0.5,
})

hl.layer_rule({
	name = "walker",
	match = { namespace = "^(walker)$" },
	blur = false,
	ignore_alpha = 0.5,
})

hl.layer_rule({
	name = "wlogout",
	match = { namespace = "^(wlogout)$" },
	blur = true,
	ignore_alpha = 0.5,
})

hl.layer_rule({
	name = "waybar",
	match = { namespace = "^(waybar)$" },
	blur = true,
	ignore_alpha = 0,
})

hl.window_rule({
	name = "discord",
	match = { class = "^(discord)$" },
	workspace = "special:top",
})

hl.window_rule({
	name = "steam",
	match = { class = "^(steam)$" },
	workspace = "special:bottom",
})

hl.window_rule({
	name = "spotify",
	match = { class = "^(spotify)$" },
	float = true,
})

-- Confine the mouse pointer inside any Steam game window
hl.window_rule({
	-- match = { class = "^(steam_app_.*)$" },
	-- confine_pointer = true,
})

for _, rule in ipairs({
	{ "network-overlay", "^(network-overlay)$", "800 600", "(monitor_w-805) 45" },
	{ "bluetooth-overlay", "^(bluetooth-overlay)$", "800 600", "(monitor_w-805) 45" },
	{ "audio-overlay", "^(audio-overlay)$", "800 600", "(monitor_w-805) 45" },
	{ "btop-overlay", "^(btop-overlay)$", "800 600", "(monitor_w-805) 45" },
	{ "pacman-overlay", "^(pacman-overlay)$", "600 400", "5 45" },
}) do
	hl.window_rule({
		name = rule[1],
		match = { class = rule[2] },
		float = true,
		size = rule[3],
		move = rule[4],
		animation = "slide",
	})
end
