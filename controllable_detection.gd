extends RayCast3D


var controllables: Array[Node] = []

func _ready() -> void:
	controllables = get_tree().get_nodes_in_group("controllable")


func _physics_process(delta: float) -> void:
	if (is_colliding()):
		var collider = get_collider() as Node3D
		if collider.has_method("set_targeted"):
			collider.set_targeted(true)
			var others = controllables.filter(func (controllable: Controllable): return controllable != collider)
			others.map(func (controllable: Controllable): controllable.set_targeted(false))
	else :
		controllables.map( func (controllable: Controllable): controllable.set_targeted(false))
