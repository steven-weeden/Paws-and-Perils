extends CharacterBody2D

var playerInArea = false
@onready var game_scene = get_node("/root/World")
@onready var battle = get_node("/root/World/Battle")
@onready var battles = battleS.new()
var battle_started = false  # Tracks if the battle has started
var path = "res://src/Rat.tres"


var defeated = 0

func _ready() -> void:
	$AnimatedSprite2D.play("Idle")
	battles.connect("battle_finished", Callable(self, "_on_battle_finished"))
	battle.connect("battle_finished", Callable(self, "_on_battle_finished"))

func _process(delta: float) -> void:
	if Global.battle_finished == true:
		print("Q FREE")
		self.queue_free()
	if playerInArea:
		if Global.battle_finished == false:
			if Input.is_action_just_pressed("interact"):
				defeated = 1
				game_scene.start_battle(self)  # Pass this enemy node to be removed
			
			

# Triggered when the player enters the enemy area
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		playerInArea = true

# Triggered when the player exits the enemy area
func _on_area_2d_body_exited(body: Node2D) -> void:
	playerInArea = false
	
# Called after the battle ends to delete the enemy
func remove_enemy():
	queue_free()  # Deletes the enemy node


func _on_battle_battle_finished() -> void:
	print("Signal Recieved")
	defeated = 1
	self.queue_free()

func _on_battle_finished() -> void:
	print("Signal Recieved")
	defeated = 1
	self.queue_free()
	
