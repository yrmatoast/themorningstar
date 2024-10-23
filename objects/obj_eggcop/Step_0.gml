scr_collision()
vsp += grv
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
	}
}
if distance_to_object(obj_player) < 32 * 10 && point_distance(0, obj_player.y, 0, y) < 32 * 4
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