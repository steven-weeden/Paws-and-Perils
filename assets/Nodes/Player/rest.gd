extends StaticBody2D

var playerInArea = false
signal playerIsResting

func _ready() -> void:
	$Cat.visible = false
	$Box.play("box(no cat)")
	
func _process(delta: float) -> void:
	if playerInArea:
		$Cat.visible = true
		$Cat.play("Sleep")
		emit_signal("playerIsResting")
	else:
		$Cat.visible = false
		$Box.play("box(no cat)")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		playerInArea = true
		body.visible = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		playerInArea = false
		body.visible = true
