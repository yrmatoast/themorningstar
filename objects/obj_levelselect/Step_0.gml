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
	var _checkpoint = string("{0} Checkpoints", levels[page][sel].title)
	if key_taunt2 && load_quick(true, _checkpoint, "general_currentroom") != -4
	{
		ini_key_delete(_checkpoint, "general_currentroom")
	}
	if key_jump2 == active && levels[page][sel].islevel = true
	{
		active = false
		obj_player.hallway = false
		global.level = levels[page][sel].title
		if load_quick(true, _checkpoint, "general_currentroom") != -4
		{
			obj_player.targetRoom = load_quick(true, _checkpoint, "general_currentroom")
			obj_player.char = load_quick(false, _checkpoint, "player_char")
			obj_player.targetDoor = [load_quick(true, _checkpoint, "player_x"), load_quick(true, _checkpoint, "player_y")]
			global.hp = load_quick(true, _checkpoint, "player_hp")
			global.collect = load_quick(true, _checkpoint, "player_collectables")
			global.saveroom = load_quick(true, _checkpoint, "general_saveroom")
		}
		else
		{
			obj_player.targetRoom = levels[page][sel].room_info[0]
			obj_player.targetDoor = levels[page][sel].room_info[1]
		}
		with instance_create_depth(x, y, 0, obj_fadeout)
			targetRoom = obj_player.targetRoom
		instance_create_depth(x, y, -5, obj_leveltitle).text = string_upper(levels[page][sel].title)
	}
}