extends Area3D

func _ready():
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		# Load and show win screen PROPERLY
		get_tree().change_scene_to_file("res://scenes/end-scene.tscn")
