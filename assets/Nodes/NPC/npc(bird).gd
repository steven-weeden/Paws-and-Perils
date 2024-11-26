extends CharacterBody2D

const speed = 30
var currentState = IDLE
var dir = Vector2.RIGHT
var startPos
var isRoaming = true
var player

enum{
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready() -> void:
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
			

func choose(array):
	array.shuffle()
	return array.front()
		
func move(delta):
	velocity = dir * speed
	move_and_slide()

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5,1,1.5])
	currentState = choose([IDLE,NEW_DIR, MOVE])
