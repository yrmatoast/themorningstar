if !activated && ds_list_find_index(global.saveroom, id) == -1
{
	activated = true
	sprite_index = spr_checkpoint_activated
	ds_list_add(global.saveroom, id)
}