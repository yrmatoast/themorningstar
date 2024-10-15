global.saveroom = ds_list_create()
hsp = 0
vsp = 0
grounded = false
movespeed = 0
grv = 0.5
attributes =
{
	noise: [
	[0.5, 0.25],//gravity [normal, cape]
	[0.35, 12, 16]],//speeds [accel, min, max]
	bruit: [
	[0.4, 0.15],
	[0.45, 14, 19]],
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

slope_momentum = function()
{
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
