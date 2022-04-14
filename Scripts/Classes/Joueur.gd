extends KinematicBody

export (float) var speed = 10
export (float) var sneek_speed = 5
var actual_speed = speed
var velocity_y := 0.0
var restRot = rotation.y
var accroupie = false

func _physics_process(delta):
	var direction_ground := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")).normalized()
	
	rotation.y  = lerp_angle(rotation.y,restRot,10 * delta)
	
	direction_ground = direction_ground.rotated(-rotation.y+PI)
	
	if(is_on_floor()):
		velocity_y = 0.0
	
	velocity_y -= Global.gravity * delta
	
	var velocity = Vector3(
		direction_ground.x * actual_speed,
		velocity_y,
		direction_ground.y * actual_speed)
	
	move_and_slide(velocity,Vector3.UP)
	if(!accroupie and (velocity.x != 0 or velocity.z != 0)):
		$Bruit/CollisionShape.disabled = false
	else:
		$Bruit/CollisionShape.disabled = true
	
func _input(_event):
	if(Input.is_action_just_pressed("camera_left")):
		restRot += PI/2
	if(Input.is_action_just_pressed("camera_right")):
		restRot -= PI/2
	if(Input.is_action_just_pressed("accroupie")):
		accroupie = !accroupie
		if accroupie:
			actual_speed = sneek_speed
		else:
			actual_speed = speed
