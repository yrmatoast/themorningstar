function scr_player_runningjump()
{
	var _mvsp = movespeed * xscale
	if movespeed <= 12
	{
		var _mvsp = movespeed * move
		if move != 0
			movespeed = 12
		else
			movespeed = 0
		if hsp != 0
			xscale = sign(hsp)
	}
	image_speed = 0.35
	hsp = approach(hsp, _mvsp, 0.5)
	if movespeed > speeds[1]
	{
		if timers.blur == 0
		{
			create_blur_afterimage(sprite_index, image_index, x, y, xscale)
			timers.blur = 4
		}
		timers.blur = approach(timers.blur, 0, 1)
	}
	if jumpanim == true
	{
		if movespeed > speeds[1] || (get_sprite("fork") || get_sprite("forkstart"))
			set_sprite("longjump", 0)
		else
			set_sprite("runjump", 0)
		jumpanim = false 
	}
	if vsp >= 0 && get_sprite("longjump")
		set_sprite("longjumpendstart", 0)
	if animation_end() && get_sprite("longjumpendstart")
		set_sprite("longjumpend", 0)
	if animation_end() && get_sprite("runjump")
		set_sprite("runfall", 0)
	if grounded
	{
		instance_create_depth(x, y, 5, obj_basicparticle, {
			sprite_index: spr_landeffect
		})
		state = states.running
		if get_sprite("longjump") || get_sprite("longjumpend") || get_sprite("longjumpendstart")
			set_sprite("run", 0)
		else
			set_sprite("runland", 0)
		event_play_oneshot3d("event:/Sfx/land", x, y)
		movespeed = abs(hsp)
	}
	if jumpstop == false && !key_jump && vsp < grav
	{
		jumpstop = true
		vsp /= 20
	}
	if key_down2 && sprite_index != spr_noise_forkdive && char != "M"
	{
		set_sprite("forkdive", 0)
		vsp = 15
		state = states.fork
		event_play_oneshot3d("event:/Sfx/dive", x, y)
	}
	do_wallslide()
	do_monsterjump()
}