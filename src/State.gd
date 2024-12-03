extends Node

var players = player.new()

var player_position: Vector2 = Vector2.ZERO

var current_health = players.current_health

var max_health = players.health
var damage = players.get_dmg()
var agility = players.agility
var defense = players.defense
var crit = players.crit_dmg

var money = players.gold
var currentEXP = players.currentEXP
var EXPNext = 30
