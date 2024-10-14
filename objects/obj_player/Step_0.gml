vsp += grv
scr_collision()
if mouse_check_button(mb_left)
{
	x = mouse_x;
	y = mouse_y;
}
if keyboard_check_pressed(vk_f1)
	game_restart()
if global.hitstun == 0
{
	__ti_input()
	var move = key_left + key_right;
	timers.step = approach(timers.step, 0, 1)
	if get_sprite("runmax")
	{
		if timers.step == 0
		{
			scr_soundeffect_3d(sfx_step, x, y)
			timers.step = 5
		}
	}
	if get_sprite("run")
	{
		if timers.step == 0
		{
			scr_soundeffect_3d(sfx_step, x, y)
			timers.step = 7
		}
	}
	switch state
	{
		case states.walljump:
			grv = 0.5
			hsp = movespeed * xscale
			if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope)
			{
				state = states.wallslide
				vsp = -abs(hsp)
				scr_soundeffect_3d(sfx_wallslide, x, y)
			}
			if grounded
			{
				set_sprite("land", 0)
				state = states.jump
				grv = 0.5
			}
			if key_down2 && !get_sprite("forkdive")
			{
				set_sprite("forkdive", 0)
				vsp = 15
				scr_soundeffect_3d(sfx_dive, x, y)
				state = states.fork
			}
			break
		case states.wallslide:
			hsp = 0
			grv = 0.25
			image_speed = 0.4
			if vsp > 0
				set_sprite("wallslidedown")
			else
				set_sprite("wallslide")
			if !place_meeting(x + sign(xscale), y, obj_solid)
			{
				set_sprite("jump", 0)
				state = states.jump
				grv = 0.5
				vsp = vsp
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
				grv = 0.5
			}
			break
		case states.fork:
			hsp = movespeed * xscale
			if animation_end() && get_sprite("forkstart")
				set_sprite("fork", 0)
			if get_sprite("fork") || get_sprite("forkstart")
			{
				slope_momentum()
				movespeed = approach(movespeed, 0, 0.1)
				if key_jump && grounded
				{
					grv = 0.5
					jumpstop = false
					vsp = -13
					jumpanim = true
					state = states.runningjump
					scr_soundeffect_3d(sfx_jump, x, y)
					instance_create_depth(x, y + 5, 5, obj_basicparticle, {
					sprite_index: spr_jumpcloud
				})
				}
				if movespeed == 0 || (place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope))
				{
					grv = 0.5
					movespeed = 0
					state = states.normal
					set_sprite("skidend", 0)
				}
			}
			if get_sprite("forkdive")
			{
				grv = 0.5
				if grounded
				{
					if !key_down
					{
						instance_create_depth(x, y, 5, obj_basicparticle, {
							sprite_index: spr_landeffect
						})
						if move != 0
						{
							grv = 0.5
							state = states.running
							set_sprite("runland", 0)
							scr_soundeffect_3d(sfx_land, x, y)
						}
						else
						{
							grv = 0.5
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
			break
		case states.cape:
			hsp = movespeed * xscale
			if animation_end() && get_sprite("capestart")
				set_sprite("cape", 0)
			if animation_end() && get_sprite("capestart")
			{
				set_sprite("capefall", 0)
			}
			if vsp > 0 && (get_sprite("capestart") || get_sprite("cape"))
			{
				set_sprite("capefallstart", 0)
				grv = 0.5
			}
			if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope)
			{
				state = states.wallslide
				vsp = -abs(hsp)
				scr_soundeffect_3d(sfx_wallslide, x, y)
			}
			if jumpstop == false && !key_jump && vsp < 0.5
			{
				jumpstop = true
				vsp /= 20
			}
			if grounded
			{
				instance_create_depth(x, y, 5, obj_basicparticle, {
					sprite_index: spr_landeffect
				})
				grv = 0.5
				state = states.running
				set_sprite("runland", 0)
				scr_soundeffect_3d(sfx_land, x, y)
			}
			if key_down2 && sprite_index != spr_noise_forkdive
			{
				set_sprite("forkdive", 0)
				vsp = 15
				scr_soundeffect_3d(sfx_dive, x, y)
				state = states.fork
			}
			break
		case states.skidding:
			hsp = movespeed * xscale
			grv = 0.5
			movespeed = approach(movespeed, 0, 1 / 1.5)
			if !get_sprite("runskid")
				set_sprite("runskid", 0)
			if movespeed == 0 && grounded
			{
				if (move != xscale && move != 0)
				{
					movespeed = 0
					set_sprite("turn", 0)
					state = states.running
					xscale = move
					timers.run = 60
				}
				else
				{
					movespeed = 0
					state = states.normal
					set_sprite("skidend", 0)
				}
			}
			break
		case states.runningjump:
			hsp = movespeed * xscale
			if jumpanim == true
			{
				if movespeed > 12 || (get_sprite("fork") || get_sprite("forkstart"))
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
			if jumpstop == false && !key_jump && vsp < 0.5
			{
				jumpstop = true
				vsp /= 20
			}
			if key_down2 && sprite_index != spr_noise_forkdive
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
			break
		case states.running:
			slope_momentum()
			hsp = movespeed * xscale
			var targetspeed = 12
			if timers.run <= 0
				targetspeed = char == "N" ? 16 : 19
			if animation_end() && (get_sprite("runstart") || get_sprite("runland") || get_sprite("turn"))
				set_sprite("run")
			if movespeed > 14 && get_sprite("run")
				set_sprite("runmax")
			if movespeed < targetspeed
				movespeed = approach(movespeed, targetspeed, 0.40)
			if key_jump && grounded
			{
				instance_create_depth(x, y + 5, 5, obj_basicparticle, {
					sprite_index: spr_jumpcloud
				})
				if movespeed > 12
				{
					jumpstop = false
					vsp = -15
					grv = 0.25
					set_sprite("capestart", 0)
					jumpanim = true
					state = states.cape
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
			if (move == 0) && grounded
			{
				state = states.skidding
				scr_soundeffect_3d(sfx_break, x, y)
			}
			if (move != xscale && move != 0) && grounded
			{
				movespeed = 0
				set_sprite("turn", 0)
				xscale = move
				timers.run = 60
			}
			if key_down2
			{
				set_sprite("forkstart", 0)
				if movespeed < 12
					movespeed = 12
				state = states.fork
				scr_soundeffect_3d(sfx_slide, x, y)
			}
			if (place_meeting(x + sign(hsp), y - 1, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope))
			{
				grv = 0.5
				movespeed = 0
				state = states.normal
				set_sprite("skidend", 0)
			}
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
			break
		case states.normal:
			hsp = movespeed * xscale
			if animation_end() && (get_sprite("land") || get_sprite("skidend"))
				set_sprite("idle", 0)
			if move != 0
			{
				state = states.running
				set_sprite("runstart", 0)
				timers.run = 60
			}
			else
			{
				movespeed = 0
				if !get_sprite("idle") && !get_sprite("land") && !get_sprite("skidend")
					set_sprite("idle")
			}
			if !grounded
			{
				set_sprite("fall")
				state = states.jump
			}
			if key_jump && grounded
			{
				instance_create_depth(x, y + 5, 5, obj_basicparticle, {
					sprite_index: spr_jumpcloud
				})
				vsp = -15
				scr_soundeffect_3d(sfx_jump, x, y)
				set_sprite("jump", 0)
				state = states.jump
				jumpstop = false
			}
			if key_down
			{
				set_sprite("forkstart", 0)
				if movespeed < 14
					movespeed = 14
				state = states.fork
				scr_soundeffect_3d(sfx_slide, x, y)
			}
			break
		case states.jump:
			hsp = approach(hsp, movespeed * xscale, 2)
			if move != 0
			{
				xscale = move
				movespeed = 10
			}
			else
				movespeed = 0
			if animation_end() && get_sprite("jump")
				set_sprite("fall")
			if grounded
			{
				instance_create_depth(x, y, 5, obj_basicparticle, {
					sprite_index: spr_landeffect
				})
				state = states.normal
				set_sprite("land", 0)
				scr_soundeffect_3d(sfx_land, x, y)
			}
			if jumpstop == false && !key_jump && vsp < 0.5
			{
				jumpstop = true
				vsp /= 20
			}
			if key_down2 && sprite_index != spr_noise_forkdive
			{
				set_sprite("forkdive", 0)
				vsp = 15
				state = states.fork
				scr_soundeffect_3d(sfx_dive, x, y)
			}
			break
	}
	if place_meeting(x + hsp, y + vsp, obj_destroyable) &&
	state == states.running ||
	state == states.fork
	{
		with instance_place(x + hsp, y + vsp, obj_destroyable)
			instance_destroy()
	}
}
else
{
	global.hitstun = approach(global.hitstun, 0, 1)
	x = hitstunvars.x + random_range(-5, 5)
	y = hitstunvars.y + random_range(-5, 5)
	image_speed = 0
	if (global.hitstun <= 0)
	{
		x = hitstunvars.x;
		y = hitstunvars.y;
		image_speed = 0.35
		for (var i = 0; i < array_length(hitstunvars.killID); i++;)
		{
			if (instance_exists(hitstunvars.killID[i]))
			{
				instance_destroy(hitstunvars.killID[i]);
				i--;
			}
		}
	}
}

if state == states.fork
	killmove = true
else
	killmove = false