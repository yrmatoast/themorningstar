depth = -50
cam_tar = obj_player1
xoffset = 0
yoffset = 0
index = 0
camera_set_view_size(view_camera[0], 1280, 720)
shake = 0
lock = false
noiseindex = 0
noisesprite = spr_hud_speedometer_noise
cupoffset = 0
barpos = 0
cupfont = font_add_sprite_ext(spr_cuphud_numbers, "0123456789", false, -4)
collectables = ds_list_create()
cupx = 256 + 16 - 6 + (56 * (global.hp - 4))
cupy = 0
collect = 0
global.timer = 0
rcx = 0
rcy = 0

create_collect = function(_sprite, _x, _y)
{
	
	_x -= camera_get_view_x(view_camera[0])
	_y -= camera_get_view_y(view_camera[0])
	var par =
	{
		sprite_index: _sprite,
		x: _x,
		y: _y,
		hsp: 0,
		vsp: 0,
	}
	ds_list_add(obj_camera.collectables, par)
	return par;
}

char = obj_player1.char