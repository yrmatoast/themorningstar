if active == 1
{
	instance_activate_object(sol)
	image_alpha = 1
}
else
{
	instance_deactivate_object(sol)
	image_alpha = 0.5
}