// run the update function
gameframe_update();


if (gameframe_mouse_in_window())
{
	// run once when the mouse goes in window or moves
	if (!mouse_in_window)
	{
		mouse_in_window = true;
		gameframe_visible_time = 60 * 3;
		mouseX = window_mouse_get_x();
		mouseY = window_mouse_get_y();
	}
	
	if (window_mouse_get_x() != mouseX || window_mouse_get_y() != mouseY) 
		mouse_in_window = false;
}
else
{
	if (mouse_in_window)
		mouse_in_window = false;
}

if (gameframe_visible_time > 0)
{
	gameframe_visible_time--;
	gameframe_alpha = approach(gameframe_alpha, 1, 0.1);
}
else
	gameframe_alpha = approach(gameframe_alpha, 0, 0.1);