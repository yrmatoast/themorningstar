// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_skidding()
{
	image_speed = 0.35
	hsp = movespeed * xscale
	grv = grav
	movespeed = approach(movespeed, 0, 0.40)
	if !get_sprite("runskid")
		set_sprite("runskid", 0)
	if animation_end() && get_sprite("runskid") && char == "M" && grounded
	{
		image_index = 2
	}
	if animation_end() && get_sprite("runskid") && !grounded
	{
		jumpstop = false
		jumpanim = true
		state = states.runningjump
	}
	if movespeed == 0 && grounded
	{
		movespeed = 0
		state = states.normal
		set_sprite("skidend", 0)
	}
	if (move != xscale && move != 0) && grounded && timers.turn == 0
	{
		set_sprite("turn", 0)
		state = states.running
		xscale = move
		movespeed = 0
		timers.run = 60
	}
	if key_jump && grounded && move != xscale && move != 0
	{
		xscale = move
		instance_create_depth(x, y + 5, 5, obj_basicparticle, {
			sprite_index: spr_jumpcloud
		})
		vsp = -17
		event_play_oneshot3d("event:/Sfx/jump", x, y)
		set_sprite("backflip", 0)
		state = states.jump
		jumpstop = false
	}
	timers.turn = approach(timers.turn, 0, 1)
}