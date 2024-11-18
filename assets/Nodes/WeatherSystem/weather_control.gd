extends StaticBody2D

var currentWeather = "rain"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if currentWeather == "none":
		$rain.visible = false
		$rainColor.visible = false
	if currentWeather == "rain":
		$rain.visible = true
		$rainColor.visible = true	


func _on_timer_timeout() -> void:
	if currentWeather == "none":
		currentWeather = "rain"
		$Timer.wait_time = randf_range(10.0,30.0)
		$Timer.start()
	elif currentWeather == "rain":
		currentWeather = "none"
		$Timer.wait_time = randf_range(20.0,60.0)
		$Timer.start()
		
func _process(delta: float) -> void:
	if currentWeather == "none":
		$rain.visible = false
		$rainColor.visible = false
	if currentWeather == "rain":
		$rain.visible = true
		$rainColor.visible = true	
