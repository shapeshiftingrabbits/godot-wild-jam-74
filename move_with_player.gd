extends Control

@onready var player: Player = $"../Player"
@onready var camera_3d: Camera3D = $"../Camera3D"

func _physics_process(delta: float) -> void:
	var position_on_screen = camera_3d.unproject_position(player.position)
	position = position_on_screen
