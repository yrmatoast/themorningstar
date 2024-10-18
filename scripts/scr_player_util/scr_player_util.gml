function get_char_name(_char) //get character name (for sprites)
{
	var _name = "NaN"
	switch _char
	{
		case "N":
			_name = "noise"
			break
		case "M":
			_name = "monster"
			break
	}
	return _name
}

function set_sprite(_name, _index = image_index, _char = char) //easier sprite setting without 12983293 variables.
{
	var sprite_to_find = string("spr_{0}_{1}", get_char_name(_char), _name)
	var sprite = asset_get_index(sprite_to_find)
	if sprite_exists(sprite)
	{
		sprite_index = sprite
		if _index != image_index
			image_index = _index
	}
	else
	{
		error(string("'{0}' Is not a valid sprite!", sprite_to_find))
		if char == "M"
		{
			set_sprite(_name, _index, "N")
		}
	}
}

function get_sprite(_name) //to check if youre a sprite
{
	var sprite_to_find = string("spr_{0}_{1}", get_char_name(char), _name)
	var sprite = asset_get_index(sprite_to_find)
	if sprite_exists(sprite)
		return sprite_index == sprite
	else
	{
		error(string("'{0}' Is not a valid sprite!", sprite_to_find))
		if char == "M"
		{
			var sprite_to_find = string("spr_{0}_{1}", get_char_name("N"), _name)
			var sprite = asset_get_index(sprite_to_find)
			if sprite_exists(sprite)
				return sprite_index == sprite
		}
	}
}

function get_sprite_name(_name) //easier sprite setting without 12983293 variables.
{
	var sprite_to_find = string("spr_{0}_{1}", get_char_name(char), _name)
	var sprite = asset_get_index(sprite_to_find)
	if sprite_exists(sprite)
	{
		return sprite
	}
	else
		error(string("'{0}' Is not a valid sprite!", sprite_to_find))
}