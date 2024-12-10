extends Node2D

@onready var completeButton = $"../Complete"

var quest: Quest
var questReady: bool = false

func _on_tutorial_guy_player_rest() -> void:
	if questReady == true:
		quest.reached_goal()
		completeButton.visible = true
		questReady = false

	
