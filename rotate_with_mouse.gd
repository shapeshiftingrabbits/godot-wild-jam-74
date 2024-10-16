extends Node3D

@onready var camera_3d: Camera3D = $"../../Camera3D"

@onready var character_body_3d: CharacterBody3D = $".."

@onready var csg_box_3d: CSGBox3D = $"../../CSGBox3D"


const RAY_LENGTH = 1000


func _physics_process(delta: float) -> void:
	test_collision_with_query()


func test_collision_with_query():
	var mouse_pos = get_viewport().get_mouse_position()

	var from = camera_3d.project_ray_origin(mouse_pos)
	var to = from + camera_3d.project_ray_normal(mouse_pos) * RAY_LENGTH
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)

	var result = space_state.intersect_ray(query)
	if result:
		csg_box_3d.position = result.position
		look_at(result.position)
