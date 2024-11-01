// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_fork()
{
	image_speed = 0.35
	hsp = movespeed * xscale
	if animation_end() && get_sprite("forkstart")
		set_sprite("fork", 0)
	if get_sprite("fork") || get_sprite("forkstart")
	{
		slope_momentum()
		movespeed = approach(movespeed, 0, 0.1)
		if key_jump && grounded
		{
			if movespeed < 12
				timers.run = 30
			grv = grav
			jumpstop = false
			vsp = -13
			jumpanim = true
			state = states.runningjump
			event_play_oneshot3d("event:/Sfx/jump", x, y)
			instance_create_depth(x, y + 5, 5, obj_basicparticle, {
			sprite_index: spr_jumpcloud
			})
		}
		if movespeed <= 0 || scr_solid(hsp, -1)
		{
			grv = grav
			movespeed = 0
			state = states.normal
			set_sprite("skidend", 0)
		}
	}
	if get_sprite("forkdive")
	{
		grv = grav
		if grounded
		{
			set_sprite("forkstart", 0)
			event_play_oneshot3d("event:/Sfx/slide", x, y)
		}
	}
}