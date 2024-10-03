extends CharacterBody2D

var currentState = IDLE

var is_Chatting = false

var player
var playerInChatZone = false

enum{
	IDLE
}

func _process(delta: float) -> void:
	$AnimatedSprite2D.play("Idle")
	
	if Input.is_action_just_pressed("chat"):
		print("Chatting with NPC")
		is_Chatting = true
	


func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
		playerInChatZone = true


func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		playerInChatZone = false
