extends GutTest

var _Quest = preload("res://assets/Nodes/QuestBar/Scripts/QuestFunc.gd")
var _testQuest

var _movementQuest = preload("res://assets/Nodes/QuestBar/Scripts/MovementQuestCheck.gd")
var _testMovement

func before_each():
	_testQuest = _Quest.new()
	_testMovement = _movementQuest.new()
	
	_testQuest.quest_status = QuestManager.QuestStatus.started
	_testQuest.reached_goal_text = "Test Goal Reached"
	_testQuest.quest_name = "Test Quest"
	_testQuest.quest_description = "Test Description"
	
	self._testQuest = _testQuest
	
	_testMovement.quest = _testQuest
	_testMovement.aPressed = false
	_testMovement.dPressed = false
	_testMovement.wPressed = false
	_testMovement.sPressed = false
	_testMovement.completeButton = Button.new()
	_testMovement.completeButton.visible = false
	_testMovement.questReady = true
	
	self._testMovement = _testMovement

func after_each():
	pass
	
func test_on_ready():
	assert_false(_testMovement.completeButton.visible, "Complete Button Should be Hidden.")
	assert_false(_testMovement.aPressed, "aPressed should be initiated to False.")
	assert_false(_testMovement.dPressed, "dPressed should be initiated to False.")
	assert_false(_testMovement.wPressed, "wPressed should be initiated to False.")
	assert_false(_testMovement.sPressed, "sPressed should be initiated to False.")
	assert_eq(_testQuest.quest_status, QuestManager.QuestStatus.started, "Quests Should be at Status Started.")
	
func test_input_a():
	var _sender = InputSender.new(_testMovement)
	_sender.action_down("left").hold_for('5f')
	assert_true(_testMovement.aPressed, "A/left should have been pressed.")
	
func test_input_d():
	var _sender = InputSender.new(_testMovement)
	_sender.action_down("right").hold_for('5f')
	await(_sender.idle)
	assert_true(_testMovement.dPressed, "D/right should have been pressed.")

func test_input_w():
	var _sender = InputSender.new(_testMovement)
	_sender.action_down("up").hold_for('5f')
	await(_sender.idle)
	assert_true(_testMovement.wPressed, "W/up should have been pressed.")
	
func test_input_s():
	var _sender = InputSender.new(_testMovement)
	_sender.action_down("down").hold_for('5f')
	await(_sender.idle)
	assert_true(_testMovement.sPressed, "S/down should have been pressed.")

func test_input_awsd():
	var _sender = InputSender.new(_testMovement)
	_sender.action_down("left").hold_for('5f').action_down("right").hold_for('5f').action_down("up").hold_for('5f').action_down("down").hold_for('5f')
	await(_sender.idle)
	assert_true(_testMovement.aPressed, "A/Left should have been pressed.")
	assert_true(_testMovement.dPressed, "D/right should have been pressed.")
	assert_true(_testMovement.wPressed, "W/up should have been pressed.")
	assert_true(_testMovement.sPressed, "S/down should have been pressed.")
