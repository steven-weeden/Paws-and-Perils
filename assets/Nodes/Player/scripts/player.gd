extends CharacterBody2D

class_name player

@export var health = 40
@export var current_health = 5
@export var strength = 1
@export var agility = 1
@export var defense = 1
@export var crit_dmg = .25
@export var level = 1
@export var inv: inventory
@export var gold = 1
@export var currentEXP = 0

@export var sfx_footsteps : AudioStream
var footstep_frames : Array = [1]

var return_from_battle = false

var speed = 600
var player_state 
var toggleLight = false

var savePath = "user://saves/"
var saveName = "PlayerSave.tres"
var playerData = PlayerData.new()
var battle = battleS.new()

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
	
	for i in range(playerData.slots.size()):
		if playerData.slots[i] == null:
			playerData.slots[i] = InvSlot.new()

	#self.inv.slots = playerData.slots
	#self.inv.emit_signal("update")

func _process(delta: float):
	playerData.updatePos(self.position)
	playerData.update_slots(self.inv.slots)
	
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

func load_sfx(sfx_to_load):
	if $sfx_player.stream != sfx_to_load:
		$sfx_player.stop()
		$sfx_player.stream = sfx_to_load

func collect(item):
	inv.insert(item)
	
func player():
	pass

func _on_pause_menu_load() -> void:
	loadData()

func _on_pause_menu_save() -> void:
	saveData()

func _on_animated_sprite_2d_frame_changed() -> void:
	if $AnimatedSprite2D.animation == "idle": 
		return
	load_sfx(sfx_footsteps)
	if $AnimatedSprite2D.frame in footstep_frames:
		$sfx_player.play()
	
func get_dmg() -> int:
	var dmg = ((strength * 0.5) + randi_range(1,5))
	return dmg
	
func def_check(def_check) -> bool:
	def_check = false
	var chance = defense/10
	var rand = (randi_range(1,10))/100
	if chance >= rand:
		def_check = true
		return def_check
	else:
		def_check = false
		return def_check
