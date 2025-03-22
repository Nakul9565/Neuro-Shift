extends CharacterBody3D

var phase = 1
var attack_timer = 0.0
var player

func _ready():
	player = get_node("../Player")

func _process(delta):
	attack_timer += delta
	if attack_timer > 3:
		if phase == 1:
			attack_phase_1()
		elif phase == 2:
			attack_phase_2()
		attack_timer = 0

func attack_phase_1():
	print("Boss firing lasers in current layer")
	if player.current_layer == 0:
		fire_laser()

func attack_phase_2():
	print("Boss shifting layers to attack")
	shift_layer_random()

func fire_laser():
	var laser = preload("res://laser.tscn").instantiate()
	laser.position = position
	get_parent().add_child(laser)

func shift_layer_random():
	var new_layer = randi() % 3
	print("Boss is now attacking in layer: ", new_layer)
