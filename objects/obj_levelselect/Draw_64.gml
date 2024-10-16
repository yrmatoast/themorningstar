draw_set_font(Font1)
draw_set_align(fa_center)
draw_text(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 - 100, "Choose A Level")

for (var i = 0; i < array_length(levels); i++)
{
	draw_set_color(c_white)
	var str = selected == i ? "> " : ""
	draw_text(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 + (50 * i), str + levels[i][0])
}
draw_set_color(c_white)