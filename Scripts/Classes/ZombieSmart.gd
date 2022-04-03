extends "res://Scripts/Classes/Zombie.gd"

var path = []
var i_path = 1
var cible_position = Vector3.ZERO

func _deplacement(delta:float):
	if cible != null:
		var space_state = get_world().direct_space_state
		var result = space_state.intersect_ray(get_node("CollisionShape").global_transform.origin, cible.get_node("CollisionShape").global_transform.origin, [self])
		if not result.empty() && result.collider.is_in_group("Joueur"):
			var vec = cible.translation
			vec.y = $Vue.translation.y
			$Vue.look_at(vec, Vector3.UP)
			if($Timer.is_stopped()):
				$Timer.start()
		else :
			$Timer.stop()

	if i_path < path.size():
		var direction = path[i_path] - translation
		direction.y = 0
		if direction.length() < 1:
			i_path += 1
		direction = direction.normalized() * speed
		if not is_on_floor():
			velocity_y -= Global.gravity * delta
			direction.y = velocity_y
		else:
			velocity_y = 0.0
		move_and_slide(direction, Vector3.UP)

func find_path():
	if(cible_position != cible.translation):
		cible_position = cible.translation
		path = get_parent().get_node("Navigation").get_simple_path(translation, cible.translation)
		i_path = 1


func _on_Vue_body_entered(body):
	cible = body
	find_path()
	$Timer.start()

func _on_Vue_body_exited(body):
	cible = null
	$Timer.stop()
