levels = []
array_push(levels,[]) // 3 pages
array_push(levels,[])
add_level = function(_title, _room, _page, _islevel = true) // create a level
{
	array_push(levels[_page], 
	{
		islevel: _islevel,
		title: _title,
		room_info: [_room, "A"],
	})
}
add_level("Overgrown Zone", overgrown_1, 0)
add_level("Junkyard Beach", junk_1, 0)
add_level("Terrorist Town", roadway_1, 0) // roadway
add_level("Test", rm_test, 1)

selected = [0, 0]
active = true
scrollY = 0