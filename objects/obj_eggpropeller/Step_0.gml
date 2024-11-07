//scr_collision()
//vsp += grv
if place_meeting(x, y, par_player)
{
	var _p = instance_place(x, y, par_player)
	if _p.killmove
	{
		with _p
		{
			if hitstun == 0
			{
				hitstunvars = 
				{
					x: _p.x,
					y: _p.y,
					kill: true,
					killID: [other.id]
				}
				hitstun = 5
			}
		}
	}
}
if distance_to_object(obj_player1) < 32 * 10 && point_distance(0, obj_player1.y, 0, y) < 32 * 4
{
	x = approach(x, obj_player1.x, 1)
	attacking = true
	y = approach(y, obj_player1.y, 1)
	if obj_player1.x != x
			xscale = sign(obj_player1.x - x)
}
if animation_end() && sprite_index = spr_eggcop_attackingstart
	image_speed = 0