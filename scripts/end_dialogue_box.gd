extends PanelContainer
@onready var dialogue_1: VBoxContainer = $Dialogue1
@onready var dialogue_2: VBoxContainer = $Dialogue2

@onready var hud: VBoxContainer = $"../HUD"


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	dialogue_1.hide()
	dialogue_2.hide()


func _on_end_button_2_pressed() -> void:
	hud.show()
	hide()
	get_tree().paused = false


func _on_end_button_pressed() -> void:
	dialogue_1.hide()
	dialogue_2.show()


func play() -> void:
	hud.hide()
	show()
	# need timer else won't pause
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = true
	dialogue_1.show()
	dialogue_2.hide()
