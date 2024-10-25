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
	{
		selected[1] += 1 * move
		selected[0] = 0
	}
	selected[1] = clamp(selected[1], 0, array_length(levels) - 1)
	var _checkpoint = string("{0} Checkpoints", levels[page][sel].title)
	if key_taunt2 && load_quick(true, _checkpoint, "general_currentroom") != -4
	{
		var save = []
		ini_open(obj_savesystem.file)
		array_push(save, "player_y")
		array_push(save, "player_x")
		array_push(save, "player_hp")
		array_push(save, "player_collectables")
		array_push(save, "player_char")
		array_push(save, "general_saveroom")
		array_push(save, "general_currentroom")
		for (var i = 0; i < array_length(save); i++)
		{
			if ini_key_exists(_checkpoint, save[i])
				ini_key_delete(_checkpoint, save[i])
		}
		ini_close()
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
			ds_list_read(global.saveroom, load_quick(false, _checkpoint, "general_saveroom"))
			obj_camera.collect = global.collect
		}
		else
		{
			obj_player.targetRoom = levels[page][sel].room_info[0]
			obj_player.targetDoor = levels[page][sel].room_info[1]
			obj_camera.collect = 0
			global.collect = 0
			global.hp = 4
		}
		with instance_create_depth(x, y, 0, obj_fadeout)
			targetRoom = obj_player.targetRoom
		instance_create_depth(x, y, -5, obj_leveltitle).text = string_upper(levels[page][sel].title)
	}
}