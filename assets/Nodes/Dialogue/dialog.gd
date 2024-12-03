extends Control

#Interact With Goornelius
@onready var yesButton = $Accept
@onready var noButton = $Decline
@onready var completeButton = $Complete

#Quest Variables
var currentQuest: Quest
@export var quest1: Quest
@export var quest2: Quest


#Quest Checks Nodes
@onready var movementCheck = $MovementCheck

#Dialogue
@export_file("*.json") var d_file
signal dialogFinished
var dialog = []
var currentDialogID = 0
var dActive = false

func _ready() -> void:
	$NinePatchRect.visible = false
	currentQuest = quest1
	
func start():
	if dActive:
		return
	dActive = true
	$NinePatchRect.visible = true
	dialog = load_dialog()
	currentDialogID = -1
	next_script()
	
func load_dialog():
	var file = FileAccess.open("res://assets/Nodes/Dialogue/dialog.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
	
func _input(event: InputEvent) -> void:
	if !dActive:
		yesButton.visible = false
		noButton.visible = false
		return
	if event.is_action_pressed("ui_accept"):
		next_script()

func next_script():
	currentDialogID += 1
	if currentDialogID >= len(dialog):
		dActive = false
		$NinePatchRect.visible = false
		emit_signal("dialogFinished")
		return
	$NinePatchRect/Name.text = dialog[currentDialogID]["name"]
	$NinePatchRect/Text.text = dialog[currentDialogID]["text"]
	next_quest()

func next_quest():
	if currentQuest == quest1:
		if $NinePatchRect/Text.text == "Wanna do a quick quest?":
			if quest1.quest_status == Quest.QuestStatus.available:
				yesButton.visible = true
				noButton.visible = true
			elif quest1.quest_status == Quest.QuestStatus.started:
				$NinePatchRect/Text.text = "Press those movement keys for me!"
			elif quest1.quest_status == Quest.QuestStatus.reached_goal:
				$NinePatchRect/Text.text = "Congrats! You did it!"
			else:
				$NinePatchRect/Text.text = "Huh?? Nevermind, I forgot..."
	if currentQuest == quest2:
		if $NinePatchRect/Text.text == "Wanna do a quick quest?":
			if quest2.quest_status == Quest.QuestStatus.available:
				$NinePatchRect/Text.text = "I think we should try out a fight!"
				yesButton.visible = true
				noButton.visible = true
			elif quest2.quest_status == Quest.QuestStatus.started:
				$NinePatchRect/Text.text = "Lets fight!"
			elif quest2.quest_status == Quest.QuestStatus.reached_goal:
				$NinePatchRect/Text.text = "Congrats! You did it!"
			else:
				$NinePatchRect/Text.text = "Huh?? Nevermind, I forgot..."

func _on_accept_pressed() -> void:
	if currentQuest == quest1:
		if quest1.quest_status == Quest.QuestStatus.available:
			print("Quest 1 Started")
			quest1.start_quest()
			movementCheck.quest = quest1
			movementCheck.questReady = true
	elif currentQuest == quest2:
		if quest2.quest_status == Quest.QuestStatus.available:
			print("Quest 2 Started")
			quest2.start_quest()
			#Put whatever here
	
	#Deactive Everything
	if !dActive:
		yesButton.visible = false
		noButton.visible = false
		return
	next_script()

func _on_decline_pressed() -> void:
	#Deactivate Everything
	if !dActive:
		yesButton.visible = false
		noButton.visible = false
		return
	next_script()

func _on_complete_pressed() -> void:
	#Quest 1 Completion
	if currentQuest == quest1:
		if quest1.quest_status == Quest.QuestStatus.reached_goal:
			quest1.finished_quest()
			quest2.quest_status = Quest.QuestStatus.available
			currentQuest = quest2
			completeButton.visible = false

	#Quest 2 Completion
	elif currentQuest == quest2:
		if quest2.quest_status == Quest.QuestStatus.reached_goal:
			quest2.finished_quest()
			completeButton.visible = false
		
		
