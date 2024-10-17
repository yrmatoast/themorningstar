if vsp < 20
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
grav = att[0][0]
cape = att[0][1]
speeds = [att[1][0], att[1][1], att[1][2]]
if global.hitstun == 0
{
	__ti_input()
	move = key_left + key_right;
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
		case states.bounce:
			scr_player_bounce()
			break
		case states.capepound:
			scr_player_capepound()
			break
		case states.walljump:
			scr_player_walljump()
			break
		case states.wallslide:
			scr_player_wallslide()
			break
		case states.fork:
			scr_player_fork()
			break
		case states.cape:
			scr_player_cape()
			break
		case states.skidding:
			scr_player_skidding()
			break
		case states.runningjump:
			scr_player_runningjump()
			break
		case states.running:
			scr_player_running()
			break
		case states.normal:
			scr_player_normal()
			break
		case states.jump:
			scr_player_jump()
			break
	}
	if place_meeting(x + hsp, y + vsp, obj_destroyable) &&
	state == states.running ||
	state == states.fork ||
	state == states.capepound
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
|| (state == states.running && char != "N" && movespeed > speeds[1])
|| (state == states.cape && char != "N" && movespeed > speeds[1])
|| state == states.capepound
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