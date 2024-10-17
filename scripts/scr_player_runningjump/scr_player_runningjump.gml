// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_runningjump(){
	if timers.run > 0
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
		hsp = movespeed * xscale
	}
	if jumpanim == true
	{
		if movespeed > speeds[1] || (get_sprite("fork") || get_sprite("forkstart"))
			set_sprite("longjump", 0)
		else
			set_sprite("runjump", 0)
		jumpanim = false
	}
		if animation_end() && get_sprite("longjump")
			set_sprite("longjumpend", 0)
		if animation_end() && get_sprite("runjump")
			set_sprite("runfall", 0)
	if grounded
	{
		instance_create_depth(x, y, 5, obj_basicparticle, {
			sprite_index: spr_landeffect
		})
		state = states.running
		set_sprite("runland", 0)
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
		scr_soundeffect_3d(sfx_dive, x, y)
	}
	if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope)
	{
		state = states.wallslide
		vsp = -abs(hsp)
		scr_soundeffect_3d(sfx_wallslide, x, y)
	}
}