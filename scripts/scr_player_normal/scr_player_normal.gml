function scr_player_normal()
{
	image_speed = 0.35
	hsp = movespeed * xscale
	if animation_end() && (get_sprite("land") || get_sprite("skidend"))
		set_sprite("idle", 0)
	if move != 0 && !scr_solid(move, 0)
	{
		state = states.running
		set_sprite("runstart", 0)
		timers.run = 30
	}
	else
	{
		movespeed = 0
		if !get_sprite("idle") && !get_sprite("land") && !get_sprite("skidend")
			set_sprite("idle")
	}
	if !grounded
	{
		set_sprite("fall")
		state = states.jump
	}
	if key_jump && grounded && !scr_solid(0, 0)
	{
		instance_create_depth(x, y + 5, 5, obj_basicparticle, {
			sprite_index: spr_jumpcloud
		})
		vsp = -15
		event_play_oneshot3d("event:/Sfx/jump", x, y)
		set_sprite("jump", 0)
		state = states.jump
		jumpstop = false
	}
	if key_down && !scr_solid(move + xscale, 0)
	{
		set_sprite("forkstart", 0)
		if movespeed < 14
			movespeed = 14
		state = states.fork
		event_play_oneshot3d("event:/Sfx/slide", x, y)
	}
}