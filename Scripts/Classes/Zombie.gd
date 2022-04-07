extends KinematicBody

export(int) var speed = 5
var cible_vue = null

func _physics_process(delta):
	_deplacement(delta)

#		for i in range(0, get_slide_count()):
#			var collider = get_slide_collision(i)
#			if collider.collider.is_in_group("Joueur"):
#				print("HURT")

func _deplacement(delta:float):
	if cible_vue != null :
		var space_state = get_world().direct_space_state
		# use global coordinates, not local to node
		
		var result = space_state.intersect_ray(get_node("CollisionShape").global_transform.origin, cible_vue.get_node("CollisionShape").global_transform.origin, [self])
		var direction = Vector3.ZERO
		if not result.empty() && result.collider.is_in_group("Joueur"):
			var vec = cible_vue.translation
			vec.y = $Vue.translation.y
			$Vue.look_at(vec, Vector3.UP)

			direction = translation.direction_to(cible_vue.translation) * speed
		direction.y = -Global.gravity * delta
		move_and_slide(direction, Vector3.UP)

func _on_Vue_body_entered(body):
	cible_vue = body

func _on_Vue_body_exited(body):
	cible_vue = null

func _on_Son_area_entered(area):
	cible_vue = area.get_parent()
