extends Control

@onready var animation_player = $AnimationPlayer
@onready var music_player = $MusicPlayer  # Reference to the AudioStreamPlayer node


func show_screen():
	# Play the animation when the results screen is shown
	animation_player.play("results_cat")
	music_player.play()  # Start the song

func _ready():
	# Optionally call show_screen automatically on scene load
	show_screen()

func _on_continue_pressed() -> void:
	await get_tree().create_timer(0.25).timeout
	get_tree().quit()
