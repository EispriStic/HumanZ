extends StaticBody

func _on_Area_area_entered(_area):
	$Mesh.get_active_material(0).set_shader_param("hide", true)


func _on_Area_area_exited(_area):
	$Mesh.get_active_material(0).set_shader_param("hide", false)
