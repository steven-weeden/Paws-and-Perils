extends Node

var pos:Vector2

var battle_finished: bool = false

var battle_start: bool = false

var return_from_battle = false

var goob_fight: bool = false

var rat_fight: bool = false
var bird_fight: bool = false
var cat_fight1: bool = false
var cat_fight2: bool = false
var cat_fight3: bool = false
var freddy_fight: bool = false

var current_quest = 0

var health = 0

var picked_up_items = {}

func is_item_picked_up(item_id: String) -> bool:
	print(picked_up_items)
	return picked_up_items.get(item_id, false)

func mark_item_picked_up(item_id: String):
	picked_up_items[item_id] = true
