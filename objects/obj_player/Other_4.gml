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
roomstartx = x
roomstarty = y
hallway = false
depth = 0
with obj_noisette_follow
{
	ds_queue_clear(followqueue)
	gx = obj_player.x
	gy = obj_player.y
	x = gx
	y = gy
}
global.Bswitch = 1
