extends StaticBody

export(int) var nbr_shader = 0

func _on_Area_area_entered(_area):
	$Mesh.get_active_material(nbr_shader).set_shader_param("hide", true)


func _on_Area_area_exited(_area):
	$Mesh.get_active_material(nbr_shader).set_shader_param("hide", false)
