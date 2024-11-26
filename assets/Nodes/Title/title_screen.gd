class_name TitleScreen
extends Control

@onready var start_level = preload("res://assets/Scenes/GameScene.tscn") as PackedScene	
@onready var options_menu: OptionsMenu = $options_menu

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)


func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_options_button_pressed() -> void:
	$MarginContainer.visible = false
	options_menu.set_process(true)
	$options_menu.visible = true


func _on_options_menu_exit_options_menu() -> void:
	$MarginContainer.visible = true
	$options_menu.visible = false
