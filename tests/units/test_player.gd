extends GutTest

var _player = preload("res://assets/Nodes/Player/scripts/player.gd")
var _testPlayer

var _playerScene = preload("res://assets/Nodes/Player/player.tscn")
var dir: Vector2

func before_each():
	var _playerInstance = _playerScene.instantiate() 
	_testPlayer = _player.new()
	_testPlayer.animatedSprite = _playerInstance.get_node("AnimatedSprite2D")
	_testPlayer.player_state = "walking"
	dir = Vector2.ZERO

func test_play_anim_idle():
	dir = Vector2(0.0, 0.0)
	_testPlayer.player_state = "idle"
	_testPlayer.play_anim(dir)
	print(_testPlayer.animatedSprite.animation)
	assert_eq(_testPlayer.animatedSprite.animation, "idle", "idle animation should be Played.")


func test_play_anim_n_walk():
	dir = Vector2(0.0, -1.0)
	_testPlayer.play_anim(dir)
	print(_testPlayer.animatedSprite.animation)
	assert_eq(_testPlayer.animatedSprite.animation, "n_walk", "n_walk animation should be Played.")
	

func test_play_anim_idle_s_walk():
	dir = Vector2(0.0, 1.0)
	_testPlayer.play_anim(dir)
	print(_testPlayer.animatedSprite.animation)
	assert_eq(_testPlayer.animatedSprite.animation, "s_walk", "s_walk animation should be Played.")
	

func test_play_anim_idle_w_walk():
	dir = Vector2(-1.0, 0.0)
	_testPlayer.play_anim(dir)
	print(_testPlayer.animatedSprite.animation)
	assert_eq(_testPlayer.animatedSprite.animation, "w_walk", "w_walk animation should be Played.")
	

func test_play_anim_idle_e_walk():
	dir = Vector2(1.0, 0.0)
	_testPlayer.play_anim(dir)
	print(_testPlayer.animatedSprite.animation)
	assert_eq(_testPlayer.animatedSprite.animation, "e_walk", "e_walk animation should be Played.")
	

func test_play_anim_idle_ne_walk():
	dir = Vector2(0.6, -0.6)
	_testPlayer.play_anim(dir)
	print(_testPlayer.animatedSprite.animation)
	assert_eq(_testPlayer.animatedSprite.animation, "ne_walk", "ne_walk animation should be Played.")
	

func test_play_anim_idle_se_walk():
	dir = Vector2(0.6, 0.6)
	_testPlayer.play_anim(dir)
	print(_testPlayer.animatedSprite.animation)
	assert_eq(_testPlayer.animatedSprite.animation, "se_walk", "se_walk animation should be Played.")
	
func test_play_anim_idle_sw_walk():
	dir = Vector2(-0.6, 0.6)
	_testPlayer.play_anim(dir)
	print(_testPlayer.animatedSprite.animation)
	assert_eq(_testPlayer.animatedSprite.animation, "sw_walk", "sw_walk animation should be Played.")
	
func test_play_anim_idle_nw_walk():
	dir = Vector2(-0.6, -0.6)
	_testPlayer.play_anim(dir)
	print(_testPlayer.animatedSprite.animation)
	assert_eq(_testPlayer.animatedSprite.animation, "nw_walk", "nw_walk animation should be Played.")
	
