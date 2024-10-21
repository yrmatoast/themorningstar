draw_set_font(Font1)
draw_set_align(fa_center)
draw_text(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 - 100  - scrollY, "Choose A Level")
var page = selected[1]
for (var i = 0; i < array_length(levels[page]); i++)
{
	draw_set_color(c_white)
	var str = selected[0] == i ? "> " : ""
	draw_text(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 + (40 * i) - scrollY, str + levels[page][i].title)
}
draw_text(WINDOW_WIDTH / 2, WINDOW_HEIGHT - 150, string("Page {0}/{1}", page + 1, array_length(levels)))
draw_set_color(c_white)