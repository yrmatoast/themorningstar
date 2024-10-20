global.saveroom = ds_list_create()
global.followerlist = ds_list_create()
global.hp = 4
global.collect = 0
global.Bswitch = 1
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
enum states
{
	normal,
	jump,
	running,
	runningjump,
	skidding,
	cape,
	fork,
	wallslide,
	walljump,
	capepound,
	bounce,
	hurt,
}
state = states.normal
timers = 
{
	run: 0,
	step: 0,
	steppart: 0,
	turn: 0,
}

jumpanim = false
jumpstop = false
__ti_initinput()

killmove = false
hitstunvars = 
{
	x: x,
	y: y,
	kill: false,
	killID: []
}
global.hitstun = 0
targetRoom = -4
targetDoor = "A"
hallway = false
hallwaydirection = 1

roomstartx = x
roomstarty = y
char = "N"
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
	if _vsp < movespeed
		_vsp = _vsp
	if place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope)
	{
		state = states.wallslide
		vsp = _vsp
		event_play_oneshot3d("event:/Sfx/wallslide", x, y)
	}
}

iframe = 0
machsnd = fmod_createEventInstance("event:/Sfx/sprinting");
