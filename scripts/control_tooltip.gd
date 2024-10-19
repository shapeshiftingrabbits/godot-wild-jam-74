extends HBoxContainer


@export var icon: Texture2D
@export var title: String
@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_rect.texture = icon
	label.text = title
