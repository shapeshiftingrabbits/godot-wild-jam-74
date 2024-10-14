extends Node3D

class_name TargetIndicator


func _on_targeted_state_state_entered() -> void:
	show()


func _on_targeted_state_state_exited() -> void:
	hide()


func _on_idle_state_state_entered() -> void:
	hide()
