audio_falloff_set_model(audio_falloff_linear_distance)
audio_listener_position(-obj_player.x, obj_player.y, 0)
 var camx = cam_tar.x - (camera_get_view_width(view_camera[0]) / 2) + xoffset
var camy = cam_tar.y - 50 - (camera_get_view_height(view_camera[0]) / 2) + yoffset
camx = clamp(camx, 0, (room_width - camera_get_view_width(view_camera[0])))
camy = clamp(camy, 0, (room_height - camera_get_view_height(view_camera[0])))
var rcx = camx
var rcy = camy
if lock = false
	camera_set_view_pos(view_camera[0], rcx + irandom_range(shake, -shake), rcy + irandom_range(shake, -shake))
if room == rm_levelselect
	visible = false
else
	visible = true
char = obj_player.char
if cam_tar == obj_player
{
	var extend = sign(cam_tar.hsp) * cam_tar.movespeed * 4
	if cam_tar.state == states.cape
		var extendy = cam_tar.vsp * 10
	else
		var extendy = 0
		
	var accel = 2
	if (extend < 0 && xoffset > 0) || (extend > 0 && xoffset < 0)
		var accel = 8
	if cam_tar.state == states.running ||
	cam_tar.state == states.runningjump ||
	cam_tar.state == states.cape ||
	cam_tar.state == states.fork
	{
		xoffset = approach(xoffset, extend, accel)
		yoffset = approach(yoffset, extendy, 2)
		noisesprite = spr_hud_speedometer_noisemove
		barpos = approach(barpos, 1, 1 / 30)
	}
	else
	{
		barpos = approach(barpos, 0, 1 / 30)
		xoffset = approach(xoffset, 0, 6)
		yoffset = approach(yoffset, 0, 2)
		noisesprite = spr_hud_speedometer_noise
	}
}
noiseindex +=  0.35
cupoffset = approach(cupoffset, 0, 3)
shake = approach(shake, 0, 1)
cupx = lerp(cupx, 256 + 16 - 6 + (56 * (global.hp - 4)), 0.25)
cupy = (16 - 4 + cupoffset)
if (!ds_list_empty(collectables))
{
	for (var i = 0; i < ds_list_size(collectables); i++)
	{
		var q = ds_list_find_value(collectables, i)
		with q
		{
			var targetxx = other.cupx
			var targetyy = other.cupy
			var point = point_direction(x, y, targetxx , targetyy)
		    hsp = lengthdir_x(25, point)
		    vsp = lengthdir_y(25, point)
			x += hsp
			y += vsp
			if point_distance(x, y, targetxx , targetyy) < 25
			{
				with other
				{
					cupoffset = 24
					collect = global.collect
					q = undefined
					ds_list_delete(collectables, i)
					i--
				}
			}
		}
	}
}
global.timer++