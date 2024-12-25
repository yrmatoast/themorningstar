draw_set_font(global.bigfont)
draw_set_align(fa_center)
if showing
{
	var spacing = 12
	var xx = WINDOW_WIDTH / 2
	var yy = WINDOW_HEIGHT - 100
	fekles_draw_text(xx, yy, string_upper(text))
}