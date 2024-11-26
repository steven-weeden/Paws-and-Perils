extends CharacterBody2D

var playerInArea = false

func _ready() -> void:
	$AnimatedSprite2D.play("Idle")
	
func _process(delta: float) -> void:
	if playerInArea:
		$AnimatedSprite2D.play("Alarmed")
	else:
		$AnimatedSprite2D.play("Idle")
			

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		playerInArea = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	playerInArea = false
