// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_runningjump(){
	image_speed = 0.35
	hsp = approach(hsp, movespeed * xscale, 1)
	if movespeed <= speeds[1]
	{
		if move != 0
		{
			xscale = move
			movespeed = speeds[1]
		}
		else
			movespeed = 0
	}
	if jumpanim == true
	{
		if movespeed > speeds[1] || (get_sprite("fork") || get_sprite("forkstart"))
			set_sprite("longjump", 0)
		else
			set_sprite("runjump", 0)
		jumpanim = false
	}
		if animation_end() && get_sprite("longjump")
			set_sprite("longjumpend", 0)
		if animation_end() && get_sprite("runjump")
			set_sprite("runfall", 0)
	if grounded
	{
		instance_create_depth(x, y, 5, obj_basicparticle, {
			sprite_index: spr_landeffect
		})
		state = states.running
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