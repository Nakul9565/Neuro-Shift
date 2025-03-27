extends Area3D

func _ready():
	# Verify setup
	print("Coin ready! Layers:", collision_layer, " Mask:", collision_mask)
	body_entered.connect(_on_coin_entered)

func _on_coin_entered(body):
	print("Entered:", body.name)
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://scenes/retro_scene-3.tscn")
