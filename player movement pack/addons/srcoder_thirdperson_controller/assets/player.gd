extends CharacterBody3D

@export_category("Player Movement")
@export var speed := 5.0
@export var jump_velocity := 4.5
const ROTATION_SPEED := 6.0

@onready var camera_pivot : Node3D = $camera_pivot
@onready var playermodel : Node3D = $playermodel

enum animation_state {IDLE, RUNNING, JUMPING}
var player_animation_state : animation_state = animation_state.IDLE
@onready var animation_player : AnimationPlayer = $"playermodel/character-male-e2/AnimationPlayer"

# Jump and Run Sounds
@onready var jump_sound : AudioStreamPlayer3D = $JumpSound
@onready var run_sound : AudioStreamPlayer3D = $RunSound

var is_cursor_locked = true  # Track cursor state

func _ready():
	# Lock the cursor when the game starts
	lock_cursor()

func _input(event):
	# Toggle cursor lock/unlock with ESC
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			is_cursor_locked = not is_cursor_locked
			if is_cursor_locked:
				lock_cursor()
			else:
				unlock_cursor()
		
		# Check for Shift + T to change scene
		if event.pressed and event.keycode == KEY_T and event.shift_pressed:
			change_scene("res://scenes/future scene.tscn")

func change_scene(scene_path: String) -> void:
	# Ensure the scene exists before switching
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		print("Error: Scene not found - " + scene_path)


func lock_cursor():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func unlock_cursor():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		if jump_sound:
			jump_sound.play()

	# Get the input direction
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction = (camera_pivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		rotate_model(direction, delta)

		if is_on_floor():  # Only play run sound if the player is on the ground
			player_animation_state = animation_state.RUNNING
			if not run_sound.playing:
				run_sound.play()
		else:
			player_animation_state = animation_state.JUMPING
			run_sound.stop()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		player_animation_state = animation_state.IDLE
		run_sound.stop()
	
	move_and_slide()

	# Play animations based on state
	match player_animation_state:
		animation_state.IDLE:
			animation_player.play("idle")
		animation_state.RUNNING:
			animation_player.play("sprint")
		animation_state.JUMPING:
			animation_player.play("jump")

func rotate_model(direction: Vector3, delta : float) -> void:
	# Rotate the model to match the movement direction
	playermodel.basis = lerp(playermodel.basis, Basis.looking_at(direction), 10.0 * delta)
