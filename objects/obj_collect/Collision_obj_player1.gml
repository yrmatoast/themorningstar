if global.hp != 6
{
	instance_destroy()
	obj_camera.create_collect(sprite_index, x, y)
	global.collect += 1
	event_play_oneshot3d("event:/Sfx/collect", x, y)
	ds_list_add(global.saveroom, id)
}