extends VBoxContainer

@onready var state_chart: StateChart = $StateChart
@onready var player: Player = $"../Player"


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	
func _on_menu_button_pressed() -> void:
	send_menu_event()


func send_game_event():
	state_chart.send_event("game_pressed")


func send_menu_event():
	state_chart.send_event("menu_pressed")


func _on_continue_button_pressed() -> void:
	send_game_event()


func _on_reload_button_pressed() -> void:
	reload_scene()


func reload_scene():
	get_tree().reload_current_scene()


func _on_game_state_state_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		send_menu_event()


func _on_menu_state_state_input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_action"):
		reload_scene()
	if event.is_action_pressed("ui_cancel"):
		send_game_event()


func _on_game_state_state_entered() -> void:
	get_tree().paused = false


func _on_menu_state_state_entered() -> void:
	get_tree().paused = true
