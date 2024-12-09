extends CharacterBody2D

const speed = 30
var currentState = IDLE
var dir = Vector2.RIGHT
var startPos
var isRoaming = true
var player
var playerInArea = false
@onready var game_scene = get_node("/root/World")

@export var cat_id: int

enum{
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready() -> void:
	randomize()
	
func _process(delta: float) -> void:
	if currentState == 0 or currentState == 1:
		$AnimatedSprite2D.play("Idle")
	elif currentState == 2:
		if dir.x == -1:
			$AnimatedSprite2D.play("walkWest")
		if dir.x == 1:
			$AnimatedSprite2D.play("walkEast")
		if dir.y == -1:
			$AnimatedSprite2D.play("walkNorth")
		if dir.y == 1:
			$AnimatedSprite2D.play("walkSouth")
	if isRoaming:
		match currentState:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
			MOVE:
				move(delta)
	if playerInArea:
		if Input.is_action_just_pressed("interact"):
			if cat_id == 1:
				Global.cat_fight1 = true
			elif cat_id == 2:
				Global.cat_fight2 = true
			elif cat_id == 3:
				Global.cat_fight3 = true
			game_scene.start_battle(self)  # Pass this enemy node to be removed
			

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
