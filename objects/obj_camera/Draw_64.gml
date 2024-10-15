for (var i = 0; i < 4; i++)
{
	draw_sprite(spr_hud_health, i, 32 + 13 + (56 * i), 64 + sin(current_time / 115 - (i * 60.5)) * 3)
}
var spdx = 32 - 16 - 10
var spry = 64 + 32
draw_sprite_part(spr_hud_speedometer_meter, noiseindex, 0, 0, 4 + cam_tar.movespeed / 16 * (229), 64, spdx + 16, spry + 16)
draw_sprite(spr_hud_speedometer_front, 0, spdx, spry)
draw_sprite(noisesprite, noiseindex, spdx + 32 + cam_tar.movespeed / 20 * (64 * 4 - 16), spry + 20)
draw_sprite(cuphud, 0, 256 + 16 - 6, 16 - 4 + cupoffset)