extends "res://Scripts/Classes/Zombie.gd"

var path = []
var i_path = 0

func _deplacement():
	if i_path < path.size():
		var direction = path[i_path] - translation
		direction.y = translation.y
		if direction.length() < 1:
			i_path += 1
		return direction.normalized() * speed
	else:
		return translation

func find_path():
	path = get_parent().get_node("Navigation").get_simple_path(translation, cible.translation)
	i_path = 0


func _on_Vue_body_entered(body):
	cible = body
	find_path()
	$Timer.start()

func _on_Vue_body_exited(body):
	cible = null
	$Timer.stop()
