x += hsp
y += vsp
vsp += 0.5
if place_meeting(x, y, par_solid) && image_speed = 0.35
{
	image_speed = 0
	vsp = choose(-5, -10)
}