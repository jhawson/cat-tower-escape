extends RigidBody2D

@onready var sprite = $Sprite2D
@onready var particles = $GPUParticles2D
@onready var collision_shape = $CollisionShape2D
@onready var area = $Area2D

var fall_speed = 400.0
var sway_time = 0.0
var sway_speed = 2.0  # How fast it sways
var max_sway_angle = deg_to_rad(15)  # +/- 15 degrees

func _ready():
	area.body_entered.connect(_on_body_entered)
	# Start fire particle effect
	if particles:
		particles.emitting = true

func _physics_process(delta):
	# Apply downward velocity
	linear_velocity.y = fall_speed

	# Sway back and forth naturally
	sway_time += delta * sway_speed
	rotation = sin(sway_time) * max_sway_angle

	# Remove if fallen too far below screen
	if global_position.y > get_viewport_rect().size.y + 1000:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("player"):
		AudioManager.play_sound("yarn_hit")
		body.hit_by_flaming_yarn()
		# Create explosion effect
		create_explosion_effect()
		queue_free()

func create_explosion_effect():
	# Create a particle explosion when hitting player
	var explosion = GPUParticles2D.new()
	get_parent().add_child(explosion)
	explosion.global_position = global_position
	explosion.emitting = true
	explosion.one_shot = true

	# Auto-cleanup after particles finish
	await get_tree().create_timer(2.0).timeout
	explosion.queue_free()

func create_small_explosion_effect():
	# Smaller effect for platform hits
	pass
