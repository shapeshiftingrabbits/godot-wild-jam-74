extends CharacterBody3D


class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var is_action_toggle: bool = false
var is_haunting: bool = false

@onready var state_chart: StateChart = $StateChart
@onready var direction_indicator: MeshInstance3D = $Pivot/DirectionIndicator
@onready var csg_sphere_3d: CSGSphere3D = $CSGSphere3D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		state_chart.send_event("action_pressed")
	if event.is_action_pressed("action_confirm"):
		state_chart.send_event("action_confirm")
	if event.is_action_pressed("cancel"):
		state_chart.send_event("cancel")



func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_haunting:
		return

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
