if (!ds_list_empty(errors))
{

	for (var i = 0; i < ds_list_size(errors); i++)
	{
		var q = ds_list_find_value(errors, i)
		with q
		{
			draw_set_align(fa_left)
			draw_set_color(c_red)
			draw_set_alpha(1)
			draw_set_font(Font1)
			draw_text(64, 720 - 64 - (32 * i), txt)
			draw_set_color(c_white)
		}
	}
}
draw_set_alpha(1)
draw_set_font(Font1)
draw_set_color(c_white)