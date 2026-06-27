local main_mod = "SUPER"

local function bind(keys, dispatcher, opts)
	hl.bind(keys, dispatcher, opts or {})
end

bind(main_mod .. " + Return", hl.dsp.exec_cmd("kitty"))
bind(main_mod .. " + B", hl.dsp.exec_cmd("zen-browser"))
bind(main_mod .. " + E", hl.dsp.exec_cmd("kitty zsh -ic y"))
bind(main_mod .. " + N", hl.dsp.exec_cmd("kitty zsh -ic nvim"))
bind(main_mod .. " + SPACE", hl.dsp.exec_cmd("walker"))
bind(main_mod .. " + O", hl.dsp.exec_cmd("obsidian"))
bind(main_mod .. " + Y", hl.dsp.exec_cmd("gtk-launch youtube"))
bind(main_mod .. " + C", hl.dsp.exec_cmd("gtk-launch chatgpt"))
bind(main_mod .. " + SHIFT + C", hl.dsp.exec_cmd("gtk-launch claude"))
bind(main_mod .. " + SHIFT + N", hl.dsp.exec_cmd('kitty zsh -ic "nq"'))

bind(main_mod .. " + Q", hl.dsp.window.close())
bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
bind(main_mod .. " + F", hl.dsp.window.fullscreen({ mode = 0 }))
bind(main_mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = 1 }))
bind(main_mod .. " + BACKSPACE", hl.dsp.exec_cmd("~/.config/hypr/scripts/clean-window.sh"))
bind(main_mod .. " + SHIFT + B", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
bind(main_mod .. " + ALT + S", hl.dsp.exec_cmd("hyprdvd -s"))
bind(main_mod .. " + F1", hl.dsp.exec_cmd("~/.config/hypr/scripts/gamemode.sh"))
bind(main_mod .. " + U", hl.dsp.exec_cmd("~/.config/hypr/scripts/autoclicker.sh"))

bind(main_mod .. " + left", hl.dsp.focus({ direction = "left" }))
bind(main_mod .. " + down", hl.dsp.focus({ direction = "down" }))
bind(main_mod .. " + up", hl.dsp.focus({ direction = "up" }))
bind(main_mod .. " + right", hl.dsp.focus({ direction = "right" }))
bind(main_mod .. " + h", hl.dsp.focus({ direction = "left" }))
bind(main_mod .. " + j", hl.dsp.focus({ direction = "down" }))
bind(main_mod .. " + k", hl.dsp.focus({ direction = "up" }))
bind(main_mod .. " + l", hl.dsp.focus({ direction = "right" }))
bind(main_mod .. " + SHIFT + h", hl.dsp.focus({ workspace = "e+1" }))
bind(main_mod .. " + SHIFT + l", hl.dsp.focus({ workspace = "e-1" }))

for i = 1, 10 do
	local key = i % 10
	bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	bind(main_mod .. " + CTRL + code:" .. (9 + i), hl.dsp.window.move({ workspace = i }))
end

bind("ALT + left", hl.dsp.window.move({ direction = "left" }))
bind("ALT + right", hl.dsp.window.move({ direction = "right" }))
bind("ALT + up", hl.dsp.window.move({ direction = "up" }))
bind("ALT + down", hl.dsp.window.move({ direction = "down" }))

-- move windows with mouse
bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

bind("Print", hl.dsp.exec_cmd("hyprshot -m window -o ~/Screenshots/"))
bind("CTRL + Print", hl.dsp.exec_cmd("hyprshot -m region -o ~/Screenshots/"))
bind("ALT + Print", hl.dsp.exec_cmd("hyprshot -m active -m output -o ~/Screenshots/"))
bind(main_mod .. " + ESCAPE", hl.dsp.exec_cmd("hyprlock"))

bind(main_mod .. " + M", hl.dsp.exit())
bind("ALT + TAB", hl.dsp.exec_cmd("wlogout -b 2"))
bind(main_mod .. " + K", hl.dsp.exec_cmd("~/.config/hypr/scripts/keybinding.sh"))
bind(main_mod .. " + COMMA", hl.dsp.exec_cmd("makoctl dismiss"))
bind(main_mod .. " + SHIFT + COMMA", hl.dsp.exec_cmd("makoctl dismiss --all"))
bind(main_mod .. " + F5", hl.dsp.exec_cmd("pkexec ~/.config/hypr/scripts/post-update.sh"))
bind(main_mod .. " + F4", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper.sh"))
bind("ALT + a", hl.dsp.exec_cmd("~/.config/waybar/refresh.sh"))
bind("ALT + SHIFT + a", hl.dsp.exec_cmd("~/.config/waybar/unhide.sh"))
bind("ALT + r", hl.dsp.exec_cmd("~/.config/swaync/refresh.sh"))
bind(main_mod .. " + R", hl.dsp.exec_cmd("hyprctl reload"))

bind(main_mod .. " + SHIFT + Return", hl.dsp.exec_cmd("pypr-client toggle term"))
bind(main_mod .. " + Z", hl.dsp.workspace.toggle_special("spot"))

bind(main_mod .. " + W", hl.dsp.workspace.toggle_special("top"))
bind(main_mod .. " + S", hl.dsp.workspace.toggle_special("bottom"))
bind(main_mod .. " + A", hl.dsp.workspace.toggle_special("left"))
bind(main_mod .. " + D", hl.dsp.workspace.toggle_special("right"))

bind(main_mod .. " + SHIFT + W", hl.dsp.window.move({ workspace = "special:top" }))
bind(main_mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:bottom" }))
bind(main_mod .. " + SHIFT + A", hl.dsp.window.move({ workspace = "special:left" }))
bind(main_mod .. " + SHIFT + D", hl.dsp.window.move({ workspace = "special:right" }))

bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
	{ locked = true, repeating = true }
)
bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
	{ locked = true, repeating = true }
)
bind(
	"ALT + XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +1%"),
	{ locked = true, repeating = true }
)
bind(
	"ALT + XF86AudioLowerVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -1%"),
	{ locked = true, repeating = true }
)
bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
bind(main_mod .. " + P", hl.dsp.exec_cmd("playerctl play-pause"))
bind("CTRL + XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true })
bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true })
bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true })
bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 5%+"), { locked = true, repeating = true })
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { locked = true, repeating = true })
bind("ALT + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 1%+"), { locked = true, repeating = true })
bind("ALT + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 1%-"), { locked = true, repeating = true })

