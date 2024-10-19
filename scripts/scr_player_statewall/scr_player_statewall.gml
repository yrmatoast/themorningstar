// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_wallslide()
{
	image_speed = 0.35
	hsp = 0
	grv = 0.25
	image_speed = 0.4
	if vsp > 0
		set_sprite("wallslidedown")
	else
		set_sprite("wallslide")
	if !scr_solid(xscale, 0)
	{
		set_sprite("jump", 0)
		state = states.jump
		grv = grav
		jumpstop = true
	}
	if grounded
	{
		set_sprite("land", 0)
		state = states.jump
		grv = grav
	}
	if key_jump2
	{
		state = states.walljump
		xscale *= -1
		movespeed = 8
		vsp = -12
		set_sprite("bounce", 0)
		instance_create_depth(x, y + 5, 5, obj_basicparticle, {
		sprite_index: spr_jumpcloud,
		image_angle: -90 * xscale,
		})
		event_play_oneshot3d("event:/Sfx/jump", x, y)
	}
}


function scr_player_walljump()
{
	grv = grav
	hsp = approach(hsp, movespeed * xscale, 1)
	if move != 0
	{
		xscale = move
		movespeed = 8
	}
	if place_meeting(x + sign(xscale), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope)
	{
		state = states.wallslide
		vsp = -abs(movespeed)
		event_play_oneshot3d("event:/Sfx/wallslide", x, y)
	}
	if grounded
	{
		set_sprite("land", 0)
		state = states.jump
		grv = grav
	}
	if key_down2 && !get_sprite("forkdive") && char == "N"
	{
		set_sprite("forkdive", 0)
		vsp = 15
		event_play_oneshot3d("event:/Sfx/dive", x, y)
		state = states.fork
	}
}