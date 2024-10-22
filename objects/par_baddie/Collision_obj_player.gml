if !other.killmove && attacking && other.iframe <= 0
{
	with other
	{
		state = states.hurt 
		vsp = -10
		iframe = 60 * 2
		movespeed = 10 * -xscale
		set_sprite("hurt")
		event_play_oneshot3d("event:/Sfx/hurt", x, y)

		global.hp -= 1
		alarm[0] = 3
	}
}