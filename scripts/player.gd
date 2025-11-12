extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var invincibility_timer = $InvincibilityTimer

var is_invincible = false
var is_victorious = false
var is_dead = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal hit_by_yarn
signal catnip_collected
signal reached_top

func _ready():
	invincibility_timer.timeout.connect(_on_invincibility_timeout)

func _physics_process(delta):
	# Freeze controls if victorious
	if is_victorious:
		velocity.x = 0
		velocity.y = 0
		return
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		AudioManager.play_sound("jump")
		# Animation would play here if set up
		# if animation_player and animation_player.has_animation("jump"):
		#	animation_player.play("jump")

	# Get horizontal input direction
	var direction = Input.get_axis("move_left", "move_right")

	# Apply horizontal movement
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0
		# Animation would play here if set up
		# if is_on_floor() and animation_player and animation_player.has_animation("run"):
		#	animation_player.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		# Animation would play here if set up
		# if is_on_floor() and animation_player and animation_player.has_animation("idle"):
		#	animation_player.play("idle")

	# Falling animation would play here if set up
	# if velocity.y > 0 and not is_on_floor():
	#	if animation_player and animation_player.has_animation("fall"):
	#		animation_player.play("fall")

	move_and_slide()

func collect_catnip():
	is_invincible = true
	invincibility_timer.start(10.0)
	AudioManager.play_sound("catnip")
	catnip_collected.emit()

	# Visual feedback for invincibility
	if sprite:
		var tween = create_tween()
		tween.set_loops()
		tween.tween_property(sprite, "modulate:a", 0.5, 0.2)
		tween.tween_property(sprite, "modulate:a", 1.0, 0.2)

func _on_invincibility_timeout():
	is_invincible = false
	if sprite:
		sprite.modulate.a = 1.0

func hit_by_flaming_yarn():
	if not is_invincible and not is_dead:
		AudioManager.play_sound("hit")
		hit_by_yarn.emit()
		die()

func die():
	is_dead = true
	set_physics_process(false)

	# Disable all collisions
	collision_layer = 0
	collision_mask = 0

	# Immediately turn greyscale and fade out over 10 seconds
	if sprite:
		# Apply greyscale shader
		var shader = load("res://shaders/greyscale.gdshader")
		var shader_material = ShaderMaterial.new()
		shader_material.shader = shader
		shader_material.set_shader_parameter("saturation", 0.0)
		sprite.material = shader_material

		# Fade out over 5 seconds (50% faster)
		var tween = create_tween()
		tween.tween_property(sprite, "modulate:a", 0.0, 5.0)

	# Animation would play here if set up
	# if animation_player and animation_player.has_animation("death"):
	#	animation_player.play("death")
	# Game over will be handled by the main scene

func get_invincibility_time_remaining():
	return invincibility_timer.time_left if is_invincible else 0.0

func victory():
	# Stop any invincibility flashing
	if sprite:
		sprite.modulate.a = 1.0

	# Kitty can now walk freely in the garden - don't freeze or fade out
