class_name Quest extends QuestManager

func start_quest() -> void:
	if quest_status == QuestStatus.available:
		print(quest_status)
		quest_status = QuestStatus.started
		print(quest_status)
		QuestTitle.text = quest_name
		QuestDescription.text = quest_description
		print("Quest Started")
	
func reached_goal() -> void: 
	if quest_status == QuestStatus.started:
		quest_status = QuestStatus.reached_goal
		QuestDescription.text = reached_goal_text
		print("Quest Goal Achieved")

func finished_quest() -> void:
	if quest_status == QuestStatus.reached_goal:
		quest_status = QuestStatus.finished
		QuestTitle.text = "No Quest Currently."
		QuestDescription.text = "Come Back Later!"
		#if we're using xp or money, insert it here
		print("Quest Completed!")
