extends Area3D

signal actived(status: bool)

@export var pressed_material: Material
var normal_material: Material
@onready var csg_box_3d: CSGBox3D = $CollisionShape3D/CSGBox3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	normal_material = csg_box_3d.material


func _on_body_entered(body: Node3D) -> void:
	csg_box_3d.material = pressed_material
	actived.emit(true)


func _on_body_exited(body: Node3D) -> void:
	csg_box_3d.material = normal_material
	actived.emit(false)


func deactivate():
	monitoring = false
