extends Area3D


signal unlocked

@export var open_material: Material
var normal_material: Material

@onready var csg_box_3d: CSGBox3D = $CollisionShape3D/CSGBox3D2

var lock_1: bool = false
var lock_2: bool = false

var locked: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	normal_material = csg_box_3d.material


func _on_pressure_plate_actived(status: bool) -> void:
	print("_on_pressure_plate_actived: ", status)
	lock_1 = status
	check_locks()


func _on_pressure_plate_2_actived(status: bool) -> void:
	lock_2 = status
	check_locks()


func check_locks():
	if (locked):
		locked = ! (lock_1 && lock_2)
		if (!locked):
			csg_box_3d.material = open_material
			unlocked.emit()
	
