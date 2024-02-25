local M = {}

-- FIXME: Figure out a way to dynamically retrieve colors from the loaded color scheme
M.load_palette = function()
	local catppuccin_palette = require("catppuccin.palettes").get_palette("macchiato")
	M.colors = {
		red = catppuccin_palette.red,
		orange = catppuccin_palette.peach,
		yellow = catppuccin_palette.yellow,
		blue = catppuccin_palette.blue,
		purple = catppuccin_palette.mauve,
		green = catppuccin_palette.green,
	}
end

return M
