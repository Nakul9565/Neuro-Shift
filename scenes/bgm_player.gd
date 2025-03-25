extends AudioStreamPlayer

var is_paused = false  # Track if the music is paused

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):  # ESC key
		if is_paused:
			play()  # Resume music
		else:
			stop()  # Pause music
		is_paused = !is_paused  # Toggle state
