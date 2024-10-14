vsp += grv
scr_collision()
if vsp != 0
	falling = true
if falling && place_meeting(x, y + vsp, obj_player)
	instance_destroy()