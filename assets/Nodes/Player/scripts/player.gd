extends CharacterBody2D

class_name player

const walk_speed = 325

@onready var animatedSprite = $AnimatedSprite2D

@export var health = 40
@export var current_health = 40
@export var strength = 5
@export var agility = 1
@export var defense = 1
@export var crit_dmg = .25
@export var level = 1
@export var inv: inventory
@export var gold = 1
@export var currentEXP = 0

@onready var animation_player: AnimationPlayer = $AnimationPlayer


@export var sfx_footsteps : AudioStream
var footstep_frames : Array = [1]

var return_from_battle = false

var speed = walk_speed
var player_state = "idle"
var toggleLight = false
var isResting = false

var savePath = "user://saves/"
var saveName = "PlayerSave.tres"
var playerData = PlayerData.new()
var battle = battleS.new()

func _ready() -> void:
	$PointLight2D.visible = false
	verifySave(savePath)
	player_state = "idle"
	
	

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
	self.current_health = playerData.saveHealth
	
	for i in range(playerData.slots.size()):
		if playerData.slots[i] == null:
			playerData.slots[i] = InvSlot.new()

	#self.inv.slots = playerData.slots
	#self.inv.emit_signal("update")

func _process(delta: float):
	playerData.updatePos(self.position)
	playerData.update_slots(self.inv.slots)
	playerData.updateHealth(self.current_health)
	
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
		animatedSprite.play("idle")
	if player_state == "walking":
		if dir.y == -1:
			animatedSprite.play("n_walk")
		if dir.y == 1:
			animatedSprite.play("s_walk")
		if dir.x == -1:
			animatedSprite.play("w_walk")
		if dir.x == 1:
			animatedSprite.play("e_walk")
		
		if dir.x > 0.5 and dir.y < -0.5:
			animatedSprite.play("ne_walk")
		if dir.x > 0.5 and dir.y > 0.5:
			animatedSprite.play("se_walk")
		if dir.x < -0.5 and dir.y > 0.5:
			animatedSprite.play("sw_walk")
		if dir.x < -0.5 and dir.y < -0.5:
			animatedSprite.play("nw_walk")		

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
		
func _on_static_body_2d_player_is_resting() -> void:
	$"transition/AnimationPlayer".play("TransIn")
	speed = 0
	$sfx_player.stop()
	await get_tree().create_timer(1.5).timeout
	$"transition/AnimationPlayer".play("TransOut")
	self.current_health = health
	Global.health = self.current_health
	speed = walk_speed


func _on_world_update() -> void:
	$"UILayer/ProgressBar".update()
	$"UILayer/TextureProgressBar".update()
