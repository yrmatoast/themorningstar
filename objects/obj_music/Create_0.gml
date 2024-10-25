music = -4
music_details = ds_list_create()
muID = -4
currentmusic = ""
prevmuID = muID
lock = false
function music_add(_room, _music, _func = -4) // add the music to a room buuh
{
	var _mu = 
	{
		roomtoset: _room,
		music: 
		{
			regular: _music,
		},
		func:  _func
	}
	ds_list_add(music_details, _mu)
	return _mu;
}

function music_stop()
{
	with obj_music
	{
		if event_isplaying(music)
		{
			fmod_event_stop(music, false)
			music = -4
		}
	}
}
music_add(rm_levelselect, -4)
music_add(junk_1, "event:/Music/junk")
music_add(overgrown_1, "event:/Music/zone")
func = -4