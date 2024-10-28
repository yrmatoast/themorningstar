draw_set_font(global.bigfont)
draw_set_align(fa_center)
if showing
{
	var spacing = 12
	var xx = WINDOW_WIDTH / 2 - (spacing * string_length(text))
	var yy = WINDOW_HEIGHT - 100
	var strx = 0
	for (var i = 1; i < string_length(text) + 1; i++)
	{
	    var str = string_char_at(string_upper(text), i)
	    var shakeY = 0
		
	    draw_set_color(c_white)
	    if string_char_at(text, i - 1) != "[" && string_char_at(text, i + 1) != "]" && str != "[" && str != "]"
	        draw_text(xx + strx, yy + shakeY, str)
	    else if str != "[" && str != "]"
	    {
	        draw_sprite(spr_button, 0, xx + strx, yy + shakeY + (16 / 2))
	        draw_text_color(xx + strx, yy + shakeY, str, c_black, c_black, c_black, c_black, 1)
	    }
	    strx += string_width(str)
    
	}
}