extends StaticBody

var main_mat

func _on_Area_area_entered(area):
	main_mat = $Mesh.mesh.surface_get_material(0)
	var mat = main_mat.next_pass
	$Mesh.mesh.surface_set_material(0, mat)


func _on_Area_area_exited(area):
	$Mesh.mesh.surface_set_material(0, main_mat)
	main_mat = null
