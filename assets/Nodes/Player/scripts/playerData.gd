extends Resource
class_name PlayerData

@export var savePos : Vector2

@export var slots: Array[InvSlot] = []

@export var saveHealth : int

func updatePos(position: Vector2):
	savePos = position
	
func update_slots(new_slots: Array[InvSlot]):
	slots = new_slots
		
func updateHealth(playerHealth : int):
	saveHealth = playerHealth
