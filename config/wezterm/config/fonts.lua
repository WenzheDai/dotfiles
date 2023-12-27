local wezterm = require("wezterm")
local platform = require("utils.platform")

local font = {
	family = "JetBrains Mono",
	weight = "DemiBold",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
}

return {
	font = wezterm.font(font),
	font_size = 16,

	--ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
	freetype_load_target = "Normal", ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
	freetype_render_target = "Normal", ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
