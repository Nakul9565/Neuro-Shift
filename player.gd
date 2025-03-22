extends CharacterBody3D

@export var speed = 5.0
@export var jump_force = 5.0
@export var gravity = 9.8
@export var dash_speed = 10.0
@export var dash_time = 0.3

var velocity = Vector3.ZERO
var is_dashing = false
var current_layer = 0  # 0 = 8-Bit, 1 = Polygon, 2 = Hologram
var layers = ["World_8Bit", "World_Polygon", "World_Hologram"]

func _process(delta):
	move()
	if Input.is_action_just_pressed("shift_layer"):
		shift_layer()
	if Input.is_action_just_pressed("fractal_dash") and not is_dashing:
		start_dash()

func move():
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_backward"):
		direction.z += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1

	direction = direction.normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y -= gravity * get_process_delta_time()
	
	move_and_slide()

func shift_layer():
	current_layer = (current_layer + 1) % 3
	for i in range(3):
		var world = get_node("../" + layers[i])
		world.visible = (i == current_layer)

func start_dash():
	is_dashing = true
	speed = dash_speed
	await get_tree().create_timer(dash_time).timeout
	speed = 5.0
	is_dashing = false
