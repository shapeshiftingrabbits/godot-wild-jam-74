extends Control

@onready var player: Player = $"../Player"
@onready var camera_3d: Camera3D = $"../Camera3D"


var position_offsetted = Vector2(0,0)

func _physics_process(delta: float) -> void:
	var position_on_screen = camera_3d.unproject_position(player.position)
	position = _get_position_offsetted(position_on_screen)


func _get_position_offsetted(position: Vector2) -> Vector2:
	position_offsetted.x = position.x + 24.0
	position_offsetted.y = position.y + 24.0
	return position_offsetted


func _on_v_box_container_resized() -> void:
	# This is because the panel is not shrinking at runtime, in editor is fine.
	reset_size()
	#pass
