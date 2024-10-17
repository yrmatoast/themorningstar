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
}
state = states.normal
timers = 
{
	run: 0,
	step: 0,
	steppart: 0,
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

slope_momentum = function()
{
	var att = char == "N" ? attributes.noise : attributes.bruit
	var _speed = att[1][2]
	if place_meeting(x, y + 1, obj_slope)
	{
		var _obj = instance_place(x, y + 1, obj_slope)
		if sign(_obj.image_xscale) != xscale
			movespeed += 0.4
		else
			movespeed -= 0.2
		movespeed = clamp(movespeed, 6, 24)
	}
}
