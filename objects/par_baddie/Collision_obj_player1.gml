if !other.killmove && attacking && other.iframe <= 0 && other.state != states.death
{
	with other
	{
		state = states.hurt 
		vsp = -10
		iframe = 60 * 2
		movespeed = 10 * -xscale
		set_sprite("hurt")
		event_play_oneshot3d("event:/Sfx/hurt", x, y)
		obj_music.pitch = 0.75
		global.hp -= 1
		alarm[0] = 3
	}
}