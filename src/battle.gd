extends Control

signal textbox_closed

func _ready():
	$TextBox.hide()
	$ActionsPanel.hide()
	
	display_text("A wild enemy appears!")

func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $TextBox.visible:
		$TextBox.hide()
		emit_signal("textbox_closed")

func display_text(text):
	$TextBox/Label.text = text
	$TextBox.show()
