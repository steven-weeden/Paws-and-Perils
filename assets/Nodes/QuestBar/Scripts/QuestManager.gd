class_name QuestManager extends Node2D

@onready var QuestTitle: RichTextLabel = get_node("/root/World/player/UILayer/Quest/QuestText/RichTextLabel")
@onready var QuestDescription: RichTextLabel = get_node("/root/World/player/UILayer/Quest/QuestText/RichTextLabel2")

@export_group("Quest Settings")
@export var quest_name: String
@export var quest_description: String
@export var reached_goal_text: String

enum QuestStatus{
	unavailable,
	available,
	started,
	reached_goal,
	finished,
}

@export var quest_status: QuestStatus = QuestStatus.available

@export_group("Reward Settings")
@export var reward_amount_xp: int
@export var reward_amount_money: int
