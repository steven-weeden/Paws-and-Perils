extends Node2D

var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	is_open = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("tab"):
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
