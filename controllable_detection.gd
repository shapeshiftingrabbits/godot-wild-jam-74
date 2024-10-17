extends RayCast3D

signal targeted(controllable: Controllable)

var controllables: Array[Node] = []

func _ready() -> void:
	controllables = get_tree().get_nodes_in_group("controllable")


func _physics_process(delta: float) -> void:
	if (is_colliding()):
		var collider = get_collider() as Node3D
		if collider is Controllable:
			collider.set_targeted(true)
			collider.add_to_group("valid_target")
			targeted.emit(collider)
			var others = controllables.filter(func (controllable: Controllable): return controllable != collider)
			others.map(untarget)
	else :
		controllables.map( func (controllable: Controllable): controllable.set_targeted(false))


func untarget(controllable: Controllable):
	controllable.set_targeted(false)
	controllable.remove_from_group("valid_target")
