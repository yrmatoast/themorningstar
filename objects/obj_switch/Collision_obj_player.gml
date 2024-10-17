if timer <= 0
{
	with obj_switchblock
	{
		if num = other.num
			active = !active
	}
	timer = 20
	instance_destroy()
}