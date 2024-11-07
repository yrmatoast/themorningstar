if global.hp != 6
{
	if (distance_to_object(obj_player1) < 40)
	    gotoplayer = 1
	if gotoplayer
	{
	    var point = point_direction(x, y, obj_player1.x, obj_player1.y)
	    x += lengthdir_x(movespeed, point)
	    y += lengthdir_y(movespeed, point)
	    movespeed += 1
	}
	image_alpha = 1
}
else
	image_alpha = 0.3