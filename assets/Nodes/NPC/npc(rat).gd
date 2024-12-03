extends CharacterBody2D

var playerInArea = false

var battle = battleS.new()

func _ready() -> void:
	$AnimatedSprite2D.play("Idle")
	
func _process(delta: float) -> void:
	if playerInArea:
		$AnimatedSprite2D.play("Alarmed")
		get_tree().change_scene_to_file("res://src/battle.tscn")
		#var players = player.new()
		#players.start_battle()
		
	else:
		$AnimatedSprite2D.play("Idle")
			

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		playerInArea = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	playerInArea = false
