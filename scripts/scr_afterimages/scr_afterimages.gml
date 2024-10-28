function create_blur_afterimage(_sprite, _index, _x, _y, _xscale)
{
	var aft =
	{
		sprite_index: _sprite,
		image_index: _index,
		x: _x,
		y: _y,
		image_xscale: _xscale,
		image_blend: c_white,
		alarm: [15, 5, -2],
		type: afterimagetype.fade,
		alpha: 1,
		image_alpha: 0.5,
	}
	ds_list_add(obj_afterimagecontroller.afterimages, aft)
	return aft;
}