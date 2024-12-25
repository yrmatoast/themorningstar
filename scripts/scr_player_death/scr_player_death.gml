// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_death(){
	obj_music.pitch = 0.4
	if timers.death > 0
	{
		timers.death = approach(timers.death, 0, 1)
		x = hitstunvars.x + random_range(-10, 10)
		y = hitstunvars.y + random_range(-10, 10)
	}
	else
	{
		obj_camera.lock = true
		if !dying
		{
			dying = true
			vsp = -10
		}
		else
		{
			rot += 30
			xs_cale = approach(xs_cale, 0, 1 / 100)
			ys_cale = approach(ys_cale, 0, 1 / 100)
			y += vsp
			vsp += 0.2
			if xs_cale == 0
			{
				with obj_player1
				{
					global.hp = 4
					global.collect = 0
					room = rm_levelselect
					targetDoor = "A"
					state = states.normal
					ds_list_clear(global.saveroom)
					hsp = 0
					vsp = 0
					xs_cale = 1
					ys_cale = 1
					rot = 0
					movespeed = 0
					char = "N"
					obj_camera.lock = false
				}
			}
		}
	}
}