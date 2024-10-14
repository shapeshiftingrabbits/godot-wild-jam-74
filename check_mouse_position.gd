extends StaticBody3D

signal mouse_moving(position: Vector2)
@onready var camera_3d: Camera3D = $"../CharacterBody3D/Camera3D"

const RAY_LENGTH = 1000


func _input(event: InputEvent) -> void:
	if (event is InputEventMouseMotion):

		
		mouse_moving.emit(event.position)
		print("mouse moving", event.position)
