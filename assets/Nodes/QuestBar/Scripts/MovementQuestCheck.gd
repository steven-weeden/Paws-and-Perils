extends Node

@onready var completeButton = $"../Complete"
var quest: Quest

var wPressed: bool = false
var aPressed: bool = false
var sPressed: bool = false
var dPressed: bool = false
var questReady: bool = false

func _input(event: InputEvent) -> void:
	if questReady == true:
		if quest.quest_status == Quest.QuestStatus.started:
			if Input.is_action_just_pressed("left"):
				aPressed = true
			elif Input.is_action_just_pressed("right"):
				dPressed = true
			elif Input.is_action_just_pressed("up"):
				wPressed = true
			elif Input.is_action_just_pressed("down"):
				sPressed = true
			print("W:", wPressed, "A:", aPressed, "S:", sPressed, "D:", dPressed)
		if aPressed && dPressed && wPressed && sPressed:
			quest.reached_goal()
			completeButton.visible = true
			questReady = false
		else:
			completeButton.visible = false
