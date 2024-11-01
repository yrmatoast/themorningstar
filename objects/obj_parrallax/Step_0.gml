var camx = camera_get_view_x(view_camera[0]);
var camy = camera_get_view_y(view_camera[0]);
var layers = layer_get_all();
for (var i = 0; i < array_length(layers); i++)
{
	var lay = layers[i];
	var layer_name = layer_get_name(lay);
	switch layer_name
	{
		case "Foregrounds_1":
			layer_x(lay, camx * 0.15);
			layer_y(lay, camy * 0.15);
		break
		case "Backgrounds_1":
			layer_x(lay, camx * 0.15);
			layer_y(lay, camy * 0.15);
		break
		case "Backgrounds_2":
			layer_x(lay, camx * 0.25);
			layer_y(lay, camy * 0.25);
		break
		case "Backgrounds_3":
			layer_x(lay, camx * 0.35);
			layer_y(lay, camy * 0.35);
		break
		case "Backgrounds_4":
			layer_x(lay, camx * 0.45);
			layer_y(lay, camy * 0.45);
		break
		case "Backgrounds_still1":
			layer_x(lay, camx);
			layer_y(lay, camy);
		break
		case "Backgrounds_still2":
			layer_x(lay, camx);
			layer_y(lay, camy);
		break
		case "Backgrounds_stillH1":
			layer_x(lay, camx * 0.15);
			layer_y(lay, camy);
		break
		case "Backgrounds_stillH2":
			layer_x(lay, camx * 0.25);
			layer_y(lay, camy);
		break
		case "Backgrounds_stillH3":
			layer_x(lay, camx);
			layer_y(lay, camy);
		break
		case "Backgrounds_RstillH3":
			layer_x(lay, camx);
			layer_y(lay, camy);
		break
	}
}