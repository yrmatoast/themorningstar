// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_jump()
{
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
		hsp = approach(hsp, movespeed, 2)
		if move != 0
			movespeed = 10 * xscale
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
		movespeed = abs(movespeed)
		set_sprite("land", 0)
		scr_soundeffect_3d(sfx_land, x, y)
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
		scr_soundeffect_3d(sfx_dive, x, y)
	}
}