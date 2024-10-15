if active
{
	with obj_player
	{
		x = other.x
		y = other.y
		state = -4
		vsp = 0
		set_sprite("fall")
		if key_jump2
		{
			instance_create_depth(x, y + 5, 5, obj_basicparticle, {
				sprite_index: spr_jumpcloud
			})
			vsp = -14
			scr_soundeffect_3d(sfx_jump, x, y)
			set_sprite("jump", 0)
			state = states.jump
			jumpstop = false
			other.active = false
			other.usabletimer = 60
		}
	}
}
if usabletimer > 0
	image_alpha = 0.5
else
	image_alpha = 1
usabletimer = approach(usabletimer, 0, 1)