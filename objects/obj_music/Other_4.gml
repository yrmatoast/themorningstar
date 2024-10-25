if (!ds_list_empty(music_details))
	{
		for (var i = 0; i < ds_list_size(music_details); i++)
		{
			var q = ds_list_find_value(music_details, i)
			if is_string(q.roomtoset)
				var _room = string_letters(room_get_name(room))
			else
				var _room = room
			if _room == q.roomtoset
			{
				if q.music.regular != currentmusic
				{
					if event_isplaying(music)
					{
						fmod_event_stop(music, false)
						music = -4
					}
					music = event_play_oneshot(q.music.regular)
					currentmusic = fmod_event_getEventPath(music)
					func = q.func
				}
			}
		}
	}