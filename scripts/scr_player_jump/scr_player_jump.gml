// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_jump()
{
	image_speed = 0.35
	if get_sprite("jump") || get_sprite("fall")
	{
		hsp = approach(hsp, movespeed * xscale, 2)
		if move != 0
		{
			xscale = move
			movespeed = 10
		}
		else
			movespeed = 0
	}
	else
	{
		hsp = approach(hsp, movespeed * move, 2)
		if move != 0
			movespeed = 10
		else
			movespeed = 0
	}
	if animation_end() && get_sprite("jump")
		set_sprite("fall")
	if animation_end() && get_sprite("backflip")
			set_sprite("backflipfall")
	if grounded
	{
		instance_create_depth(x, y, 5, obj_basicparticle, {
			sprite_index: spr_landeffect
		})
		state = states.normal
		movespeed = abs(hsp)
		set_sprite("land", 0)
		event_play_oneshot3d("event:/Sfx/land", x, y)
	}
	if jumpstop == false && !key_jump && vsp < grav
	{
		jumpstop = true
		vsp /= 20
	}
	if key_down2 && sprite_index != spr_noise_forkdive && char == "N"
	{
		set_sprite("forkdive", 0)
		vsp = 15
		state = states.fork
		movespeed = abs(movespeed)
		event_play_oneshot3d("event:/Sfx/dive", x, y)
	}
	do_monsterjump()
}

function scr_player_bounce()
{
	image_speed = 0.35
	set_sprite("bounce")
	hsp = approach(hsp, movespeed * xscale, 2)
	if move != 0
	{
		xscale = move
		movespeed = 10
	}
	else
		movespeed = 0
	if grounded && !place_meeting(x, y + 1, obj_spike)
	{
		instance_create_depth(x, y, 5, obj_basicparticle, {
			sprite_index: spr_landeffect
		})
		state = states.normal
		movespeed = abs(hsp)
		set_sprite("land", 0)
		event_play_oneshot3d("event:/Sfx/land", x, y)
	}
	else if place_meeting(x, y + 1, obj_spike)
		vsp = -15
}