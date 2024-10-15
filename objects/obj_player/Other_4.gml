var _door = asset_get_index("obj_door" + targetDoor)

if instance_exists(_door)
{
	var pad = hallway ? (32 * 6) * hallwaydirection : 16
	x = _door.x + pad
	y = _door.y - 14
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
