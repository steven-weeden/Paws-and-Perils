extends Control

signal save
signal load

func _ready() -> void:
	get_tree().paused = false
	$Panel.visible = false
	var position = $pos
	
func resume():
	get_tree().paused = false
	$Panel.visible = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$Panel.visible = true
	$AnimationPlayer.play("blur")
	
func escape():
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()
	
func _on_resume_pressed() -> void:
	resume()

func _on_save_pressed() -> void:
	emit_signal("save")

func _on_load_pressed() -> void:
	emit_signal("load")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _process(delta: float) -> void:
	escape()
