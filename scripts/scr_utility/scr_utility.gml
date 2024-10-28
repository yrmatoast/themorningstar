#region Input
function __ti_initinput()
{
	ini_open("options.ini")
	global.key_left = [
	
	ini_read_real("Keyboard", "Left", vk_left), 
	ini_read_real("Controller", "Left", gp_padl),]
	
	global.key_up = [
	
	ini_read_real("Keyboard", "Up", vk_up), 
	ini_read_real("Controller", "Up", gp_padu),]
	
	global.key_down = [
	
	ini_read_real("Keyboard", "Down", vk_down), 
	ini_read_real("Controller", "Down", gp_padd),]
	
	global.key_right = [
	
	ini_read_real("Keyboard", "Right", vk_right), 
	ini_read_real("Controller", "Right", gp_padr),]
	
	global.key_jump = [
	
	ini_read_real("Keyboard", "Jump", ord("Z")), 
	ini_read_real("Controller", "Jump", gp_face1),]
	
	global.key_attack = [
	
	ini_read_real("Keyboard", "Attack", vk_shift), 
	ini_read_real("Controller", "Attack", gp_face3),]
	
	global.key_slap = [
	
	ini_read_real("Keyboard", "Slap", ord("X")), 
	ini_read_real("Controller", "Slap", gp_face4),]
	
	global.key_taunt = [
	
	ini_read_real("Keyboard", "Taunt", ord("C")), 
	ini_read_real("Controller", "Taunt", gp_face2),]
	
	global.key_start = [
	
	ini_read_real("Keyboard", "Start", vk_escape), 
	ini_read_real("Controller", "Start", gp_start),]
	
	ini_close()
	
}

function scr_setbind(_global, _savename , _value, _controller = 0) // change bind to another key
{
	var _key = _controller = 0 ? "Keyboard" : "Controller"
	ini_open("options.ini")
	ini_write_real(_key, _savename, _value)
	_global[_controller] = ini_read_real(_key, _savename, _value,)
	ini_close()
}

function __ti_input()
{
		var _input = -4
		ini_open("options.ini")
		key_left = -(keyboard_check(global.key_left[0]) || gamepad_button_check(_input, global.key_left[1]) || gamepad_axis_value(_input, gp_axislh) < 0)
		key_left2 = -(keyboard_check_pressed(global.key_left[0]) || gamepad_button_check_pressed(_input, global.key_left[1]) || gamepad_axis_value(_input, gp_axislh) < 0)
	
		key_right = keyboard_check(global.key_right[0]) || gamepad_button_check(_input, global.key_right[1] || gamepad_axis_value(_input, gp_axislh) > 0)
		key_right2 = keyboard_check_pressed(global.key_right[0]) || gamepad_button_check_pressed(_input, global.key_right[1] || gamepad_axis_value(_input, gp_axislh) > 0)
	
		key_down = keyboard_check(global.key_down[0]) || gamepad_button_check(_input, global.key_down[1] || gamepad_axis_value(_input, gp_axislv) > 0.5)
		key_down2 = keyboard_check_pressed(global.key_down[0]) || gamepad_button_check_pressed(_input, global.key_down[1] || gamepad_axis_value(_input, gp_axislv) > 0.5)
	
		key_up = keyboard_check(global.key_up[0]) || gamepad_button_check(_input, global.key_up[1] || gamepad_axis_value(_input, gp_axislv) < 0.5)
		key_up2 = keyboard_check_pressed(global.key_up[0]) || gamepad_button_check_pressed(_input, global.key_up[1] || gamepad_axis_value(_input, gp_axislv) < 0.5)
	
		key_jump = keyboard_check(global.key_jump[0]) || gamepad_button_check(_input, global.key_jump[1])
		key_jump2 = keyboard_check_pressed(global.key_jump[0]) || gamepad_button_check_pressed(_input, global.key_jump[1])
	
		key_slap = keyboard_check(global.key_slap[0]) || gamepad_button_check(_input, global.key_slap[1])
		key_slap2 = keyboard_check_pressed(global.key_slap[0]) || gamepad_button_check_pressed(_input, global.key_slap[1])
	
		key_attack = keyboard_check(global.key_attack[0]) || gamepad_button_check(_input, global.key_attack[1])
		key_attack2 = keyboard_check_pressed(global.key_attack[0]) || gamepad_button_check_pressed(_input, global.key_attack[1])
	
		key_taunt = keyboard_check(global.key_taunt[0]) || gamepad_button_check(_input, global.key_taunt[1])
		key_taunt2 = keyboard_check_pressed(global.key_taunt[0]) || gamepad_button_check_pressed(_input, global.key_taunt[1])
	
		key_start = keyboard_check(global.key_start[0]) || gamepad_button_check(_input, global.key_start[1])
		key_start2 = keyboard_check_pressed(global.key_start[0]) || gamepad_button_check_pressed(_input, global.key_start[1])
		ini_close()
}

