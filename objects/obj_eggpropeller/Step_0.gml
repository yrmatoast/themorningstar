//scr_collision()
//vsp += grv
if place_meeting(x, y, obj_player) && obj_player.killmove
{
	if global.hitstun == 0
	{
		obj_player.hitstunvars = 
		{
			x: obj_player.x,
			y: obj_player.y,
			kill: true,
			killID: [id]
		}
		global.hitstun = 5
		if obj_player.key_jump
			obj_player.vsp = -5
	}
}
if distance_to_object(obj_player) < 32 * 10 && point_distance(0, obj_player.y, 0, y) < 32 * 4
{
	x = approach(x, obj_player.x, 1)
	attacking = true
	y = approach(y, obj_player.y, 1)
	if obj_player.x != x
			xscale = sign(obj_player.x - x)
}
if animation_end() && sprite_index = spr_eggcop_attackingstart
	image_speed = 0