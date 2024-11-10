__ti_input()
if keyboard_check_pressed(vk_escape)
{
	if !pause
	{
		screensprite = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), false, false, 0, 0)
		var surface = surface_create(WINDOW_WIDTH, WINDOW_HEIGHT)
		if surface_exists(surface)
		{
			surface_set_target(surface)
			with obj_camera
			{
				if visible
					event_perform(ev_draw, ev_gui)
			}
			with obj_fadeout
			{
				if visible
					event_perform(ev_draw, ev_gui)
			}
			with obj_levelselect
			{
				if visible
					event_perform(ev_draw, ev_gui)
			}
			with obj_leveltitle
			{
				if visible
					event_perform(ev_draw, ev_gui)
			}
			surface_reset_target() 
			guisprite = sprite_create_from_surface(surface, 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, false, false, 0, 0)
			surface_free(surface)
		}
		pause = true
		instance_deactivate_all(true)
		instance_activate_object(obj_gameframe)
		instance_activate_object(obj_shell)
		instance_activate_object(obj_pause)
		instance_activate_object(obj_fmod)
		instance_activate_object(obj_inputcontroller)
		fmod_event_setPause_all(true)
	}
}
if pause
{
	var arr = exiting ? exitarr : pausearr
	if key_down2
		selected++
	if key_up2
		selected--
	selected = clamp(selected, 0, array_length(arr) - 1)
	if key_jump2
	{
		arr[selected].func()
	}
}