extends Area2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("chat") and len(get_overlapping_bodies()) > 0:
		use_dialog()

func use_dialog():
	var dialogue = get_parent().get_node(("Dialog"))
	
	if dialogue:
		dialogue.start()
