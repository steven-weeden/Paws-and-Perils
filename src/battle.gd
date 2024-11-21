extends Control

signal textbox_closed

@export var enemies: Array = []  # Array of enemy Resource `.tres` files
@export var enemy: Resource = null

var current_player_health = 0
var current_enemy_health = 0
var is_defending = false


func _ready():
	randomize()  # Initialize random number generator
	enemy = enemies[int(randf() * enemies.size())]  # Randomly select an enemy
	
	set_health($EnemyContainer/ProgressBar, enemy.health, enemy.health)
	set_health($PlayerPanel/PlayerData/ProgressBar, State.current_health, State.max_health)
	$EnemyContainer/Enemy.texture = enemy.texture
	
	current_player_health = State.current_health
	current_enemy_health = enemy.health
	
	$TextBox.hide()
	$ActionsPanel.hide()
	
	display_text("A wild %s appears!" % enemy.name)
	await display_text_and_wait("A wild %s appears!" % enemy.name)
	$ActionsPanel.show()
	
	if enemy.name == "sans":
		display_text("Hey kiddo, How'd I end up here?")
		await display_text_and_wait("Hey kiddo, How'd I end up here?")

func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d" % [health, max_health]


func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $TextBox.visible:
		$TextBox.hide()
		emit_signal("textbox_closed")

func display_text_and_wait(text) -> void:
	display_text(text)
	await textbox_closed
	print("TextBox has been closed")
	$ActionsPanel.show()

func display_text(text):
	$ActionsPanel.hide()
	$TextBox/Label.text = text
	$TextBox.show()

func enemy_turn():
	display_text("%s swings at you" % enemy.name)
	await display_text_and_wait("%s swings at you" % enemy.name)
	
	if is_defending:
		is_defending = false
		
		display_text("You defended successfully!")
		await display_text_and_wait("You defended successfully!")
	else:
		current_player_health = max(0, current_player_health - enemy.damage)
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
	
		$AnimationPlayer.play("take_damage")
		await $AnimationPlayer.animation_finished
	
		display_text("You took %d damage!" % enemy.damage)
		await display_text_and_wait("You took %d damage!" % enemy.damage)
		
		if current_player_health == 0:
			display_text("MEOUCH! you died!")
			await display_text_and_wait("MEOUCH! you died!")
			
			$ActionsPanel.hide()
			$PlayerPanel.hide()
			$EnemyContainer.hide()
			
			$AnimationPlayer.play("player_death")
			await $AnimationPlayer.animation_finished
			
			
			
			await show_death_screen()
			return
	

func _on_run_pressed() -> void:
	$click_sound.play()
	
	display_text("Got away safely!")
	await display_text_and_wait("Got away safely!")
	await(get_tree().create_timer(0.5))
	get_tree().quit()


func _on_attack_pressed() -> void:
	$click_sound.play()
	
	display_text("You swing your paw")
	await display_text_and_wait("You swing your paw")
	
	current_enemy_health = max(0, current_enemy_health - State.damage)
	set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)
	
	$AnimationPlayer.play("enemy_damaged")
	await $AnimationPlayer.animation_finished
	
	display_text("You dealt %d damage!" % State.damage)
	await display_text_and_wait("You dealt %d damage!" % State.damage)
	
	if current_enemy_health == 0:
		display_text("MEOWTASTIC! You defeated %s!" % enemy.name)
		await display_text_and_wait("MEOWTASTIC! You defeated %s!" % enemy.name)
		
		$AnimationPlayer.play("DEATH")
		await $AnimationPlayer.animation_finished
		
		
		State.currentEXP += enemy.EXPDefeat
		
		
		await show_results_screen()
		return

	
	enemy_turn()
	
	
func show_results_screen():
	var results_scene = preload("res://src/results_screen.tscn")
	var results_screen = results_scene.instantiate()
	
	results_screen.get_node("EXP").text = "Gained %s XP!" % enemy.EXPDefeat
	results_screen.get_node("Gold").text = "Stole %s Gold!" % enemy.GoldDefeat
	
	# Update the XP progress bar on the results screen
	var exp_bar = results_screen.get_node("VBoxContainer/ProgressBar")
	exp_bar.value = State.currentEXP
	exp_bar.max_value = State.EXPNext
	
	get_tree().current_scene.add_child(results_screen)
	
	$ActionsPanel.hide()
	$PlayerPanel.hide()
	$EnemyContainer.hide()
	
	results_screen.get_node("Continue").connect("pressed", Callable(self, "_on_continue_pressed"))
	results_screen.show_screen()

func show_death_screen():
	var death_scene = preload("res://src/death_screen.tscn")
	var death_screen = death_scene.instantiate()
	
	
	
	
	
	get_tree().current_scene.add_child(death_screen)
	
	$ActionsPanel.hide()
	$PlayerPanel.hide()
	$EnemyContainer.hide()
	
	death_screen.get_node("actions_panel/Continue").connect("pressed", Callable(self, "_on_continue_pressed"))
	death_screen.get_node("actions_panel/load_game").connect("pressed", Callable(self, "_on_load_game_pressed"))
	
	death_screen.show_screen()

func _on_defend_pressed() -> void:
	$click_sound.play()
	is_defending = true
	
	display_text("you brace your paws ready for defense")
	await display_text_and_wait("you brace your paws ready for defense")
	
	enemy_turn()
	
	
