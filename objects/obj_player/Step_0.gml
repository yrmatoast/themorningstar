vsp += grv
scr_collision()
if mouse_check_button(mb_left)
{
	x = mouse_x;
	y = mouse_y;
}
if keyboard_check_pressed(vk_f1)
	game_restart()
var att = char == "N" ? attributes.noise : attributes.bruit
var grav = att[0][0]
var cape = att[0][1]
var speeds = [att[1][0], att[1][1], att[1][2]]
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
			grv = grav
			hsp = approach(hsp, movespeed * xscale, 4)
			if move != 0
			{
				xscale = move
				movespeed = 10
			}
			if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope)
			{
				state = states.wallslide
				vsp = -abs(movespeed)
				scr_soundeffect_3d(sfx_wallslide, x, y)
			}
			if grounded
			{
				set_sprite("land", 0)
				state = states.jump
				grv = grav
			}
			if key_down2 && !get_sprite("forkdive") && char == "N"
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
			if key_down2
			{
				set_sprite("fall", 0)
				state = states.jump
				grv = grav
				vsp = 0
			}
			if vsp > 0
				set_sprite("wallslidedown")
			else
				set_sprite("wallslide")
			if !place_meeting(x + sign(xscale), y, obj_solid)
			{
				set_sprite("jump", 0)
				state = states.jump
				grv = grav
				vsp = -10
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
				grv = grav
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
				if movespeed == 0 || (place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope))
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
			break
		case states.cape:
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
			if vsp > 0 && char == "M"
			{
				grv = cape
			}
			if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope)
			{
				state = states.wallslide
				vsp = -abs(hsp)
				scr_soundeffect_3d(sfx_wallslide, x, y)
			}
			if jumpstop == false && !key_jump && vsp < grav
			{
				jumpstop = true
				vsp /= 20
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
			break
		case states.skidding:
			hsp = movespeed * xscale
			grv = grav
			movespeed = approach(movespeed, 0, 1 / 2)
			if !get_sprite("runskid")
				set_sprite("runskid", 0)
			if movespeed == 0 && grounded
			{
				movespeed = 0
				state = states.normal
				set_sprite("skidend", 0)
			}
			if key_jump && grounded && move != xscale && move != 0
			{
				xscale = move
				instance_create_depth(x, y + 5, 5, obj_basicparticle, {
					sprite_index: spr_jumpcloud
				})
				vsp = -15
				scr_soundeffect_3d(sfx_jump, x, y)
				set_sprite("backflip", 0)
				state = states.jump
				jumpstop = false
			}
			break
		case states.runningjump:
			hsp = movespeed * xscale
			if movespeed < 10
				movespeed = approach(movespeed, 10, 2)
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
			break
		case states.running:
			slope_momentum()
			hsp = movespeed * xscale
			var targetspeed = speeds[1]
			if timers.run <= 0
				targetspeed = speeds[2]
			if animation_end() && (get_sprite("runstart") || get_sprite("runland") || get_sprite("turn"))
				set_sprite("run")
			if movespeed >= speeds[2] && get_sprite("run")
				set_sprite("runmax")
			if movespeed < targetspeed
				movespeed = approach(movespeed, targetspeed, speeds[0])
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
						vsp = -10
						grv = grav
					}
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
				if movespeed < 7
				{
					state = states.normal
					movespeed = 0
				}
				else
				{
					movespeed = movespeed > speeds[2] ? speeds[2] : speeds[1]
					state = states.skidding
					scr_soundeffect_3d(sfx_break, x, y)
				}
			}
			if (move != xscale && move != 0) && grounded
			{
				movespeed = 0
				set_sprite("turn", 0)
				xscale = move
				timers.run = 60
			}
			if key_down2 && char == "N"
			{
				set_sprite("forkstart", 0)
				if movespeed < 12
					movespeed = 12
				state = states.fork
				scr_soundeffect_3d(sfx_slide, x, y)
			}
			if (place_meeting(x + sign(hsp), y - 1, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope))
			{
				grv = grav
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
				timers.run = 75
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
			if key_down && char == "N"
			{
				set_sprite("forkstart", 0)
				if movespeed < 14
					movespeed = 14
				state = states.fork
				scr_soundeffect_3d(sfx_slide, x, y)
			}
			break
		case states.jump:
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
			{
				movespeed = 10 * xscale
			}
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
			break
	}
	if place_meeting(x + hsp, y + vsp * 2, obj_destroyable) &&
	state == states.running ||
	state == states.fork
	{
		with instance_place(x + hsp, y + vsp * 2, obj_destroyable)
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
|| (state == states.running && char != "N" && movespeed > speeds[1])
|| (state == states.cape && char != "N" && movespeed > speeds[1])
	killmove = true
else
	killmove = false
with par_solid
{
	if object_index != obj_destroyable && object_index != obj_spike
		visible = global.showcollisions
}
if keyboard_check_pressed(ord("S"))
	global.showcollisions = !global.showcollisions
global.hp = clamp(global.hp, 0, 6)
global.collect = clamp(global.collect, 0, 20)
if global.collect >= 20 && global.hp < 6
{
	global.collect = 0
	global.hp += 1
}