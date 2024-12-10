extends CharacterBody2D

var playerInArea = false
@onready var game_scene = get_node("/root/World")
@onready var battle = get_node("/root/World/Battle")
@onready var battles = battleS.new()
@export var enemy_id: int
var battle_started = false  # Tracks if the battle has started
var path = "res://src/Rat.tres"

func _ready() -> void:
	if Global.is_enemy_fought(enemy_id):
		queue_free()
	$AnimatedSprite2D.play("idle")
	$PointLight2D2.visible = false
	$PointLight2D3.visible = false
	#battles.connect("battle_finished", Callable(self, "_on_battle_finished"))
	#battle.connect("battle_finished", Callable(self, "_on_battle_finished"))

func _process(delta: float) -> void:
	if playerInArea:
		$AnimatedSprite2D.play("alert")
		$PointLight2D2.visible = true
		$PointLight2D3.visible = true
		if Input.is_action_just_pressed("interact"):
			Global.freddy_fight = true
			game_scene.start_battle(enemy_id)  # Pass this enemy node to be removed
			
			

# Triggered when the player enters the enemy area
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		playerInArea = true

# Triggered when the player exits the enemy area
func _on_area_2d_body_exited(body: Node2D) -> void:
	playerInArea = false
	await get_tree().create_timer(1.5).timeout
	$PointLight2D2.visible = false
	$PointLight2D3.visible = false
	$AnimatedSprite2D.play("idle")
