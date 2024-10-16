for (var i = 0; i < global.hp; i++)
{
	draw_sprite(spr_hud_health, i, 32 + 13 + (56 * i), 64 + sin(current_time / 115 - (i * 60.5)) * 3)
}
var spdx = 32 - 16 - 10
var spry = 64 + 32
draw_sprite_part(spr_hud_speedometer_meter, noiseindex, 0, 0, 4 + barpos * (229), 64, spdx + 16, spry + 16)
draw_sprite(spr_hud_speedometer_front, 0, spdx, spry)
draw_sprite(noisesprite, noiseindex, spdx + 32 + barpos * (64 * 3 + 2), spry + 20)
draw_sprite(cuphud, 0, 256 + 16 - 6 + (56 * (global.hp - 4)), 16 - 4 + cupoffset)
draw_set_align(fa_center)
draw_set_font(cupfont)
draw_text(256 + 16 - 6 + 6 + 32 + (56 * (global.hp - 4)), 16 - 4 + cupoffset + 32 + 4, global.collect)