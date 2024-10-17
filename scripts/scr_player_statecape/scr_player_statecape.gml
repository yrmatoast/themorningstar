// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_cape(){
	hsp = movespeed * xscale
	if animation_end() && get_sprite("capestart")
		set_sprite("cape", 0)
	if animation_end() && get_sprite("capefallstart")
		set_sprite("capefall", 0)
	if vsp > 0 && (get_sprite("capestart") || get_sprite("cape")) && char == "N"
	{
		set_sprite("capefallstart", 0)
		grv = grav
	}
	if vsp > 0 && char == "M" && !hasflew
	{
		grv = cape
		hasflew = true
	}
	if key_jump2 && char == "M"
	{
		state = states.capepound
		vsp = -20
		sprite_index = spr_monster_capepound
		grv = grav
	}
	if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope)
	{
		state = states.wallslide
		vsp = -abs(hsp)
		scr_soundeffect_3d(sfx_wallslide, x, y)
	}
	if jumpstop == false && !key_jump
	{
		jumpstop = true
		hasflew = true
		vsp /= 40
		grv = grav
	}
	if grounded
		{
		instance_create_depth(x, y, 5, obj_basicparticle, {
			sprite_index: spr_landeffect
		})
		grv = grav
		state = states.running
		set_sprite("runland", 0)
		scr_soundeffect_3d(sfx_land, x, y)
	}
	if key_down2 && sprite_index != spr_noise_forkdive && char == "N"
	{
		set_sprite("forkdive", 0)
		vsp = 15
		scr_soundeffect_3d(sfx_dive, x, y)
		state = states.fork
	}
}

function scr_player_capepound()
{
	if get_sprite("capepound")
	{
		hsp = approach(hsp, movespeed * xscale, move != 0 ? 4 : 1)
		if move != 0
		{
			xscale = move
			movespeed = 10
		}
		else
			movespeed = 0
		if grounded
		{
			set_sprite("capepoundslam", 0)
			obj_camera.shake = 20
		}
		vsp += 1
	}
	if get_sprite("capepoundslam")
	{
		if animation_end()
		{
			set_sprite("idle")
			state = states.normal
		}
	}
}