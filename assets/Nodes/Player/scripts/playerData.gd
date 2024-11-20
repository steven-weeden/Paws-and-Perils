extends Resource
class_name PlayerData

@export var savePos : Vector2

func updatePos(position: Vector2):
	savePos = position
