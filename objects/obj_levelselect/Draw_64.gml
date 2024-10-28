var page = selected[1]
var sel = selected[0]
draw_set_font(global.bigfont)
draw_set_align(fa_center)
draw_text(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 - 100  - scrollY, string_upper("Choose A Level"))
for (var i = 0; i < array_length(levels[page]); i++)
{
	draw_set_color(selected[0] == i ? c_white : c_gray)
	draw_text(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 + (40 * i) - scrollY, string_upper(levels[page][i].title))
}
draw_set_color(c_white)
draw_text(WINDOW_WIDTH / 2, WINDOW_HEIGHT - 150, string_upper(string("Page {0} Out of {1}", page + 1, array_length(levels))))
draw_set_color(c_red)
var _checkpoint = string("{0} Checkpoints", levels[page][sel].title)
if load_quick(true, _checkpoint, "general_currentroom") != -4
{
	draw_text(WINDOW_WIDTH / 1.4, WINDOW_HEIGHT - 50, "[C] DELETE CHECKPOINT DATA")
}
draw_set_color(c_white)