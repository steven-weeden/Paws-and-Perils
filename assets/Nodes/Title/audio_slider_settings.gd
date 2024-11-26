extends Control

@onready var audio_name_label: Label = $HBoxContainer/audio_name_label 
@onready var audio_num_label: Label = $HBoxContainer/audio_num_label
@onready var h_slider: HSlider = $HBoxContainer/HSlider

@export_enum("Master", "Music", "Sfx") var bus_name : String

var bus_index: int = 0

func _ready():
	h_slider.value_changed.connect(on_value_change)
	get_bus_name_index()
	set_name_label()
	set_slider_value()
		
func set_name_label():
	audio_name_label.text = str(bus_name) + " Volume" 


func set_num_label():
	audio_num_label.text = str(h_slider.value * 100) + "%"

func get_bus_name_index():
	bus_index = AudioServer.get_bus_index(bus_name)
	
func set_slider_value():
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_num_label()	
	
func on_value_change(value : float):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_num_label()
