var xx = obj_player1.x
var yy = obj_player1.y
var xscale = obj_player1.xscale
ds_queue_enqueue(followqueue, xx)
ds_queue_enqueue(followqueue, yy)
ds_queue_enqueue(followqueue, xscale)
if ds_queue_size(followqueue) > (lag * pos)
{
	gx = ds_queue_dequeue(followqueue)
	gy = ds_queue_dequeue(followqueue)
	realscale = ds_queue_dequeue(followqueue)
}
if spot == false
{
	image_xscale = realscale
	x = approach(x, gx - 25 * image_xscale * pos, 32)
	y = approach(y, gy, 16)
}
if ds_list_find_index(global.followerlist, id) == -1
	instance_destroy()
if ogx != x
{
	sprite_index = spr_walk
	ogx = x
}
else
	sprite_index = spr_idle
if instance_exists(obj_noisettespot)
{
	var inst = instance_nearest(obj_player1.x, obj_player1.y, obj_noisettespot)
	if point_distance(obj_player1.x, 0, inst.x, 0) < 32 * 19 && point_distance(0, obj_player1.y, 0, inst.y) <= 32 * 6
	{
		spot = true
		x = approach(x, inst.x, 64)
		y = approach(y, inst.y, 64)
		spottype = inst.spot
		if obj_player1.x != x 
			image_xscale = sign(obj_player1.x - x)
		if place_meeting(x, y, obj_player1) && x = inst.x && y = inst.y
		{
			if sprite_index == spr_idle
			{
				switch spottype
				{
					case spots.bounce:
						with obj_player1
						{
							grav = grav
							vsp = -20
							state = states.bounce
						}
						break
				}
			}
		}
	}
	else
		spot = false

}
else
	spot = false