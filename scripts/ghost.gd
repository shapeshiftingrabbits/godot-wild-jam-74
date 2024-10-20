extends Node3D


var floaty_tween: Tween
var position_tween: Tween

const FLOATY_TWEEN_DURATION: float = 3.0

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var state_chart: StateChart = $StateChart

@export var follow_target: Node3D
var cached_follow_target: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cached_follow_target = follow_target

	floaty_tween = get_tree().create_tween().bind_node(self)
	floaty_tween.tween_property(%Cube, "position", Vector3(0.0, 0.5, 0.0), FLOATY_TWEEN_DURATION)
	floaty_tween.tween_property(%Cube, "position", Vector3(0.0, -0.5, 0.0), FLOATY_TWEEN_DURATION)
	floaty_tween.set_loops(-1)


func tween_to_position(in_position: Vector3):
	position_tween = get_tree().create_tween().bind_node(self)
	position_tween.tween_property(self, "position", in_position, 0.5)
	position_tween.finished.connect(tween_ended)


func tween_ended():
	state_chart.send_event("idle")
	position_tween.finished.disconnect(tween_ended)


func _on_move_state_state_entered() -> void:
	pass


func _on_move_state_state_exited() -> void:
	pass

func _on_idle_state_state_entered() -> void:
	pass # Replace with function body.


func _on_player_haunting(target: Node3D) -> void:
	state_chart.send_event("move")
	tween_to_position(target.position)
	audio_stream_player_3d.stop()
	audio_stream_player_3d.play()
	follow_target = target
	

var offset = Vector3(-1.0, 1.5, 0.2)
func _on_idle_state_state_processing(delta: float) -> void:
	position = follow_target.position + offset
	position.y  = 1.5


func _on_player_stop_hauting() -> void:
	state_chart.send_event("move")
	tween_to_position(cached_follow_target.position)
	follow_target = cached_follow_target
