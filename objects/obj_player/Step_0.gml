if vsp < 20
	vsp += grv
scr_collision()
fmod_listener_setPosition(0, x, y, 0)
if state == states.running && !get_sprite("runskid")
{
	fmod_event_setPause(machsnd, false);
	if !event_isplaying(machsnd)
		fmod_event_play(machsnd);
	var s = 0;
	if get_sprite("run")
		s = 1;
	else if get_sprite("runmax") || (get_sprite("runland") && movespeed > 12)
		s = 2;
	fmod_event_set3DPosition(machsnd, x, y, 0);
	fmod_event_setParameter(machsnd, "state", s, true);
}
else
	fmod_event_setPause(machsnd, true)
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
		case states.hurt:
			scr_player_hurt()
			break
	}
	if place_meeting(x + hsp, y + vsp + 1, obj_spike) && state != states.bounce && iframe <= 0
	{
		state = states.hurt 
		vsp = -10
		iframe = 60 * 2
		movespeed = 10 * -xscale
		set_sprite("hurt")
		event_play_oneshot3d("event:/Sfx/hurt", x, y)

		global.hp -= 1
		alarm[0] = 3
	}
	if state != states.hurt
		iframe = approach(iframe, 0, 1)
	if state == states.running || state == states.runningjump || (state == states.fork && !get_sprite("forkdive"))
	{
		if place_meeting(x + hsp, y, obj_destroyable)
		{
			with instance_place(x + hsp, y, obj_destroyable)
				instance_destroy()
		}
	}
	else if (state == states.cape && vsp < 0) || (state == states.fork && get_sprite("forkdive"))
	{
		if place_meeting(x + hsp, y + vsp, obj_destroyable)
		{
			with instance_place(x + hsp, y + vsp, obj_destroyable)
				instance_destroy()
		}
	}
	else if state == states.bounce
	{
		if place_meeting(x + hsp, y + vsp, obj_destroyable)
		{
			with instance_place(x + hsp, y + vsp, obj_destroyable)
			{
				instance_destroy()
				with other
				{
					vsp = -10
				}
			}
		}
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