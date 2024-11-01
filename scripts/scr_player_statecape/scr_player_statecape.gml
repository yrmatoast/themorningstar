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
	do_wallslide()
	if timers.steppart == 0
	{
		instance_create_depth(x + random(10), y + random(10), 5, obj_basicparticle, {
			sprite_index: spr_capeparticle,
		})
		timers.steppart = 6
	}
	timers.steppart = approach(timers.steppart, 0, 1)
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
		if movespeed < 12
			timers.run = 30
		set_sprite("runland", 0)
		event_play_oneshot3d("event:/Sfx/land", x, y)
	}
	if key_down2 && sprite_index != spr_noise_forkdive && char != "M"
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
			if poundcharge < 30
			{
				set_sprite("capepoundslam", 0)
				obj_camera.shake = 20
			}
			else
			{
				event_play_oneshot3d("event:/Sfx/slamhitground", x, y)
				set_sprite("capepoundslam", 0)
				obj_camera.shake = 50
				with obj_destroyable
				{
					if point_distance(other.x, other.y, x, y) < 32 * 8
						instance_destroy()
				}
				with par_baddie
				{
					if point_distance(other.x, other.y, x, y) < 32 * 8
						instance_destroy()
				}
			}
			poundcharge = 0
		}
		if timers.blur == 0 && poundcharge >= 30
		{
			create_blur_afterimage(sprite_index, image_index, x, y, xscale)
			timers.blur = 4
		}
		timers.blur = approach(timers.blur, 0, 1)
		vsp += 1
		if vsp >= 0
			poundcharge++
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