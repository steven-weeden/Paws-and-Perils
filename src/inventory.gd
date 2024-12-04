extends Node2D

@onready var inv: inventory = preload("res://assets/Nodes/Inventory/godotItems/playerInventory.tres")
@onready var grid_container = $InventoryUI/NinePatchRect2/GridContainer
@onready var slots: Array = []

var is_open = false

func _ready():
	if grid_container:
		slots = grid_container.get_children()
		print("Slots intitalized : ", slots.size())
		inv.update.connect(update_slots)
		update_slots()
		close() 
	else:
		print("Error: GridContainer not found! Check node path.")
	
func update_slots():
	if slots.size() > 0:
		for i in range(min(inv.slots.size(), slots.size())):
			slots[i].update(inv.slots[i])
	else:
		print("No slots available to update!")

func _process(_delta):
	if Input.is_action_just_pressed("tab"):
		if is_open:
			close()
		else:
			open()

func open():
	$InventoryUI.visible = true
	is_open = true

func close():
	$InventoryUI.visible = false
	is_open = false
