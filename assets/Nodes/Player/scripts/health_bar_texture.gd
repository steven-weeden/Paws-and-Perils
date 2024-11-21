extends TextureProgressBar

@onready var cur_h = $HBoxContainer/Label

@export var player_h_bar: player

func _ready() -> void:
	update()

func update():
	value = player_h_bar.current_health
	max_value = player_h_bar.health
	cur_h.text = str(player_h_bar.current_health)