function gamepad_check_any(_device) // check for gamepad
{
	for (var i = gp_face1; i < gp_axisrv; i++)
	{
		if gamepad_button_check(_device, i)
		{
			return true;
        	}
    	}
}
#endregion

function approach(_start, _end, _increment)
{
	if (_start < _end)
	    return min(_start + _increment, _end); 
	else
	    return max(_start - _increment, _end);
}

function to_bool(_variable)
{
	var _return = "false"
	if _variable == true
		_return = "true"
	return _return
}

function scr_soundeffect_2d(_snd, _pitch = 0)
{
	var _s = audio_play_sound(_snd, 0, false)
	audio_sound_pitch(_s, 1 + _pitch)
}

function scr_soundeffect_3d(_snd, _x, _y, _pitch = 0)
{
	var _s = audio_play_sound_at(_snd, -_x, _y, 0, 300, 1280 * 2, audio_falloff_linear_distance, false, 0)
			audio_sound_pitch(_s, 1 + _pitch)
}

function animation_end()
{
	return floor(image_index) >= (image_number - 1);
}

#macro trace show_debug_message
#macro error add_error

function draw_set_align(_halign = fa_left, _valign = fa_top)
{
	draw_set_halign(_halign);
	draw_set_valign(_valign);
}

function error_exists(_errmsg)
{
	var _proceed = false
	if (!ds_list_empty(obj_errorreporter.errors))
	{
		for (var i = 0; i < ds_list_size(obj_errorreporter.errors); i++)
		{
			var q = ds_list_find_value(obj_errorreporter.errors, i)
			if q.rtxt == _errmsg
			{
				var _proceed = true
				break
			}
		}
	}
	return _proceed
}

function add_error(_text)
{
	var _err = 
	{
		rtxt: _text,
		txt: string("ERROR: {0}", _text),
		timer: 60 * 3,
	}
	if !error_exists(_text)
		ds_list_add(obj_errorreporter.errors, _err)	
	return _err
}

/*
_vars = []
array_push(_vars, {
name: x,
val: y,
})
*/
function save_quick(_section, _vars)
{
	with obj_savesystem
	{
		for (var i = 0; i < array_length(_vars); i++)
		{
			ini_open(file);
			if is_string(_vars[i].val)
				ini_write_string(_section, _vars[i].name, _vars[i].val);
			else
				ini_write_real(_section, _vars[i].name, _vars[i].val);
		}
		ini_close()
		saveicon.timer = 60
	}
}

function load_quick(_real = true, _section, _var)
{
	with obj_savesystem
	{
		ini_open(file);
		return _real ? real(ini_read_real(_section, _var, -4)) : ini_read_string(_section, _var, -4)
		ini_close()
	}
}

function wrap()
{
	var value = floor(argument0);
	var _min = floor(min(argument1, argument2));
	var _max = floor(max(argument1, argument2));
	var range = _max - _min + 1; // + 1 is because max bound is inclusive

	return (((value - _min) % range) + range) % range + _min;
}