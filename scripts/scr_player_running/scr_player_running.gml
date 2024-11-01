// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_running(){
	grav = grav
	if get_sprite("runmax")
		image_speed = 0.4
	else
		image_speed = 0.35
	hsp = movespeed * xscale
	var targetspeed = speeds[1]
	if timers.run <= 0
		var targetspeed = speeds[2]
	if animation_end() && (get_sprite("runstart") || get_sprite("runland") || get_sprite("turn"))
		set_sprite("run")
	if movespeed > speeds[1] && get_sprite("run")
		set_sprite("runmax")
	if grounded
	{
		if (move != xscale && movespeed <= speeds[1])
		{
			movespeed = approach(movespeed, 0, 0.40)
			if movespeed == 0
			{
				grv = grav
				movespeed = 0
				state = states.normal
				set_sprite("skidend", 0)
			}
			if (move != xscale && move != 0) && grounded
			{
				movespeed = 0
				set_sprite("turn", 0)
				xscale = move
				timers.run = 60
			}
			if animation_end() && get_sprite("run")
				set_sprite("runskid", 0)
			if animation_end() && get_sprite("runskid") && char == "M"
			{
				image_index = 2
			}
		}
		else
		{
			slope_momentum(0.2, 0.1)
			if get_sprite("runskid")
				set_sprite("run")
			if movespeed < targetspeed
				movespeed = approach(movespeed, targetspeed, speeds[0])
		}
	}
	if movespeed > speeds[1] && timers.run > 0
		timers.run = 0
	if key_jump && grounded
	{
		if move != 0 && move != xscale || get_sprite("turn")
		{
			xscale = move
			instance_create_depth(x, y + 5, 5, obj_basicparticle, {
				sprite_index: spr_jumpcloud
			})
			vsp = -17
			event_play_oneshot3d("event:/Sfx/jump", x, y)
			set_sprite("backflip", 0)
			state = states.jump
			jumpstop = false
		}
		else
		{
			instance_create_depth(x, y + 5, 5, obj_basicparticle, {
				sprite_index: spr_jumpcloud
			})
			if movespeed > speeds[1]
			{
				jumpstop = false
				if char == "N"
				{
					vsp = -15
					grv = cape
				}
				else
				{
					vsp = -14
					grv = grav
				}
				set_sprite("capestart", 0)
				jumpanim = true
				state = states.cape
				hasflew = false
				event_play_oneshot3d("event:/Sfx/capejump", x, y)
			}
			else
			{
				jumpstop = false
				vsp = -13
				jumpanim = true
				state = states.runningjump
				event_play_oneshot3d("event:/Sfx/jump", x, y)
			}
		}
	}
	if !grounded
	{
		jumpstop = false
		jumpanim = false
		state = states.runningjump
		if get_sprite("runmax")
			set_sprite("longjumpend")
		else
			set_sprite("runfall")
	}
	if animation_end() && get_sprite("jump")
		set_sprite("fall")
	if (move == 0 || move != xscale) && grounded && movespeed > speeds[1]
	{
		movespeed = movespeed > speeds[2] ? speeds[2] : speeds[1]
		state = states.skidding
		event_play_oneshot3d("event:/Sfx/runend", x, y)
		timers.turn = 15
	}
	if key_down2 
	{
		set_sprite("forkstart", 0)
		if movespeed < 12
			movespeed = 12
		state = states.fork
		event_play_oneshot3d("event:/Sfx/slide", x, y)
	}
	if scr_solid(sign(hsp), 0) && !scr_sloped() && grounded
	{
		grv = grav
		movespeed = 0
		state = states.normal
		set_sprite("skidend", 0)
	}
	if get_sprite("run") && grounded
		timers.run = approach(timers.run, 0, 1)
	if timers.steppart == 0
	{
		instance_create_depth(x, y + 32, 5, obj_basicparticle, {
			sprite_index: spr_movementcloud,
			image_xscale: xscale
		})
		timers.steppart = 15
	}
	timers.steppart = approach(timers.steppart, 0, 1)
}