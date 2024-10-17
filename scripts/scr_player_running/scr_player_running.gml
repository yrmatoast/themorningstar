// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_running(){
	hsp = movespeed * xscale
	var targetspeed = speeds[1]
	if timers.run <= 0
		var targetspeed = speeds[2]
	if animation_end() && (get_sprite("runstart") || get_sprite("runland") || get_sprite("turn"))
		set_sprite("run")
	if movespeed > speeds[1] && get_sprite("run")
		set_sprite("runmax")
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
	}
	else
	{
		if movespeed < targetspeed
			movespeed = approach(movespeed, targetspeed, speeds[0])
		else if char == "N" && targetspeed >= speeds[2]
			movespeed = approach(movespeed, 19, 0.01)
	}
	if key_jump && grounded
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
			scr_soundeffect_3d(sfx_highjump, x, y)
		}
		else
		{
			jumpstop = false
			vsp = -13
			jumpanim = true
			state = states.runningjump
			scr_soundeffect_3d(sfx_jump, x, y)
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
		scr_soundeffect_3d(sfx_break, x, y)
	}
	if key_down2 && char == "N"
	{
		set_sprite("forkstart", 0)
		if movespeed < 12
			movespeed = 12
		state = states.fork
		scr_soundeffect_3d(sfx_slide, x, y)
	}
	if scr_solid(sign(hsp), 0) && !scr_sloped() && grounded
	{
		grv = grav
		movespeed = 0
		state = states.normal
		set_sprite("skidend", 0)
	}
	if get_sprite("run")
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