extends Control

@export var game_scene: PackedScene  # Assign in the Inspector

func _ready():
	# Connect buttons to their functions
	# Correctly accessing buttons inside VBoxContainer
	$VBoxContainer/Button.pressed.connect(_on_play_pressed)
	$VBoxContainer/Button2.pressed.connect(_on_quit_pressed)


func _on_play_pressed():
	if game_scene:
		get_tree().change_scene_to_packed(game_scene)  # Load Retro Map

func _on_quit_pressed():
	get_tree().quit()  # Exit the game
