extends Control

#@onready var game_scene = get_node("/root/World")

#Interact With Goornelius
@onready var yesButton = $Accept
@onready var noButton = $Decline
@onready var fightButton = $Fight
@onready var completeButton = $Complete

#Quest Variables
var currentQuest: Quest
@export var quest1: Quest
@export var quest2: Quest
@export var quest3: Quest

#Quest Checks Nodes
@onready var movementCheck = $MovementCheck
@onready var battleGoornCheck = $BattleGoornCheck
@onready var healCheck = $HealCheck

#Dialogue
@export_file("*.json") var d_file
signal dialogFinished
var dialog = []
var currentDialogID = 0
var dActive = false

func _ready() -> void:
	$NinePatchRect.visible = false
	movementCheck.quest = quest1
	battleGoornCheck.quest = quest2
	healCheck.quest = quest3
	if(Global.current_quest == 1):
		print("quest 1")
		quest1.set_quest_name()
		currentQuest = quest1
		if(Global.quest_status == 1):
			quest1.quest_status = QuestManager.QuestStatus.available
			quest1.start_quest()
			movementCheck.questReady = true
		elif(Global.quest_status == 2):
			quest1.quest_status = QuestManager.QuestStatus.started
			quest1.reached_goal()
		elif(Global.quest_status == 3):
			quest1.quest_status = QuestManager.QuestStatus.reached_goal
			quest1.finished_quest()
			quest2.quest_status = Quest.QuestStatus.available
			
	elif(Global.current_quest == 2):
		print("quest 2")
		quest2.set_quest_name()
		currentQuest = quest2
		if(Global.quest_status == 1):
			quest2.quest_status = QuestManager.QuestStatus.available
			quest2.start_quest()
			fightButton.visible = true
			battleGoornCheck.questReady = true
		elif(Global.quest_status == 2):
			quest2.quest_status = QuestManager.QuestStatus.started
			quest2.reached_goal()
			completeButton.visible = true
		elif(Global.quest_status == 3):
			quest2.quest_status = QuestManager.QuestStatus.reached_goal
			quest2.finished_quest()
			quest3.quest_status = Quest.QuestStatus.available
	
	elif(Global.current_quest == 3):
		print("quest 3")
		quest3.set_quest_name()
		currentQuest = quest3
		if(Global.quest_status == 1):
			quest3.quest_status = QuestManager.QuestStatus.available
			quest3.start_quest()
			healCheck.questReady = true
		elif(Global.quest_status == 2):
			quest3.quest_status = QuestManager.QuestStatus.started
			quest3.reached_goal()
			completeButton.visible = true
		elif(Global.quest_status == 3):
			quest3.quest_status = QuestManager.QuestStatus.reached_goal
			quest3.finished_quest()
	else:
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
	if currentQuest == quest3:
		if $NinePatchRect/Text.text == "Wanna do a quick quest?":
			if quest3.quest_status == Quest.QuestStatus.available:
				$NinePatchRect/Text.text = "Go Heal!"
				yesButton.visible = true
				noButton.visible = true
			elif quest3.quest_status == Quest.QuestStatus.started:
				$NinePatchRect/Text.text = "Go Heal."
			elif quest3.quest_status == Quest.QuestStatus.reached_goal:
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
			battleGoornCheck.quest = quest2
			battleGoornCheck.questReady = true
			fightButton.visible = true
	elif currentQuest == quest3:
		if quest3.quest_status == Quest.QuestStatus.available:
			print("Quest 3 Started")
			quest3.start_quest()
			healCheck.quest = quest3
			healCheck.questReady = true
			
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
		Global.current_quest = 1
		if quest1.quest_status == Quest.QuestStatus.reached_goal:
			quest1.finished_quest()
			quest2.quest_status = Quest.QuestStatus.available
			currentQuest = quest2
			completeButton.visible = false

	#Quest 2 Completion
	elif currentQuest == quest2:
		Global.current_quest = 2
		if quest2.quest_status == Quest.QuestStatus.reached_goal:
			quest2.finished_quest()
			quest3.quest_status = Quest.QuestStatus.available
			currentQuest = quest3
			completeButton.visible = false
			
	elif currentQuest == quest3:
		Global.current_quest = 3
		print(quest3.quest_status)
		if quest3.quest_status == Quest.QuestStatus.reached_goal:
			quest3.finished_quest()
			completeButton.visible = false
		
		
