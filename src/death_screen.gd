extends Control


# Called when the node enters the scene tree for the first time.
func show_screen():
	self.show()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_continue_pressed() -> void:
	await get_tree().create_timer(0.25).timeout
	get_tree().quit()


func _on_load_game_pressed() -> void:
	await get_tree().create_timer(0.25).timeout
	get_tree().quit()
