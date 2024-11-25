extends CharacterBody2D

var speed = 150

var player_state 

var toggleLight = false

@export var inv: inventory

var savePath = "res://assets/Nodes/Save/"
var saveName = "PlayerSave.tres"
var playerData = PlayerData.new()

func _ready() -> void:
	$PointLight2D.visible = false
	verifySave(savePath)

func verifySave(path: String):
	DirAccess.make_dir_absolute(path)

func loadData():
	if(ResourceLoader.exists(savePath + saveName)):
		playerData = ResourceLoader.load(savePath + saveName)
	playerData = ResourceLoader.load(savePath + saveName).duplicate(true)
	on_start_load()
	print("loaded")

func saveData():
	ResourceSaver.save(playerData, savePath + saveName)
	print("saved")
	
func on_start_load():
	self.position = playerData.savePos

func _process(delta: float):
	playerData.updatePos(self.position)
	
func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
		
	velocity = direction * speed
	move_and_slide()
	play_anim(direction)
	
	if Input.is_action_just_pressed("light"):
		if not toggleLight:
			$PointLight2D.visible = true
			toggleLight = true
		else:
			$PointLight2D.visible = false
			toggleLight = false
	
func play_anim(dir):
	
	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	if player_state == "walking":
		if dir.y == -1:
			$AnimatedSprite2D.play("n_walk")
		if dir.y == 1:
			$AnimatedSprite2D.play("s_walk")
		if dir.x == -1:
			$AnimatedSprite2D.play("w_walk")
		if dir.x == 1:
			$AnimatedSprite2D.play("e_walk")
		
		if dir.x > 0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("ne_walk")
		if dir.x > 0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("se_walk")
		if dir.x < -0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("sw_walk")
		if dir.x < -0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("nw_walk")		

func player():
	pass

func _on_pause_menu_load() -> void:
	loadData()

func _on_pause_menu_save() -> void:
	saveData()
