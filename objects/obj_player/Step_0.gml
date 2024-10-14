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
	if sprite_index == spr_noise_runmax
	{
		if timers.step == 0
		{
			scr_soundeffect_3d(sfx_step, x, y)
			timers.step = 5
		}
	}
	if sprite_index == spr_noise_run
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
			}
			if grounded
			{
				sprite_index = spr_noise_land
				state = states.jump
				grv = 0.5
			}
			if key_down2 && sprite_index != spr_noise_forkdive
			{
				sprite_index = spr_noise_forkdive
				image_index = 0
				vsp = 15
				scr_soundeffect_3d(sfx_dive, x, y)
				state = states.fork
			}
			break
		case states.wallslide:
			hsp = 0
			grv = 0.25
			sprite_index = spr_noise_wallslide
			image_speed = 0.4
			if !place_meeting(x + sign(xscale), y, obj_solid)
			{
				sprite_index = spr_noise_jump
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
					sprite_index = spr_player_bounce
					instance_create_depth(x, y + 5, 5, obj_basicparticle, {
					sprite_index: spr_jumpcloud,
					image_angle: -90 * xscale,
					})
					scr_soundeffect_3d(sfx_jump, x, y)
				}
			}
			if grounded
			{
				sprite_index = spr_noise_land
				state = states.jump
				grv = 0.5
			}
			break
		case states.fork:
			hsp = movespeed * xscale
			if animation_end() && sprite_index == spr_noise_forkstart
				sprite_index = spr_noise_fork
			if sprite_index == spr_noise_fork || sprite_index == spr_noise_forkstart
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
					sprite_index = spr_noise_skidend
					image_index = 0
				}
			}
			if sprite_index = spr_noise_forkdive
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
							sprite_index = spr_noise_runland
							image_index = 0
							scr_soundeffect_3d(sfx_land, x, y)
						}
						else
						{
							grv = 0.5
							state = states.normal
							sprite_index = spr_noise_idle
							image_index = 0
							scr_soundeffect_3d(sfx_land, x, y)
						}
					}
					else
					{
						sprite_index = spr_noise_forkstart
						image_index = 0
						scr_soundeffect_3d(sfx_slide, x, y)
					}
				}
			}
			break
		case states.cape:
			hsp = movespeed * xscale
			if animation_end() && sprite_index == spr_noise_capestart
				sprite_index = spr_noise_cape
			if animation_end() && sprite_index == spr_noise_capefallstart
			{
				sprite_index = spr_noise_capefall
				image_index = 0
			}
			if vsp > 0 && (sprite_index == spr_noise_capestart || sprite_index == spr_noise_cape)
			{
				sprite_index = spr_noise_capefallstart
				image_index = 0
				grv = 0.5
			}
			if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope)
			{
				state = states.wallslide
				vsp = -abs(hsp)
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
				sprite_index = spr_noise_runland
				image_index = 0
				scr_soundeffect_3d(sfx_land, x, y)
			}
			if key_down2 && sprite_index != spr_noise_forkdive
			{
				sprite_index = spr_noise_forkdive
				image_index = 0
				vsp = 15
				scr_soundeffect_3d(sfx_dive, x, y)
				state = states.fork
			}
			break
		case states.skidding:
			hsp = movespeed * xscale
			grv = 0.5
			movespeed = approach(movespeed, 0, 1 / 1.5)
			if sprite_index != spr_noise_runskid
				sprite_index = spr_noise_runskid
			if movespeed == 0 && grounded
			{
				if (move != xscale && move != 0)
				{
					movespeed = 0
					sprite_index = spr_noise_turn
					state = states.running
					image_index = 0
					xscale = move
					timers.run = 80
				}
				else
				{
					movespeed = 0
					state = states.normal
					sprite_index = spr_noise_skidend
					image_index = 0
				}
			}
			break
		case states.runningjump:
			hsp = movespeed * xscale
			if jumpanim == true
			{
				if movespeed > 12 || (sprite_index == spr_noise_fork || sprite_index == spr_noise_forkstart)
					sprite_index = spr_noise_longjump
				else
					sprite_index = spr_noise_runjump
				image_index = 0
				jumpanim = false
			}
			if animation_end() && sprite_index == spr_noise_longjump
				sprite_index = spr_noise_longjumpend
			if animation_end() && sprite_index == spr_noise_runjump
				sprite_index = spr_noise_runfall
			if grounded
			{
				instance_create_depth(x, y, 5, obj_basicparticle, {
					sprite_index: spr_landeffect
				})
				state = states.running
				sprite_index = spr_noise_runland
				image_index = 0
				scr_soundeffect_3d(sfx_land, x, y)
			}
			if jumpstop == false && !key_jump && vsp < 0.5
			{
				jumpstop = true
				vsp /= 20
			}
			if key_down2 && sprite_index != spr_noise_forkdive
			{
				sprite_index = spr_noise_forkdive
				image_index = 0
				vsp = 15
				state = states.fork
				scr_soundeffect_3d(sfx_dive, x, y)
			}
			if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope)
			{
				state = states.wallslide
				vsp = -abs(hsp)
			}
			break
		case states.running:
			slope_momentum()
			hsp = movespeed * xscale
			var targetspeed = 12
			if timers.run <= 0
				targetspeed = 16
			if animation_end() && (sprite_index == spr_noise_runstart || sprite_index == spr_noise_runland || sprite_index == spr_noise_turn)
				sprite_index = spr_noise_run
			if movespeed > 14 && sprite_index == spr_noise_run
				sprite_index = spr_noise_runmax
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
					sprite_index = spr_noise_capestart
					image_index = 0
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
				if sprite_index == spr_noise_runmax
					sprite_index = spr_noise_longjumpend
				else
					sprite_index = spr_noise_runfall
			}
			if animation_end() && sprite_index == spr_noise_jump
				sprite_index = spr_noise_fall
			if (move == 0) && grounded
			{
				state = states.skidding
				scr_soundeffect_3d(sfx_break, x, y)
			}
			if (move != xscale && move != 0) && grounded
			{
				movespeed = 0
				sprite_index = spr_noise_turn
				image_index = 0
				xscale = move
				timers.run = 60
			}
			if key_down2
			{
				sprite_index = spr_noise_forkstart
				image_index = 0
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
				sprite_index = spr_noise_skidend
				image_index = 0
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
			if animation_end() && (sprite_index == spr_noise_land || sprite_index == spr_noise_skidend)
				sprite_index = spr_noise_idle
			if move != 0
			{
				state = states.running
				sprite_index = spr_noise_runstart
				image_index = 0
				timers.run = 80
			}
			else
			{
				movespeed = 0
				if sprite_index != spr_noise_idle && sprite_index != spr_noise_land && sprite_index != spr_noise_skidend
					sprite_index = spr_noise_idle
			}
			if !grounded
			{
				sprite_index = spr_noise_fall
				state = states.jump
			}
			if key_jump && grounded
			{
				instance_create_depth(x, y + 5, 5, obj_basicparticle, {
					sprite_index: spr_jumpcloud
				})
				vsp = -15
				scr_soundeffect_3d(sfx_jump, x, y)
				sprite_index = spr_noise_jump
				image_index = 0
				state = states.jump
				jumpstop = false
			}
			if key_down
			{
				sprite_index = spr_noise_forkstart
				image_index = 0
				if movespeed < 14
					movespeed = 14
				state = states.fork
				scr_soundeffect_3d(sfx_slide, x, y)
			}
			break
		case states.jump:
			hsp = movespeed * xscale
			if move != 0
			{
				xscale = move
				movespeed = 10
			}
			else
				movespeed = 0
			if animation_end() && sprite_index == spr_noise_jump
				sprite_index = spr_noise_fall
			if grounded
			{
				instance_create_depth(x, y, 5, obj_basicparticle, {
					sprite_index: spr_landeffect
				})
				state = states.normal
				sprite_index = spr_noise_land
				image_index = 0
				scr_soundeffect_3d(sfx_land, x, y)
			}
			if jumpstop == false && !key_jump && vsp < 0.5
			{
				jumpstop = true
				vsp /= 20
			}
			if key_down2 && sprite_index != spr_noise_forkdive
			{
				sprite_index = spr_noise_forkdive
				image_index = 0
				vsp = 15
				state = states.fork
				scr_soundeffect_3d(sfx_dive, x, y)
			}
			break
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