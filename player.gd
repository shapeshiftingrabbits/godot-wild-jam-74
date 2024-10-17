extends CharacterBody3D


class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5


@onready var state_chart: StateChart = $StateChart
@onready var direction_indicator: MeshInstance3D = $Pivot/DirectionIndicator
@onready var csg_sphere_3d: CSGSphere3D = $CSGSphere3D

var current_haunted_target: Controllable

func _handle_movement(delta: float)-> void:
		## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

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


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		state_chart.send_event("action_pressed")
	
	if event.is_action_pressed("cancel"):
		state_chart.send_event("cancel")


func get_valid_target() -> Controllable:
	var valid_target = get_tree().get_first_node_in_group("valid_target")
	return valid_target


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


func _on_normal_state_state_entered() -> void:
	direction_indicator.hide()
	csg_sphere_3d.hide()


func _on_targetting_state_state_entered() -> void:
	direction_indicator.show()


func _on_targetting_state_state_exited() -> void:
	direction_indicator.hide()


func _on_haunting_state_state_entered() -> void:
	csg_sphere_3d.show()


func _on_haunting_state_state_exited() -> void:
	csg_sphere_3d.hide()


func _on_normal_state_state_physics_processing(delta: float) -> void:
	_handle_movement(delta)


func _on_targetting_state_state_physics_processing(delta: float) -> void:
	_handle_movement(delta)


func _on_targetting_state_state_input(event: InputEvent) -> void:
	if event.is_action_pressed("action_confirm"):
		var valid_target = get_valid_target()
		if valid_target :
			current_haunted_target = valid_target
			current_haunted_target.set_haunted(true)
			state_chart.send_event("action_confirm")


func _on_haunting_state_state_input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		current_haunted_target.set_haunted(false)
		current_haunted_target = null
		state_chart.send_event("cancel")
