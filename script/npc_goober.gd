extends CharacterBody2D

var current_state = IDLE

var is_idle = true
var is_chatting = false

var player
var player_in_chat_zone = false

enum {
	IDLE,
	SHAKE,
	SLEEP,
	TURN
}

func _process(delta):
		if current_state == 0:
			$AnimatedSprite2D.play("idle")
		elif current_state == 1:
			$AnimatedSprite2D.play("idle_shake")
		elif current_state == 2 and !is_chatting:
			$AnimatedSprite2D.play("sleeping")
		elif current_state == 3:
			$AnimatedSprite2D.play("look_around")
			


func _on_chat_detection_area_body_entered(body: Node2D):
		if body.has_method("player"):
			player = body
			player_in_chat_zone = true



func _on_chat_detection_area_body_exited(body: Node2D) -> void:
		if body.has_method("player"):
			player_in_chat_zone = false
