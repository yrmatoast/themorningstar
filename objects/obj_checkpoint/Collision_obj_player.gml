if !activated && ds_list_find_index(global.saveroom, id) == -1
{
	activated = true
	sprite_index = spr_checkpoint_activated
	ds_list_add(global.saveroom, id)
	var save = []
	array_push(save, {
		name: "player_x",
		val: obj_player.x
	})
	array_push(save, {
		name: "player_y",
		val: obj_player.y
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
		val: obj_player.char
	})
	array_push(save, {
		name: "general_saveroom",
		val: global.saveroom
	})
	array_push(save, {
		name: "general_currentroom",
		val: room
	})
	save_quick(string("{0} Checkpoints", global.level), save)
}