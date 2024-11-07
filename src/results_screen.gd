extends Control

@onready var animation_player = $AnimationPlayer
@onready var music_player = $MusicPlayer  # Reference to the AudioStreamPlayer node
@onready var xp_progress_bar = $VBoxContainer/ProgressBar


func show_screen():
	# Play the animation when the results screen is shown
	animation_player.play("results_cat")
	music_player.play()  # Start the song
	
	# Set the XP progress

func _ready():
	# Optionally call show_screen automatically on scene load
	show_screen()
	

func update_exp_bar():
	# Optionally set values from State if not passed as parameters
	xp_progress_bar.value = State.current_exp
	xp_progress_bar.max_value = State.EXPNextLevel

func _on_continue_pressed() -> void:
	await get_tree().create_timer(0.25).timeout
	get_tree().quit()
