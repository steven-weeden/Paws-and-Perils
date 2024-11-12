extends Node2D

var player_in_area = false

@export var item: inventoryItem

var buger = preload("res://assets/Nodes/Inventory/godotItems/bugar.tres")

var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.e


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player_in_area:
		if Input.is_action_just_pressed("interact"):
			player.collect(item)
			$AnimationPlayer.play("fade")
			$AudioStreamPlayer2D.play()
			print("+1 buger")
			queue_free()
			


func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body;

func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
