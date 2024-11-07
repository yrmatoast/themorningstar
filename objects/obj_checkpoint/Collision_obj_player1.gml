if !activated && ds_list_find_index(global.saveroom, id) == -1
{
	activated = true
	sprite_index = spr_checkpoint_activated
	event_play_oneshot("event:/Sfx/checkpoint")
	ds_list_add(global.saveroom, id)
	var save = []
	array_push(save, {
		name: "player_x",
		val: obj_player1.x
	})
	array_push(save, {
		name: "player_y",
		val: obj_player1.y
	})
	array_push(save, {
		name: "player_hp",
		val: global.hp
	})
	array_push(save, {
		name: "player_collectables",
		val: global.collect
	})
	array_push(save, {
		name: "player_char",
		val: obj_player1.char
	})
	array_push(save, {
		name: "general_saveroom",
		val: ds_list_write(global.saveroom)
	})
	array_push(save, {
		name: "general_currentroom",
		val: room
	})
	array_push(save, {
		name: "general_time",
		val: global.timer
	})
	instance_create_depth(x + 50, y - 10, obj_player1.depth - 1, obj_timepopup)
	save_quick(string("{0} Checkpoints", global.level), save)
}