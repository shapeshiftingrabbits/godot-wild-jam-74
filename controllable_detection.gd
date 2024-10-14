extends RayCast3D


func _physics_process(delta: float) -> void:
	if (is_colliding()):
		var collider = get_collider() as Node3D
		if collider.has_method("set_targetted_state"):
			pass
