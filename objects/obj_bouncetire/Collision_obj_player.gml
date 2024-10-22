with obj_player
{
	grav = grav
	if y < other.bbox_top + 5
	vsp = -20
	else
	vsp = 10
	state = states.bounce
}