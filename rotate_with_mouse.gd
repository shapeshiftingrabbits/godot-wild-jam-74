extends Node3D

@onready var camera_3d: Camera3D = $"../Camera3D"
@onready var character_body_3d: CharacterBody3D = $".."
@onready var mouse_ray_cast_3d: RayCast3D = $"../Camera3D/MouseRayCast3D"

#func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
var mouse_position : Vector2


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_position = event.position
		#in_world_mouse_position.y = 1.0
	else:
		mouse_position = Vector2.ZERO
	

func _physics_process(delta: float) -> void:
	var from = camera_3d.project_ray_origin(mouse_position)
	var to = from + camera_3d.project_ray_normal(mouse_position) * 1000.0
	if (mouse_ray_cast_3d.is_colliding()):
		var collision_point = mouse_ray_cast_3d.get_collision_point()
		print(collision_point)
		look_at(collision_point )
		
