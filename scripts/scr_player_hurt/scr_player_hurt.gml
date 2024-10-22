// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_hurt()
{
	grav = grav
	hsp = movespeed * xscale
	if grounded
	{
		state = states.normal
		movespeed = 0
		set_sprite("idle", 0)
	}
}