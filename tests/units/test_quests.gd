extends GutTest

var _Quest = preload("res://assets/Nodes/QuestBar/Scripts/QuestFunc.gd")
var _testQuest

func before_each():
	_testQuest = _Quest.new()
	_testQuest.quest_status = QuestManager.QuestStatus.available
	_testQuest.quest_name = "Test Quest"
	_testQuest.quest_description = "Test Description"
	_testQuest.reached_goal_text = "Test Goal Reached"
	_testQuest.QuestTitle = RichTextLabel.new()
	_testQuest.QuestDescription = RichTextLabel.new()
	
	self._testQuest = _testQuest
	
func test_start_quest():
	_testQuest.start_quest()
	assert_eq(_testQuest.quest_status, QuestManager.QuestStatus.started, "Quest status should be 'started'")
	assert_eq(_testQuest.QuestTitle.text, "Test Quest", "Quest title should be updated")
	assert_eq(_testQuest.QuestDescription.text, "Test Description", "Quest description should be updated")
	
func test_reached_goal():
	# Transition to 'reached_goal' status
	_testQuest.quest_status = QuestManager.QuestStatus.started
	_testQuest.reached_goal()
	assert_eq(_testQuest.quest_status, QuestManager.QuestStatus.reached_goal, "Quest status should be 'reached_goal'")
	assert_eq(_testQuest.QuestDescription.text, "Test Goal Reached", "Quest description should reflect goal reached")

func test_finished_quest():
	# Transition to 'finished' status
	_testQuest.quest_status = QuestManager.QuestStatus.reached_goal 
	_testQuest.finished_quest()
	assert_eq(_testQuest.quest_status, QuestManager.QuestStatus.finished, "Quest status should be 'finished'")
	assert_eq(_testQuest.QuestTitle.text, "No Quest Currently.", "Quest title should reset")
	assert_eq(_testQuest.QuestDescription.text, "Come Back Later!", "Quest description should reset")
