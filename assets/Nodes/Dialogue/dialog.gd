extends Control

@export_file("*.json") var d_file
signal dialogFinished

var dialog = []
var currentDialogID = 0
var dActive = false

func _ready() -> void:
	$NinePatchRect.visible = false
	
func start():
	if dActive:
		return
	dActive = true
	$NinePatchRect.visible = true
	dialog = load_dialog()
	currentDialogID = -1
	next_script()
	
func load_dialog():
	var file = FileAccess.open("res://assets/Nodes/Dialogue/dialog.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
	
	
func _input(event: InputEvent) -> void:
	if !dActive:
		return
	if event.is_action_pressed("ui_accept"):
		next_script()
		

func next_script():
	currentDialogID += 1
	if currentDialogID >= len(dialog):
		dActive = false
		$NinePatchRect.visible = false
		emit_signal("dialogFinished")
		return
		
	$NinePatchRect/Name.text = dialog[currentDialogID]["name"]
	$NinePatchRect/Text.text = dialog[currentDialogID]["text"]
