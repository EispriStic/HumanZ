extends KinematicBody

export(int) var speed = 5
var cible = null
var velocity_y := 0.0

func _physics_process(delta):
	if cible != null :
		var space_state = get_world().direct_space_state
		# use global coordinates, not local to node
		
		var result = space_state.intersect_ray(get_node("CollisionShape").global_transform.origin, cible.get_node("CollisionShape").global_transform.origin, [self])
		if not result.empty() && result.collider.is_in_group("Joueur"):
			var vec = cible.translation
			vec.y = $Vue.translation.y
			$Vue.look_at(vec, Vector3.UP)

			var direction = _deplacement()
			if not is_on_floor():
				velocity_y -= Global.gravity * delta
				direction.y = velocity_y
			else:
				velocity_y = 0.0
			move_and_slide(direction, Vector3.UP)

#		for i in range(0, get_slide_count()):
#			var collider = get_slide_collision(i)
#			if collider.collider.is_in_group("Joueur"):
#				print("HURT")

func _deplacement():
	return translation.direction_to(cible.translation) * speed

func _on_Vue_body_entered(body):
	cible = body

func _on_Vue_body_exited(body):
	cible = null
