repeat(4)
{
	instance_create_depth(x + 16, y + 16, -5, obj_debris).sprite_index = spr_destroyable_debris
}
event_play_oneshot3d("event:/Sfx/breakcrate", x, y)