hl.define_submap("gamemode", function()
	bind("escape", hl.dsp.submap("reset"))
	bind(main_mod .. " + F1", hl.dsp.exec_cmd("~/.config/hypr/scripts/gamemode.sh"))
	bind("ALT + Q", hl.dsp.window.close())
	bind("ALT + F", hl.dsp.window.fullscreen({ mode = 0 }))
	bind("ALT + V", hl.dsp.window.float({ action = "toggle" }))
	bind("ALT + h", hl.dsp.focus({ direction = "left" }))
	bind("ALT + j", hl.dsp.focus({ direction = "down" }))
	bind("ALT + k", hl.dsp.focus({ direction = "up" }))
	bind("ALT + l", hl.dsp.focus({ direction = "right" }))
	bind("ALT + left", hl.dsp.focus({ direction = "left" }))
	bind("ALT + down", hl.dsp.focus({ direction = "down" }))
	bind("ALT + up", hl.dsp.focus({ direction = "up" }))
	bind("ALT + right", hl.dsp.focus({ direction = "right" }))

	bind("ALT + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
	bind("ALT + SHIFT + j", hl.dsp.window.move({ direction = "down" }))
	bind("ALT + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
	bind("ALT + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
	bind("ALT + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
	bind("ALT + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
	bind("ALT + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
	bind("ALT + SHIFT + right", hl.dsp.window.move({ direction = "right" }))

	for i = 1, 10 do
		local key = i % 10
		bind("ALT + " .. key, hl.dsp.focus({ workspace = i }))
	end

	bind("ALT + W", hl.dsp.workspace.toggle_special("top"))
	bind("ALT + S", hl.dsp.workspace.toggle_special("bottom"))
	bind("ALT + A", hl.dsp.workspace.toggle_special("left"))
	bind("ALT + D", hl.dsp.workspace.toggle_special("right"))
	bind(
		"CTRL + XF86AudioRaiseVolume",
		hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
		{ locked = true, repeating = true }
	)
	bind(
		"CTRL + XF86AudioLowerVolume",
		hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
		{ locked = true, repeating = true }
	)
	bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true })
	bind("CTRL + XF86AudioMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true })
	bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true })
	bind("ALT + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 1%+"), { locked = true, repeating = true })
	bind("ALT + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 1%-"), { locked = true, repeating = true })
end)
