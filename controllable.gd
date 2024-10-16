extends CharacterBody3D

class_name Controllable

const SPEED = 5.0
const JUMP_VELOCITY = 4.5


@onready var controllable_state_chart: StateChart = %ControllableStateChart


func set_targeted(status: bool):
	var event_name = "targeted" if status else "untargeted"
	controllable_state_chart.send_event(event_name)


func set_haunted(status: bool):
	var event_name = "haunted" if status else "unhaunted"
	controllable_state_chart.send_event(event_name)


func _on_haunted_state_state_physics_processing(delta: float) -> void:
	_handle_movement(delta)


func _handle_movement(delta: float):
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
