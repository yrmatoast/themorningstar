/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if keyboard_check_pressed(vk_tab)
{
	if !instance_exists(obj_player2)
		instance_create_depth(x, y, depth, obj_player2)
	else
		instance_destroy(obj_player2)
}