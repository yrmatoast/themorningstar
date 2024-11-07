if state != states.death
{
	if vsp < 20
		vsp += grv
	scr_collision()
}
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
var att = char == "N" ? attributes.noise : attributes.bruit
grav = att[0][0]
cape = att[0][1]
speeds = [att[1][0], att[1][1], att[1][2]]
if hitstun == 0
{
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
			image_speed = 0.35
			hsp = 0
			grv = 0.25
			image_speed = 0.4
			if vsp > 0
				set_sprite("wallslidedown")
			else
				set_sprite("wallslide")
			if !scr_solid(xscale, 0)
			{
				set_sprite("jump", 0)
				state = states.jump
				grv = grav
				jumpstop = false
				if vsp < -15
					vsp = -15
			}
			if grounded
			{
				set_sprite("land", 0)
				state = states.jump
				grv = grav
			}
			if key_jump
			{
				jumpstop = false
				state = states.walljump
				xscale *= -1
				movespeed = 10
				hsp = movespeed * xscale
				vsp = -12
				set_sprite("bounce", 0)
				instance_create_depth(x, y + 5, 5, obj_basicparticle, {
				sprite_index: spr_jumpcloud,
				image_angle: -90 * xscale,
				})
				event_play_oneshot3d("event:/Sfx/jump", x, y)
			}
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
		case states.death:
			scr_player_death()
			break
	}
	if global.hp == 0 && state != states.death
	{
		set_sprite("hurt")
		timers.death = 60
		dying = false
		state = states.death
		obj_player1.hitstunvars = 
		{
			x: obj_player1.x,
			y: obj_player1.y,
			kill: true,
			killID: [id]
		}
	}
	if state != states.death
	{
		if place_meeting(x + hsp, y + vsp + 1, obj_spike) && state != states.bounce && iframe <= 0
		{
			state = states.hurt 
			vsp = -10
			iframe = 60 * 2
			movespeed = 10 * -xscale
			set_sprite("hurt")
			event_play_oneshot3d("event:/Sfx/hurt", x, y)
			alarm[0] = 3
		}
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
	else if (state == states.cape && vsp < 0) || (state == states.fork && get_sprite("forkdive")) || state == states.capepound
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
	
	var _enemy = instance_nearest(x, y, par_baddie)
	if _enemy != -4
	{
		if point_distance(x, y, _enemy.x, _enemy.y) < 32 * 20
			chasing_enemy = true
		else
			chasing_enemy = false
	}
	else
		chasing_enemy = false
	if chasing_enemy == false
	{
		if point_distance(x, y, obj_player1.x, obj_player1.y) < 32 * 4
		{
			key_right = false
			key_left = false
		}
		else
		{
			if x < obj_player1.x
			{
				key_right = true
				key_left = 0
			}
			else if x > obj_player1.x
			{
				key_left = -1
				key_right = false
			}
		}
		key_down2 = false
	}
	else
	{
		if x < _enemy.x
			{
				key_right = true
				key_left = 0
			}
			else if x > _enemy.x
			{
				key_left = -1
				key_right = false
			}
		if point_distance(x, y, _enemy.x, _enemy.y) < 32 * 7
			key_down2 = true
		else
			key_down2 = false
		if _enemy.y < y
		{
			key_jump = true
			if vsp > 0
				key_jump2 = true
		}
	}
	if ((obj_player1.y < y
	&& point_distance(0, y, 0, obj_player1.y) > 32 * 4)
	|| (place_meeting(x + xscale, y - 1, obj_solid)
	&& !place_meeting(x + 32, y - (100 * 4), obj_solid))
	|| (state == states.wallslide 
	&& vsp > 0
	&& !place_meeting(x, y - 128, obj_solid)
	&& obj_player1.y < y))
	&& !place_meeting(x, y - 128, obj_solid) && amt_jumps < 6
	{
		key_jump = true
		jumptim = 20
		if grounded || state == states.wallslide
			amt_jumps++
	}
	else
	{
		if jumptim == 0
			key_jump = false
		key_jump2 = false
	}
	if point_distance(x, y, obj_player1.x, obj_player1.y) > 960
	{
		x = obj_player1.x
		y = obj_player1.y
	}
	if state != states.capepound 
	&& y < obj_player1.y
	&& point_distance(0, y, 0, obj_player1.y) > 32 * 32
	&& !grounded
	{
		key_jump2 = true
	}
	
	jumptim = approach(jumptim, 0, 1)
	if grounded
		amt_jumps = 0
	if obj_player1.char == "N"
		char = "M"
	else
		char = "N"
	
	
	
	
	
	
	
}
else
{
	hitstun = approach(hitstun, 0, 1)
	x = hitstunvars.x + random_range(-5, 5)
	y = hitstunvars.y + random_range(-5, 5)
	image_speed = 0
	if (hitstun <= 0)
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
|| (state == states.cape && movespeed > speeds[1])
|| state == states.capepound
	killmove = true
else
	killmove = false