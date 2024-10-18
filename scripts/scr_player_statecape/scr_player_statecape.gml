// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_cape(){
	image_speed = 0.35
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
	do_monsterjump()
	if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope)
	{
		state = states.wallslide
		vsp = -movespeed
		event_play_oneshot3d("event:/Sfx/wallslide", x, y)
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
		event_play_oneshot3d("event:/Sfx/land", x, y)
	}
	if key_down2 && sprite_index != spr_noise_forkdive && char == "N"
	{
		set_sprite("forkdive", 0)
		vsp = 15
		event_play_oneshot3d("event:/Sfx/dive", x, y)
		state = states.fork
	}
}

function scr_player_capepound()
{
	image_speed = 0.35
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
			with obj_destroyable
			{
				if point_distance(other.x, other.y, x, y) < 32 * 6
					instance_destroy()
			}
			with obj_eggcop
			{
				if point_distance(other.x, other.y, x, y) < 32 * 6
					instance_destroy()
			}
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