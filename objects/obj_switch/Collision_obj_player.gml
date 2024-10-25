if timer <= 0
{
	timer = 20
	instance_destroy()
	ds_list_add(global.saveroom, id)
}