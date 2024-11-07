if buffer == 0
{
	__ti_input()
	var m = menus[menu]
	var opt = m.options
	var _length = array_length(opt) - 1
	var q = opt[selected]
	var move = q.type != optmenu.slider ? (key_left2 + key_right2) : (key_left + key_right)
	var move2 = -key_up2 + key_down2
		if move != 0 && q.type != optmenu.press && q.type != optmenu.key
		{
			q.val += move
			q.val = clamp(q.val, 0, q.max)
			q.func()
		}
		if move2 != 0 && q.selecting == false
		{
			selected += move2
			selected = wrap(selected, 0, _length)
		}
	if q.type != optmenu.key
	{
		if key_jump2
		{
			if q.type == optmenu.toggle
			{
				q.val += 1
				q.val = wrap(q.val, 0, q.max)
			}
			q.func()
		}
	}
	else
	{
		if key_jump2 && selecting == false
		{
			if q.selecting == false
				q.selecting = true
			buffer = 6
		}
		if q.selecting == true && keyboard_check_pressed(vk_anykey) && buffer == 0
		{
			q.selecting = false
			q.val = keyboard_key
			q.func()
		}
	}
	if key_slap2
	{
		m.backfunc()
	}
}
buffer = approach(buffer, 0, 1)