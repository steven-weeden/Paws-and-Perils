extends Control

@onready var players = player.new()
# Called when the node enters the scene tree for the first time.
func show_screen():
	self.show()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_continue_pressed() -> void:
	await get_tree().create_timer(0.25).timeout
	Global.battle_finished = false
	get_tree().change_scene_to_file("res://assets/Scenes/GameScene.tscn")
	print("Battle Finished")
	end_battle()


func _on_load_game_pressed() -> void:
	await get_tree().create_timer(0.25).timeout
	Global.battle_finished = false
	get_tree().change_scene_to_file("res://assets/Scenes/GameScene.tscn")
	players.loadData()

func end_battle():
	emit_signal("battle_finished")
