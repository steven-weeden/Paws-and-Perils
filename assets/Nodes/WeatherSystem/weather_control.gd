extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var currentWeather = "none"
var playerInArea = false
var playerInRain = false
var playerInSun = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if playerInArea:
		currentWeather == "rain"
		if playerInRain == false:
			playerInRain = true
			playerInSun = true
			$AnimationPlayer.play("fadeRain")
		$rain.visible = true
		$rainColor.visible = true
		audio_stream_player.play()
	else:
		currentWeather == "none"
		if playerInSun == true:
			playerInSun = false
			playerInRain = false
			$AnimationPlayer.play("fadeSun")
			await get_tree().create_timer(1.5)
			audio_stream_player.stop()		
		$rain.visible = false
		$rainColor.visible = false	
		
		
func _process(delta: float) -> void:
	if playerInArea:
		currentWeather == "rain"
		if playerInRain == false:
			playerInRain = true
			playerInSun = true
			$AnimationPlayer.play("fadeRain")
		$rain.visible = true
		$rainColor.visible = true
		if audio_stream_player.playing == false:
			audio_stream_player.play()
	else:
		currentWeather == "none"
		if playerInSun == true:
			playerInSun = false
			playerInRain = false
			$AnimationPlayer.play("fadeSun")
			await get_tree().create_timer(1.5)
			audio_stream_player.stop()		
		#$rain.visible = false
		#$rainColor.visible = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		playerInArea = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	playerInArea = false
	
