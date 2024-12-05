extends Node

@onready var completeButton = $"../Complete"
var quest: Quest

var wPressed: bool = false
var aPressed: bool = false
var sPressed: bool = false
var dPressed: bool = false
var questReady: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if questReady == true:
		if quest.quest_status == Quest.QuestStatus.started:
			if event is InputEventKey:
				if event.is_pressed():
					if event.is_action_pressed("left"):
						aPressed = true
					if event.is_action_pressed("right"):
						dPressed = true
					if event.is_action_pressed("up"):
						wPressed = true
					if event.is_action_pressed("down"):
						sPressed = true
		if aPressed && dPressed && wPressed && sPressed:
			quest.reached_goal()
			completeButton.visible = true
			questReady = false
		else:
			completeButton.visible = false
