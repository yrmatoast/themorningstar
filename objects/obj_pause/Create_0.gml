pause = false
selected = 0
pausearr = []
exiting = false
exitarr = []
screensprite = -4
guisprite = -4
array_push(exitarr, {
	title: "YES",
	color: c_red,
	func: function()
	{
		obj_pause.exiting = false
		obj_pause.pause = false
		fmod_event_setPause_all(false)
		instance_activate_all()
		with obj_player
		{
			global.hp = 4
			global.collect = 0
			room = rm_levelselect
			targetDoor = "A"
			state = states.normal
			ds_list_clear(global.saveroom)
			hsp = 0
			vsp = 0
			movespeed = 0
			xs_cale = 1
			ys_cale = 1
			rot = 0
			char = "N"
			obj_camera.lock = false
		}
	},
})
array_push(exitarr, {
	title: "NO",
	color: c_white,
	func: function()
	{
		obj_pause.selected = 1
		obj_pause.exiting = false
	},
})

array_push(pausearr, {
	title: "Resume",
	color: c_white,
	func: function()
	{
		obj_pause.pause = false
		fmod_event_setPause_all(false)
		instance_activate_all()
		
	},
})

array_push(pausearr, {
	title: "Options",
	color: c_white,
	func: function()
	{
		obj_pause.pause = false
		instance_create_depth(0, 0, obj_pause.depth - 1, obj_options)
	},
})

array_push(pausearr, {
	title: "Exit Level",
	color: c_white,
	func: function()
	{
		obj_pause.exiting = true
		obj_pause.selected = 0
	},
})
depth = -800