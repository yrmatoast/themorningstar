with obj_player1
{
	grav = grav
	if y < other.y - (other.bbox_top - other.bbox_bottom)
	vsp = -20
	else
	vsp = 10
	state = states.bounce
}