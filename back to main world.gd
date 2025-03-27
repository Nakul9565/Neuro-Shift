extends Area3D


func _on_body_entered(body):
	if body is CharacterBody3D:
		print("Player entered, switching scene...")  # Debugging
		call_deferred("change_scene", "res://scenes/retro_scene-3.tscn")  # Pass the scene path

func change_scene(scene_path: String) -> void:
	print("Checking if scene exists:", scene_path)  # Debugging
	if ResourceLoader.exists(scene_path):
		print("Scene found! Switching now...")
		get_tree().change_scene_to_file(scene_path)
	else:
		print("Error: Scene not found - " + scene_path)
