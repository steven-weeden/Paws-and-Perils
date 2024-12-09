extends Node

@onready var completeButton = $"../Complete"
@onready var game_scene = get_node("/root/World")

var quest: Quest
var questReady: bool = false

func _on_fight_pressed() -> void:
	if(questReady):
		Global.goob_fight = true
		game_scene.start_battle(self)

func _on_tutorial_guy_goob_slain() -> void:
	if(questReady):
		
		Global.goob_fight = false
		quest.reached_goal()
		completeButton.visible = true
		questReady = false
	else:
		completeButton.visible = false
