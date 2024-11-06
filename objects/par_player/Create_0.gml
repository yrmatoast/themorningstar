global.saveroom = ds_list_create()
global.followerlist = ds_list_create()
global.hp = 4
global.collect = 0
global.level = ""
global.timervisible = true
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
	death,
}
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
__ti_initinput()

killmove = false
hitstunvars = 
{
	x: x,
	y: y,
	kill: false,
	killID: []
}
hitstun = 0
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
font_add_enable_aa(false)
global.bigfont = font_add_sprite_ext(spr_font, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ!¡¿?.1234567890:ÁÄÃÀÂÉÈÊËÍÌÎÏÓÖÕÔÒÚÙÛÜÇ+", true, 0)
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
