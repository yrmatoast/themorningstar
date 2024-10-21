if global.hp != 6
{
	if (distance_to_object(obj_player) < 40)
	    gotoplayer = 1
	if gotoplayer
	{
	    var point = point_direction(x, y, obj_player.x, obj_player.y)
	    x += lengthdir_x(movespeed, point)
	    y += lengthdir_y(movespeed, point)
	    movespeed += 1
	}
	image_alpha = 1
}
else
	image_alpha = 0.3