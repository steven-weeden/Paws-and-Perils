extends Node2D

var player_in_area = false

@export var item: inventoryItem

var buger = preload("res://assets/Nodes/Inventory/godotItems/sushi.tres")

var player = null

@export var item_id: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.is_item_picked_up(item_id):
		queue_free() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player_in_area:
		if Input.is_action_just_pressed("interact"):
			Global.mark_item_picked_up(item_id)
			player.collect(item)
			$AnimationPlayer.play("fade")
			$AudioStreamPlayer2D.play()
			print("+1 sushi")
			queue_free()
			


func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body;

func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
