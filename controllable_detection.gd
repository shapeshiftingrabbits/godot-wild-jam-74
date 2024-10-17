extends Area3D

signal targeted(controllable: Controllable)

var controllables: Array[Node] = []

func _ready() -> void:
	controllables = get_tree().get_nodes_in_group("controllable")


func _on_body_entered(body: Node3D) -> void:
	print("_on_body_entered")
	var controllable = body as Controllable
	controllable.set_targeted(true)
	controllable.add_to_group("valid_target")
	targeted.emit(controllable)
	var others = controllables.filter(func (item: Controllable): return controllable != item)
	others.map(_untarget)


func _untarget(controllable: Controllable):
	controllable.set_targeted(false)
	controllable.remove_from_group("valid_target")


func _on_body_exited(body: Node3D) -> void:
	print("_on_body_exited")
	var controllable = body as Controllable
	_untarget(controllable)
