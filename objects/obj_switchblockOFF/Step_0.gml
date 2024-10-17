if active != -1
{
	instance_deactivate_object(sol)
	image_alpha = 0.5
}
else
{
	instance_activate_object(sol)
	image_alpha = 1
}