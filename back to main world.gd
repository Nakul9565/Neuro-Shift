extends Area3D


func _on_body_entered(body):
	if body is CharacterBody3D:
		get_tree().change_scene_to_file("res://scenes/retro_scene-3.tscn")
