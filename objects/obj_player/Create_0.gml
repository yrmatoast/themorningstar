hsp = 0
vsp = 0
grounded = false
movespeed = 0
grv = 0.5
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