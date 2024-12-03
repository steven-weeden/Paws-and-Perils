extends Node2D

class_name gameScene

var battle_scene: String = "res://src/battle.tscn"

var return_from_battle = false
var battle_finished = false

@onready var player = $player  # Adjust this path to your player node

func _ready() -> void:
	if State.player_position != Vector2.ZERO:
		player.position = State.player_position
	
	# Listen for the battle_finished signal from the global tree
	get_tree().connect("battle_finished", Callable(self, "_on_battle_finished"))

func start_battle(enemy_node: Node):
	if return_from_battle or battle_finished:
		return
	
	# Save player position and transition to the battle scene
	State.player_position = player.position
	return_from_battle = true
	get_tree().change_scene_to_file(battle_scene)

	# Mark the enemy to be removed after the battle
	enemy_node.queue_free()

func _on_battle_finished():
	finish_battle()

func finish_battle():
	# Reset state and ensure no looping
	return_from_battle = false
	battle_finished = true
	
	# Return to the player's position
	player.position = State.player_position
	print("Battle Finished in GameScene")
