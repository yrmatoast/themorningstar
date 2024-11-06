scr_collision()
vsp += grv
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
					x: x,
					y: y,
					kill: true,
					killID: [other.id]
				}
				hitstun = 5
			}
		}
	}
}
if distance_to_object(instance_nearest(x, y, par_player)) < 32 * 10 && point_distance(0, instance_nearest(x, y, par_player).y, 0, y) < 32 * 4
{
	if !attacking
	{
		attacking = true
		if obj_player.x != x
			xscale = sign(obj_player.x - x)
		sprite_index = spr_eggcop_attackingstart
		image_index = 0
	}
}
if running
{
	if obj_player.x != x
		xscale = sign(obj_player.x - x)
	hsp = approach(hsp, xscale * 10, 0.5)
	if scr_solid(xscale, 0)
		instance_destroy()
}
if animation_end() && sprite_index = spr_eggcop_attackingstart
{
	image_speed = 0
	if running != true
	{
		running = true
	}
}