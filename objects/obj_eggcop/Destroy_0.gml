if ds_list_find_index(global.saveroom, id) == -1
{
	event_play_oneshot3d("event:/Sfx/enemykill", x, y)
	instance_create_depth(x, y, -1, obj_deadpart).hsp = xscale * -15
	ds_list_add(global.saveroom, id)
}