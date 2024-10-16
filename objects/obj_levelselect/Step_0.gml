__ti_input()
if key_down2
	selected++
if key_up2
	selected--
selected = clamp(selected, 0, array_length(levels) - 1)
if key_jump2 == active
{
	active = false
	with obj_player
	{
		targetRoom = other.levels[other.selected][1]
		targetDoor = other.levels[other.selected][2]
		hallway = false
		with instance_create_depth(x, y, 0, obj_fadeout)
			targetRoom = other.targetRoom
	}
}