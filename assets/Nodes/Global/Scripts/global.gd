extends Node

var pos:Vector2

var battle_finished: bool = false

var battle_start: bool = false

var return_from_battle = false

var goob_fight: bool = false

var enemy_id = 0

var rat_fight: bool = false
var bird_fight: bool = false
var cat_fight1: bool = false
var cat_fight2: bool = false
var cat_fight3: bool = false
var freddy_fight: bool = false

var current_quest = 0
var quest_status = 0

var health = 0

var picked_up_items = {}
var enemies_defeated = {}

func is_item_picked_up(item_id: String) -> bool:
	return picked_up_items.get(item_id, false)

func mark_item_picked_up(item_id: String):
	picked_up_items[item_id] = true

func is_enemy_fought(enemy_id: int) -> bool:
	if enemy_id == 0:
		pass
	return enemies_defeated.get(enemy_id, false)
	
func mark_enemy_defeated(enemy_id: int):
	enemies_defeated[enemy_id] = true
