extends Node2D

var currentWeather = "none"
var playerInArea = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if playerInArea:
		currentWeather == "rain"
		#$AnimationPlayer.play("fadeRain")
		$rain.visible = true
		$rainColor.visible = true
	else:
		currentWeather == "none"
		#$AnimationPlayer.play("fadeSun")
		$rain.visible = false
		$rainColor.visible = false	
		
func _process(delta: float) -> void:
	if playerInArea:
		currentWeather == "rain"
		#$AnimationPlayer.play("fadeRain")
		$rain.visible = true
		$rainColor.visible = true
	else:
		currentWeather == "none"
		#$AnimationPlayer.play("fadeSun")
		$rain.visible = false
		$rainColor.visible = false		


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		playerInArea = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	playerInArea = false
	
