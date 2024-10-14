extends CharacterBody3D

class_name Controllable

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var is_controlling: bool = false
var is_targetted: bool = false

func set_controlling_state(controlling_status):
	is_controlling = controlling_status


func set_targetted_state(targetted_status):
	is_targetted = targetted_status


func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
