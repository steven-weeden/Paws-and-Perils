extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var currentWeather = "none"
var playerInArea = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if playerInArea:
		currentWeather == "rain"
		#$AnimationPlayer.play("fadeRain")
		$rain.visible = true
		$rainColor.visible = true
		audio_stream_player.play()
	else:
		currentWeather == "none"
		#$AnimationPlayer.play("fadeSun")
		$rain.visible = false
		$rainColor.visible = false	
		audio_stream_player.stop()
		
func _process(delta: float) -> void:
	if playerInArea:
		currentWeather == "rain"
		#$AnimationPlayer.play("fadeRain")
		$rain.visible = true
		$rainColor.visible = true
		if audio_stream_player.playing == false:
			audio_stream_player.play()
	else:
		currentWeather == "none"
		#$AnimationPlayer.play("fadeSun")
		$rain.visible = false
		$rainColor.visible = false
		audio_stream_player.stop()		


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		playerInArea = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	playerInArea = false
	
