extends Resource
class_name PlayerData

@export var savePos : Vector2

@export var slots: Array[InvSlot] = []


func updatePos(position: Vector2):
	savePos = position
	
func update_slots(new_slots: Array[InvSlot]):
	slots = new_slots
		
