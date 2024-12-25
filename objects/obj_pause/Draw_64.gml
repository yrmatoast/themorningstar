if pause
{
	draw_sprite(screensprite, 0, 0, 0)
	draw_sprite(guisprite, 0, 0, 0)
	draw_set_color(c_black)
	draw_set_alpha(0.7)
	draw_rectangle(0, 0, 1280, 720, false)
	draw_set_alpha(1)
	var arr = exiting ? exitarr : pausearr
	for (var i = 0; i < array_length(arr); i++)
	{
		draw_set_font(global.bigfont)
		draw_set_align(fa_center)
		draw_set_color(selected == i ? arr[i].color : c_gray)
		fekles_draw_text(WINDOW_WIDTH / 2, (WINDOW_HEIGHT / 2 - 40 * array_length(arr) / 2) + (40 * i), string_upper(arr[i].title))
	}
	draw_set_color(c_white)
	if exiting
		fekles_draw_text(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 - 150, "ARE YOU SURE YOU WANT TO QUIT?\n YOUR PROGRESS WONT BE SAVED!")
}