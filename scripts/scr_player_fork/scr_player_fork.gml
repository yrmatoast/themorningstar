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
			grv = grav
			jumpstop = false
			vsp = -13
			jumpanim = true
			state = states.runningjump
			scr_soundeffect_3d(sfx_jump, x, y)
			instance_create_depth(x, y + 5, 5, obj_basicparticle, {
			sprite_index: spr_jumpcloud
			})
		}
		if movespeed <= 0 || scr_solid(hsp, 0)
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
			if !key_down
			{
				instance_create_depth(x, y, 5, obj_basicparticle, {
					sprite_index: spr_landeffect
				})
				if move != 0
				{
					grv = grav
					state = states.running
					set_sprite("runland", 0)
					scr_soundeffect_3d(sfx_land, x, y)
					timers.run = 30
				}
				else
				{
					grv = grav
					state = states.normal
					set_sprite("idle", 0)
					scr_soundeffect_3d(sfx_land, x, y)
				}
			}
			else
			{
				set_sprite("forkstart", 0)
				scr_soundeffect_3d(sfx_slide, x, y)
			}
		}
	}
}