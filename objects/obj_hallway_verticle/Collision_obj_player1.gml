if active == false
	{
		with obj_player1
		{
			savedspd = vsp;
			savedpos = (x - other.x)
			targetRoom = other.targetRoom
			targetDoor = other.targetDoor
			hallwaydirection = other.hallwaydirection
			hallway = 2
			with instance_create_depth(x, y, 0, obj_fadeout)
				targetRoom = other.targetRoom
			other.active = true
		}
	}