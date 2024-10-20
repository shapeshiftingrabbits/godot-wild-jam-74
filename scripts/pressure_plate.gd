extends Area3D

signal actived(status: bool)

@export var pressed_material: Material
@export var deactivated_material: Material
var normal_material: Material
@onready var csg_box_3d: CSGBox3D = $CollisionShape3D/CSGBox3D
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $"../ControllablePressurePlate/AudioStreamPlayer3D"
@export var entered_sfx: AudioStreamMP3
@export var exited_sfx: AudioStreamMP3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	normal_material = csg_box_3d.material


func _on_body_entered(body: Node3D) -> void:
	csg_box_3d.material = pressed_material
	audio_stream_player_3d.stream = entered_sfx
	audio_stream_player_3d.play()
	actived.emit(true)


func _on_body_exited(body: Node3D) -> void:
	csg_box_3d.material = normal_material
	audio_stream_player_3d.stream = exited_sfx
	audio_stream_player_3d.play()
	actived.emit(false)


func _on_door_unlocked() -> void:
	csg_box_3d.material = deactivated_material
	disconnect("body_entered", _on_body_entered)
	disconnect("body_exited", _on_body_exited)
