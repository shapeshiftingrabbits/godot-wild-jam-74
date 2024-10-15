extends Node
@onready var player: Player = $".."


func start_haunting(target: Controllable):
	player.is_haunting = true
	target.set_haunted(true)
	
