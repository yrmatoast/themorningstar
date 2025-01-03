if is_string(targetDoor)
{
	var _door = asset_get_index("obj_door" + targetDoor)
	if instance_exists(_door)
	{
		if hallway != 2
		{
			var pad = hallway ? (32 * 6) * hallwaydirection : 16
			x = _door.x + pad
			y = _door.y - 14
		}
		else
		{
			x = _door.x + 16 + savedpos
			y = _door.y - (32 * 6) * hallwaydirection
			vsp = savedspd
		}
	}
}
else
{
	x = targetDoor[0]
	y = targetDoor[1]
}
roomstartx = x
roomstarty = y
hallway = false
depth = 0
with obj_noisette_follow
{
	ds_queue_clear(followqueue)
	gx = obj_player1.x
	gy = obj_player1.y
	x = gx
	y = gy
}
if instance_exists(obj_player2)
{
	with obj_player2
	{
		x = other.x
		y = other.y
	}
}
