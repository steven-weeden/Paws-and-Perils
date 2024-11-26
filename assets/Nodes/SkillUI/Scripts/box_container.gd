extends BoxContainer

@onready var amount_textH = $health/Label
@onready var amount_textS = $strength/Label
@onready var amount_textA = $agility/Label
@onready var amount_textD = $defense/Label
@onready var amount_textC = $crit_dmg/Label
@onready var amount_textL = $level/Label

var is_open = false

@onready var player_stats = player.new()

var health
var str
var agi
var def
var crit_dmg
var level

func _ready() -> void:
	close()
	health = player_stats.health
	str = player_stats.strength
	agi = player_stats.agility
	def = player_stats.defense
	crit_dmg = player_stats.crit_dmg
	level = player_stats.level

func _process(_delta):
	amount_textL.text = str(level)
	amount_textH.text = str(health)
	amount_textS.text = str(str)
	amount_textA.text = str(agi)
	amount_textD.text = str(def)
	amount_textC.text = str(crit_dmg).pad_decimals(1)
	if Input.is_action_just_pressed("tab"):
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
