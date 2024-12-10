extends Node2D

class_name gameScene

var battle_scene: String = "res://src/battle.tscn"

var battle_finished = false

var health = 0

signal update

signal pause

signal resume

@onready var player = $player  # Adjust this path to your player node

func _ready() -> void:
	if State.player_position != Vector2.ZERO:
		player.position = State.player_position
	player.current_health = State.current_health
	if Global.return_from_battle == true:
		player.current_health = Global.health
		Global.return_from_battle = false
	print(player.current_health)
	
func _process(delta: float) -> void:
	emit_signal("update")
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		emit_signal("pause")
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		emit_signal("resume")

func start_battle(enemy_id: int):
	# Save player position and transition to the battle scene
	State.player_position = player.position
	#State.current_health = player.current_health
	Global.health = player.current_health
	Global.enemy_id = enemy_id
	player.saveData()
	print("SAVING DATA")
	Global.battle_start = true
	get_tree().change_scene_to_file(battle_scene)
