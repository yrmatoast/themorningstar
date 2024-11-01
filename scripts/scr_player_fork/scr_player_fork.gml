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
		if timers.steppart == 0
		{
			instance_create_depth(x, y + 32, 5, obj_basicparticle, {
				sprite_index: spr_movementcloud,
				image_xscale: xscale
			})
			timers.steppart = 15
		}
		timers.steppart = approach(timers.steppart, 0, 1)
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
			instance_create_depth(x, y + 5, 5, obj_basicparticle, {
			sprite_index: spr_jumpcloud
			})
		}
		if key_down2 && sprite_index != spr_noise_forkdive && char != "M" && !grounded
		{
			set_sprite("forkdive", 0)
			vsp = 15
			event_play_oneshot3d("event:/Sfx/dive", x, y)
			state = states.fork
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
			if movespeed < 12
				movespeed = 12
			set_sprite("forkstart", 0)
			event_play_oneshot3d("event:/Sfx/slide", x, y)
		}
	}
}