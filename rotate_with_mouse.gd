extends Node3D

@onready var camera_3d: Camera3D = $"../../Camera3D"

@onready var character_body_3d: CharacterBody3D = $".."

@onready var csg_box_3d: CSGBox3D = $"../../CSGBox3D"
@onready var player: Player = $".."


const RAY_LENGTH = 1000

var debug_cube_position = Vector3(0.0,0.1,0.0)
var looking_position = Vector3(0.0,1.0,0.0)

func _physics_process(delta: float) -> void:
	test_collision_with_query(delta)


func test_collision_with_query(delta: float):
	var mouse_pos = get_viewport().get_mouse_position()

	var from = camera_3d.project_ray_origin(mouse_pos)
	var to = from + camera_3d.project_ray_normal(mouse_pos) * RAY_LENGTH
	var space_state = get_world_3d().direct_space_state
	
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.collision_mask = 0x004
	var result = space_state.intersect_ray(query)
	if result:
		csg_box_3d.position = result.position
		looking_position.x = result.position.x
		looking_position.z = result.position.z
		look_at_from_position(player.position,looking_position)
