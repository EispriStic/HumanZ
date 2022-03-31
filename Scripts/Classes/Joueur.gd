extends KinematicBody
export (float) var speed:float = 10

var velocity_y := 0.0
var restRot = rotation.y

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _physics_process(delta):
	
	var direction_ground := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")).normalized()
	
	rotation.y  = lerp_angle(rotation.y,restRot,10 * delta)
	
	direction_ground = direction_ground.rotated(-rotation.y+PI)
	
	if not is_on_floor():
		velocity_y -= Global.gravity * delta
	
	var velocity = Vector3(
		direction_ground.x * speed,
		velocity_y,
		direction_ground.y * speed)
	
	move_and_slide(velocity,Vector3.UP)
	
	#commentaire
	
	
func _input(event):
	if(Input.is_action_just_pressed("camera_left")):
		restRot += PI/2
	if(Input.is_action_just_pressed("camera_right")):
		restRot -= PI/2
