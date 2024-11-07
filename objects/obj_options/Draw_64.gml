var _sel = selected
var m = menus[menu]
var opt = m.options
var _length = array_length(opt)
for (var q = 0; q < array_length(backgrounds); q++)
{
	draw_sprite_tiled_ext(spr_optionsBG, backgrounds[q].index, backgrounds[q].scroll, backgrounds[q].scroll, 1, 1, c_white, backgrounds[q].alpha)
	if q != 0
		backgrounds[q].alpha = approach(backgrounds[q].alpha, menu == backgrounds[q].men ? 1 : 0, 0.1)
	backgrounds[q].scroll += 1
}
switch m.anchor
{
	case optmenu.center:
		var xx = WINDOW_WIDTH / 2
		var yy = WINDOW_HEIGHT / 2 - (m.ypad * _length) / 2
		for (var i = 0; i < _length; i++)
		{
			var q = opt[i]
			draw_set_font(global.bigfont)
			draw_set_align(fa_center)
			draw_set_color(_sel == i ? c_white : c_gray)
			draw_text(xx, yy + m.ypad * i, q.name)
		}
	break
	case optmenu.left:
		var xx = WINDOW_WIDTH / 5
		var yy = WINDOW_HEIGHT / 2 - (m.ypad * _length) / 2
		for (var i = 0; i < _length; i++)
		{
			var q = opt[i]
			switch q.type
			{
				case optmenu.press:
					draw_set_font(global.bigfont)
					draw_set_align(fa_left)
					draw_set_color(_sel == i ? c_white : c_gray)
					draw_text(xx, yy + m.ypad * i, q.name)
					break
				case optmenu.toggle:
					draw_set_font(global.bigfont)
					draw_set_align(fa_left)
					draw_set_color(_sel == i ? c_white : c_gray)
					draw_text(xx, yy + m.ypad * i, q.name)
					draw_set_align(fa_right)
					draw_text(WINDOW_WIDTH - xx, yy + m.ypad * i, q.toggle[q.val])
					break
				case optmenu.slider:
					draw_set_font(global.bigfont)
					draw_set_align(fa_left)
					draw_set_color(_sel == i ? c_white : c_gray)
					draw_text(xx, yy + m.ypad * i, q.name)
					draw_set_align(fa_right)
					draw_text(WINDOW_WIDTH - xx, yy + m.ypad * i, q.val)
					break
				case optmenu.key:
					draw_set_font(global.bigfont)
					draw_set_align(fa_left)
					draw_set_color(_sel == i ? c_white : c_gray)
					draw_text(xx, yy + m.ypad * i, q.name)
					draw_set_align(fa_right)
					draw_text(WINDOW_WIDTH - xx, yy + m.ypad * i, string(q.val))
					break
			}
		}
	break
}
draw_set_color(c_white)