extends KinematicBody
export (float) var speed:float = 10

var velocity_y := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _physics_process(delta):
	
	if (Input.is_action_just_pressed("camera_left") and not Input.is_action_just_pressed("camera_right")):
		rotate_y(PI/2)
	
	var direction_ground := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")).normalized()
	
	direction_ground = direction_ground.rotated(-$PositionCam.rotation.y)
	
	if not is_on_floor():
		velocity_y -= Global.gravity * delta
	
	var velocity = Vector3(
		direction_ground.x * speed,
		velocity_y,
		direction_ground.y * speed)
	
	move_and_slide(velocity,Vector3.UP)
	
	
