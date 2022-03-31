extends KinematicBody

export(int) var speed = 5
var cible = null

func _physics_process(_delta):
	if cible != null :
		var vec = cible.translation
		vec.y = $Vue.translation.y
		$Vue.look_at(vec, Vector3.UP)

		var direction = translation.direction_to(cible.translation) * speed
		move_and_slide(direction, Vector3.UP)

#		for i in range(0, get_slide_count()):
#			var collider = get_slide_collision(i)
#			if collider.collider.is_in_group("Joueur"):
#				print("HURT")

func _on_Vue_body_entered(body):
	cible = body
	print_debug(body)

func _on_Vue_body_exited(body):
	cible = null
