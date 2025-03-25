extends Control

# Reference to the main menu container (VBoxContainer)
@onready var main_menu = $VBoxContainer

# Reference to the submenu container (VBoxContainer2)
@onready var submenu = $VBoxContainer2

func _ready() -> void:
	# Hide the submenu initially
	submenu.visible = false
	# Show the main menu initially
	main_menu.visible = true

func _on_start_pressed() -> void:
	# Hide the main menu and show the submenu
	main_menu.visible = false
	submenu.visible = true

func _on_continue_pressed() -> void:
	print("Continue game")  # Add your logic here
	# Hide the submenu and show the main menu again
	submenu.visible = false
	main_menu.visible = true

func _on_new_game_pressed() -> void:
	print("Start new game")  # Add your logic here
	# Hide the submenu and show the main menu again
	submenu.visible = false
	main_menu.visible = true

func _on_settings_pressed() -> void:
	print("Open settings")  # Add your logic here

func _on_exit_pressed() -> void:
	get_tree().quit()  # Quit the game
