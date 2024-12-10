extends CharacterBody2D

class_name birds

const speed = 30
var currentState = IDLE
var dir = Vector2.RIGHT
var startPos
var isRoaming = true
var player
var playerInArea
@onready var game_scene = get_node("/root/World")
@onready var battle = get_node("/root/World/Battle")
@export var enemy_id: int

enum{
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready() -> void:
	if Global.is_enemy_fought(enemy_id):
		queue_free()
	randomize()
	
func _process(delta: float) -> void:
	if currentState == 0 or currentState == 1:
		$AnimatedSprite2D.play("idle")
	elif currentState == 2:
		if dir.x == -1:
			$AnimatedSprite2D.play("fly(left)")
		if dir.x == 1:
			$AnimatedSprite2D.play("fly(right)")
	if isRoaming:
		match currentState:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.LEFT])
			MOVE:
				move(delta)
	
	if playerInArea:
		if Input.is_action_just_pressed("interact"):
			Global.bird_fight = true;
			game_scene.start_battle(enemy_id)  # Pass this enemy node to be removed
			

func choose(array):
	array.shuffle()
	return array.front()
		
func move(delta):
	velocity = dir * speed
	move_and_slide()

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5,1,1.5])
	currentState = choose([IDLE,NEW_DIR, MOVE])

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		playerInArea = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	playerInArea = false
