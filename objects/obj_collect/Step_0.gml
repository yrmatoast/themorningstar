if (distance_to_object(obj_player) < 40)
    gotoplayer = 1
if gotoplayer
{
    var point = point_direction(x, y, obj_player.x, obj_player.y)
    x += lengthdir_x(movespeed, point)
    y += lengthdir_y(movespeed, point)
    movespeed += 1
}