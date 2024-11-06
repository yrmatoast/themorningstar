hsp = 0
vsp = 0
grounded = false
movespeed = 0
grv = 0.5
attributes =
{
	noise:
		[
		[0.5, 0.25],
		//gravity [normal, cape]
		[0.40, 12, 16]
		],
		//speeds [accel, min, max]
	bruit:
		[
		[0.5, 0.04],
		[0.40, 12, 19]
		],
}
image_speed = 0.35
depth = 0
xscale = 1
xs_cale = 1
ys_cale = 1
rot = 0
state = states.normal
timers = 
{
	run: 0,
	step: 0,
	steppart: 0,
	turn: 0,
	blur: 0,
	death: 0,
}
dying = false
jumpanim = false
jumpstop = false
killmove = false
hitstunvars = 
{
	x: x,
	y: y,
	kill: false,
	killID: []
}
targetRoom = -4
targetDoor = "A"
hallway = false
hallwaydirection = 1

roomstartx = x
roomstarty = y
char = "M"
hasflew = false
savedspd = 0
savedpos = 0
slope_momentum = function(_accel = 0.4, _daccel = 0.2, _max = 24)
{
	if place_meeting(x, y + 1, obj_slope)
	{
		var _obj = instance_place(x, y + 1, obj_slope)
		if sign(_obj.image_xscale) != xscale
			movespeed += _accel
		else
			movespeed -= _daccel
		movespeed = clamp(movespeed, 6, _max)
	}
}

do_monsterjump = function()
{
	if key_jump2 && char == "M"
	{
		poundcharge = 0
		state = states.capepound
		vsp = -20
		sprite_index = spr_monster_capepound
		grv = grav
		event_play_oneshot3d("event:/Sfx/dive", x, y)
	}
}

do_wallslide = function()
{
	var _vsp = -movespeed
	if vsp > 0
		_vsp = 0
	if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope) && move != 0 && move == xscale
	{
		state = states.wallslide
		vsp = _vsp
		event_play_oneshot3d("event:/Sfx/wallslide", x, y)
	}
}

iframe = 0
machsnd = fmod_createEventInstance("event:/Sfx/sprinting");

poundcharge = 0

key_left = false
key_left2 = false
	
key_right = false
key_right2 = false
	
key_down = false
key_down2 = false
	
key_up = false
key_up2 = false
	
key_jump = false
key_jump2 = false
	
key_slap = false
key_slap2 = false
	
key_attack = false
key_attack2 = false
	
key_taunt = false
key_taunt2 = false
	
key_start = false
key_start2 = false
jumptim = 0
fakestate = states.normal
hitstun = 0
chasing_enemy = false
amt_jumps = 0
