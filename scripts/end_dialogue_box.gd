extends PanelContainer
@onready var dialogue_1: VBoxContainer = $Dialogue1
@onready var dialogue_2: VBoxContainer = $Dialogue2

@onready var hud: VBoxContainer = $"../HUD"


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	hud.hide()
	# need timer else won't pause
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = true
	dialogue_1.show()
	dialogue_2.hide()


func _on_end_button_2_pressed() -> void:
	dialogue_1.hide()
	dialogue_2.show()


func _on_end_button_pressed() -> void:
	pass # Replace with function body.
