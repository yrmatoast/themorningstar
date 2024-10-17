// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_wallslide()
{
	hsp = 0
	grv = 0.25
	image_speed = 0.4
	if move != xscale && move != 0
	{
		set_sprite("fall", 0)
		state = states.jump
		grv = grav
		vsp = 0
	}
	if vsp > 0
		set_sprite("wallslidedown")
	else
		set_sprite("wallslide")
	if !scr_solid(xscale, 0) && vsp < 0
	{
		set_sprite("jump", 0)
		state = states.jump
		grv = grav
		vsp = -10
		jumpstop = true
	}
	else
	{
		if key_jump2
		{
			state = states.walljump
			xscale *= -1
			movespeed = 12
			vsp = -12
			set_sprite("bounce", 0)
			instance_create_depth(x, y + 5, 5, obj_basicparticle, {
			sprite_index: spr_jumpcloud,
			image_angle: -90 * xscale,
			})
			scr_soundeffect_3d(sfx_jump, x, y)
		}
	}
	if grounded
	{
		set_sprite("land", 0)
		state = states.jump
		grv = grav
	}
}

function scr_player_walljump()
{
	grv = grav
	hsp = approach(hsp, movespeed * xscale, 4)
	if move != 0
	{
		xscale = move
		movespeed = 10
	}
	if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope)
	{
		state = states.wallslide
		vsp = -abs(movespeed)
		scr_soundeffect_3d(sfx_wallslide, x, y)
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
		scr_soundeffect_3d(sfx_dive, x, y)
		state = states.fork
	}
}