extends Control

class_name battleS

signal textbox_closed

@export var enemies: Array = []  # Array of enemy Resource `.tres` files
@export var enemy: Resource
@export var battle_finished: bool = false
@onready var rats = rat.new()
@onready var rat_res: Resource = preload("res://src/Rat.tres")
@onready var goob_res: Resource = preload("res://src/Goorn.tres")
@onready var battle_music: AudioStreamPlayer = $battle_music
@onready var players: player = $"../player"


var current_player_health = 0
var current_enemy_health = 0
var is_defending = false
var chance = 0
var rand = 0
var enm_choice
var goob_battle: bool = false


func _ready():
	if Global.battle_start == true:
		battle_music.play()
		Global.battle_start = false
	
		
	rats.connect("rat_battle", Callable(self, "rat_batt"))
	if Global.goob_fight == true:
		enemy = goob_res
		Global.goob_fight = false
	elif rat_batt():
		enemy = rat_res
		
	current_player_health = State.current_health
	current_enemy_health = enemy.health
	current_player_health = Global.health
		
	set_health($EnemyContainer/ProgressBar, enemy.health, enemy.health)
	set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
	$EnemyContainer/Enemy.texture = enemy.texture
	
	$TextBox.hide()
	$ActionsPanel.hide()
	
	display_text("A wild %s appears!" % enemy.name)
	await display_text_and_wait("A wild %s appears!" % enemy.name)
	$ActionsPanel.show()
	
	if enemy.name == "sans":
		display_text("Hey kiddo, How'd I end up here?")
		await display_text_and_wait("Hey kiddo, How'd I end up here?")
		
	chance = State.defense/10
	rand = (randi_range(1,2))/10

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
		
		#Base damage calculation
		var base_damage = max(1, enemy.damage - State.defense)  # Ensure at least 1 base damage
		var variance = 0.2  # Example variance of ±20%
		var min_damage = base_damage * (1.0 - variance)
		var max_damage = base_damage * (1.0 + variance)
		var damage = randf_range(min_damage, max_damage)
		
		#Critical check
		if randf() < enemy.crit:
			display_text("Critical hit by the enemy!")
			await display_text("Critical hit by the enemy!")
			damage *= 2.0
		
		#finalize damage
		damage = int(round(damage))  # Convert to integer
		
		current_player_health = max(0, current_player_health - damage)
		Global.health = current_player_health
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
	
		$AnimationPlayer.play("take_damage")
		await $AnimationPlayer.animation_finished
	
		display_text("You took %d damage!" % damage)
		await display_text_and_wait("You took %d damage!" % damage)
		
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
	#Global.battle_finished = true
	Global.return_from_battle = true
	current_player_health = Global.health
	print("PLAYER HEALTH", current_player_health)
	get_tree().change_scene_to_file("res://assets/Scenes/GameScene.tscn")
	print("Battle Finished")
	end_battle()


func _on_attack_pressed() -> void:
	$click_sound.play()
	
	display_text("You swing your paw")
	await display_text_and_wait("You swing your paw")
	
	#Dodge check
	if randf() < (enemy.agility / (enemy.agility + State.agility)):
		display_text("Enemy dodged!")
		await display_text("Enemy dodged!")
		enemy_turn()
		return
	
	#Calculate damage
	var base_damage = max(1, State.damage - enemy.defense)  #ensure non-negatve
	var variance = .2
	var min_damage = base_damage * (1.0 - variance)
	var max_damage = base_damage * (1.0 + variance)
	var damage = randf_range(min_damage, max_damage)
	
	#Critical hit check
	if randf() < State.crit:
		display_text("Critical hit!")
		await display_text("Critical hit!")
		damage *= 2.0
	
	damage = int(round(damage))
	
	current_enemy_health = max(0, current_enemy_health - damage)
	set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)
	
	$AnimationPlayer.play("enemy_damaged")
	await $AnimationPlayer.animation_finished
	
	display_text("You dealt %d damage!" % damage)
	await display_text_and_wait("You dealt %d damage!" % damage)
	
	if current_enemy_health == 0:
		display_text("MEOWTASTIC! You defeated %s!" % enemy.name)
		await display_text_and_wait("MEOWTASTIC! You defeated %s!" % enemy.name)
		
		$AnimationPlayer.play("DEATH")
		await $AnimationPlayer.animation_finished
		
		
		State.currentEXP += enemy.EXPDefeat
		
		if State.currentEXP == State.EXPNext:
			
			display_text("OH MEOW! You leveled up!")
			await display_text_and_wait("OH MEOW! You leveled up!")
			
			State.EXPNext += 5
			State.currentEXP = 0
			
			State.max_health += 5
			State.damage += 1
			State.agility += 1
			State.defense += 1
			State.crit += .02
		
		
		await show_results_screen()
		return

	
	enemy_turn()
	
	
func show_results_screen():
	battle_music.stop()
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
	if def_check(is_defending):
		is_defending = true
	else:
		is_defending = false
	
	display_text("you brace your paws ready for defense")
	await display_text_and_wait("you brace your paws ready for defense")
	
	enemy_turn()
# Helper functions for calculations
func end_battle():
	emit_signal("battle_finished")
	
func def_check(def_check) -> bool:
	def_check = false
	if chance >= rand:
		def_check = true
		return def_check
	else:
		def_check = false
		return def_check
	
func rat_batt() -> bool:
	return true


func _on_world_goob_battle() -> void:
	goob_battle = true
