if timer <= 0
{
	global.Bswitch *= -1
	timer = 20
	instance_destroy()
}