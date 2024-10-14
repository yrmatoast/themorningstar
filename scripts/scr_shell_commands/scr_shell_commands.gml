global.rooms = []
for (var i = 0; room_exists(i); i++)
{
	global.rooms[i] = room_get_name(i)
}

function meta_goto_room ()
{
	return
	{
		arguments: ["room", "door"],
		suggestions: [
		global.rooms, ["A", "B", "C", "D", "E", "S"]
		],
		description: "teleports player into specified room.",
	}
}

function sh_goto_room(args)
{
	with obj_player
	{
		targetRoom = asset_get_index(args[1])
		targetDoor = args[2]
		hallway = false
		with instance_create_depth(x, y, 0, obj_fadeout)
			targetRoom = other.targetRoom
	}
}