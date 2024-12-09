extends CharacterBody2D

var currentState = IDLE
var is_Chatting = false
var player
var playerInChatZone = false
signal goobSlain
signal playerRest

enum{
	IDLE
}

func _process(delta: float) -> void:
	$AnimatedSprite2D.play("idle_sleep")
	
	if playerInChatZone:
		if Input.is_action_just_pressed("chat"):
			print("Chatting with NPC")
			$Dialog.start()
			is_Chatting = true
	

func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		playerInChatZone = true

func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		playerInChatZone = false


func _on_dialog_ui_dialog_finished():
	is_Chatting = false


func _on_battle_goob_slain() -> void:
	emit_signal("goobSlain")


func _on_static_body_2d_player_is_resting() -> void:
	emit_signal("playerRest")
