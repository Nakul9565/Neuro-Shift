extends CanvasLayer  # or Control, must match root node

func _ready():
	# Safe node access
	var exit_button = $ExitButton as Button
	if exit_button:
		exit_button.pressed.connect(_on_exit_pressed)
	else:
		printerr("Error: ExitButton not found!")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_exit_pressed():
	get_tree().quit()
