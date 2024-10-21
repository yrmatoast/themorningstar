__ti_input()
if active
{
	var page = selected[1]
	var sel = selected[0]
	if key_down2
	{
		selected[0]++
	}
	if key_up2
		selected[0]--
	selected[0] = clamp(selected[0], 0, array_length(levels[page]) - 1)
	if 40 * sel > WINDOW_HEIGHT / 7
			scrollY = lerp(scrollY, 40 * sel - WINDOW_HEIGHT / 7, 0.2)
		else
			scrollY = lerp(scrollY, 0, 0.2)
	var move = key_left2 + key_right2;
	if move != 0
		selected[1] += 1 * move
	selected[1] = clamp(selected[1], 0, array_length(levels) - 1)
	if key_jump2 == active && levels[page][sel].islevel = true
	{
		active = false
		obj_player.targetRoom = levels[page][sel].room_info[0]
		obj_player.targetDoor = levels[page][sel].room_info[1]
		obj_player.hallway = false
		with instance_create_depth(x, y, 0, obj_fadeout)
			targetRoom = obj_player.targetRoom
		instance_create_depth(x, y, -5, obj_leveltitle).text = string_upper(levels[page][sel].title)
	}
}