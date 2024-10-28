if place_meeting(x, y, obj_player) && !active
{
	active = true
	obj_player.state = -4
	obj_player.hsp = 0
	obj_player.vsp = 0
	obj_player.x = -3500
	playerx = obj_player.x
	playery = obj_player.y
	intro_snd = event_play_oneshot3d("event:/Sfx/junkintro", x, y)
	fmod_event_setPause(obj_music.music, true)
	playerfunc = function()
	{
		with obj_player
		{
			vsp = 0
			hsp = 0
			x += 26
			y = other.playery
			visible = true
			fmod_event_set3DPosition(other.intro_snd, other.x, other.y, 0)
			if fmod_event_getTimelinePosition(other.intro_snd) == 02.527
			{
				x = other.playerx
				y = other.playery
				grav = grav
				movespeed = 20
				xscale = 1
				hsp = xscale * movespeed
				vsp = -20
				state = states.bounce
				instance_destroy(other)
				fmod_event_setPause(obj_music.music, false)
			}
		}
	}
}