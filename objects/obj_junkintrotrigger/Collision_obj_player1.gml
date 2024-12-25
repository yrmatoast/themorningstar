if place_meeting(x, y, obj_player1) && !active
{
	playerx = obj_player1.x
	playery = obj_player1.y
	active = true
	obj_player1.state = -4
	obj_player1.hsp = 0
	obj_player1.vsp = 0
	obj_player1.x = -3500
	intro_snd = event_play_oneshot3d("event:/Sfx/junkintro", x, y)
	fmod_event_setPause(obj_music.music, true)
	playerfunc = function()
	{
		pos++
		fmod_event_setTimelinePosition(intro_snd, pos)
		with obj_player1
		{
			sprite_index = spr_noise_junk_intro
			vsp = 0
			hsp = 0
			x += 26.5
			y = other.playery
			visible = true
			fmod_event_set3DPosition(other.intro_snd, x, y, 0)
			if other.pos = 160
			{
				obj_camera.shake = 50
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