enum optmenu{
	main,
	audio,
	video,
	game,
	
	//ANCHORS
	center,
	left,
	
	//BUTTON TYPES
	press,
	toggle,
	slider,
}

backgrounds = []
array_push(backgrounds, {
	index: 0,
	alpha: 1,
	scroll: 0,
})
array_push(backgrounds, {
	index: 1,
	alpha: 0,
	scroll: 0,
})
array_push(backgrounds, {
	index: 2,
	alpha: 0,
	scroll: 0,
})
array_push(backgrounds, {
	index: 3,
	alpha: 0,
	scroll: 0,
})


menu = 0
menus = []
selected = 0

create_menu = function(_menuid, _anchor, _ypad, _func)
{
	var _opt = 
	{
		menuid: _menuid,
		anchor: _anchor,
		ypad: _ypad,
		options: [],
		backfunc: _func
	}
	return _opt;
}

add_option_ext = function(_id, _type, _name, _function, _value = 0, _max = 0, _toggle = ["OFF", "ON"])
{
	var q = 
	{
		name: _name,
		func: _function,
		val: _value,
		toggle: _toggle,
		type: _type,
		max: _max
	}
	array_push(_id.options, q)
	return q;
}

goto_menu = function(_id)
{
	for (var i = 0; i < array_length(menus); i++)
	{
		var m = menus[i]
		if m.menuid == _id
			menu = i
	}
	selected = 0
}

var _main = create_menu(optmenu.main, optmenu.center, 48, function()
{
	instance_destroy()
})

add_option_ext(_main, optmenu.press, "AUDIO", function()
{
	goto_menu(optmenu.audio)
})

add_option_ext(_main, optmenu.press, "VIDEO", function()
{
	goto_menu(optmenu.video)
})

add_option_ext(_main, optmenu.press, "GAME", function()
{
	goto_menu(optmenu.game)
})

array_push(menus, _main)

var _audio = create_menu(optmenu.audio, optmenu.left, 48, function()
{
	goto_menu(optmenu.main)
})

add_option_ext(_audio, optmenu.press, "BACK", function()
{
	goto_menu(optmenu.main)
})
add_option_ext(_audio, optmenu.slider, "MASTER", function()
	{
		var m = menus[menu]
		var opt = m.options
		var q = opt[selected]
		global.MasterVolume = q.val / 100
		q.val = global.MasterVolume * 100
	}, global.MasterVolume * 100, 100)
add_option_ext(_audio, optmenu.slider, "MUSIC", function()
	{
		var m = menus[menu]
		var opt = m.options
		var q = opt[selected]
		global.MusicVolume = q.val / 100
		q.val = global.MusicVolume * 100
	}, global.MusicVolume * 100, 100)
add_option_ext(_audio, optmenu.slider, "SFX", function()
	{
		var m = menus[menu]
		var opt = m.options
		var q = opt[selected]
		global.SfxVolume = q.val / 100
		q.val = global.SfxVolume * 100
	}, global.SfxVolume * 100, 100)
add_option_ext(_audio, optmenu.toggle, "UNFOCUSED MUTE", function()
	{
		var m = menus[menu]
		var opt = m.options
		var q = opt[selected]
		global.unfocusedmute = q.val
		q.val = global.unfocusedmute
	}, global.unfocusedmute, 1)


array_push(menus, _audio)

var _video = create_menu(optmenu.video, optmenu.left, 48, function()
{
	goto_menu(optmenu.main)
})

add_option_ext(_video, optmenu.press, "BACK", function()
{
	goto_menu(optmenu.main)
})

add_option_ext(_video, optmenu.toggle, "FULLSCREEN", function()
	{
		var m = menus[menu]
		var opt = m.options
		var q = opt[selected]
		window_set_fullscreen(q.val)
		q.val = window_get_fullscreen()
	}, window_get_fullscreen(), 1)
add_option_ext(_video, optmenu.toggle, "RESOLUTION", function()
	{
		var m = menus[menu]
		var opt = m.options
		var q = opt[selected]
		var res = [[960, 540], [1280, 720]]
		window_set_size(res[q.val][0], res[q.val][1])
	}, 1, 1, ["960 X 540", "1280 X 720"])

array_push(menus, _video)

var _game = create_menu(optmenu.game, optmenu.left, 48, function()
{
	goto_menu(optmenu.main)
})

add_option_ext(_game, optmenu.press, "BACK", function()
{
	goto_menu(optmenu.main)
})


add_option_ext(_game, optmenu.toggle, "TIMER", function()
	{
		var m = menus[menu]
		var opt = m.options
		var q = opt[selected]
		global.timervisible = q.val
		q.val = global.timervisible
	}, global.timervisible, 1, ["OFF", "PER LEVEL"])

array_push(menus, _game)