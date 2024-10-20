extends PanelContainer

@onready var hud: VBoxContainer = $"../HUD"
@onready var dialogue_1: VBoxContainer = $Dialogue1
@onready var dialogue_2: VBoxContainer = $Dialogue2
@onready var dialogue_3: VBoxContainer = $Dialogue3


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	show()
	hud.hide()
	dialogue_1.show()
	dialogue_2.hide()
	dialogue_3.hide()
	# need timer else won't pause
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = true
	

func _on_skip_button_pressed() -> void:
	start_game()


func start_game():
	hud.show()	
	hide()
	get_tree().paused = false


func _on_more_button_pressed() -> void:
	dialogue_1.hide()
	dialogue_2.show()


func _on_ok_button_pressed() -> void:
	dialogue_1.hide()
	dialogue_2.hide()
	dialogue_3.show()


func _on_go_button_pressed() -> void:
	start_game()
