extends Node2D

@export var yarn_scene: PackedScene
@export var spawn_interval_min = 1.5
@export var spawn_interval_max = 3.5
@export var spawn_width = 1200.0

@onready var spawn_timer = $SpawnTimer

var camera_top_y = 0.0
var is_active = true
var game_time = 0.0  # Track elapsed time in seconds

func _ready():
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.start(randf_range(spawn_interval_min, spawn_interval_max))

func _process(delta):
	if is_active:
		game_time += delta

func set_camera_top(y_pos: float):
	camera_top_y = y_pos

func stop_spawning():
	is_active = false
	spawn_timer.stop()

func get_difficulty_multiplier() -> float:
	# Increases by 20% every 15 seconds: 1.25^(time/15)
	# At 0s: 1.0x, at 15s: 1.25x, at 30s: 1.56x, at 45s: 1.95x, at 60s: 2.44x
	return pow(1.20, game_time / 15.0)

func _on_spawn_timer_timeout():
	if not is_active:
		return
	if yarn_scene:
		spawn_yarn()

	# Apply difficulty multiplier to spawn rate (divide interval by multiplier)
	var difficulty = get_difficulty_multiplier()
	var scaled_min = spawn_interval_min / difficulty
	var scaled_max = spawn_interval_max / difficulty

	# Clamp to minimum interval to prevent it from becoming too fast
	scaled_min = max(scaled_min, 0.3)
	scaled_max = max(scaled_max, 0.5)

	spawn_timer.start(randf_range(scaled_min, scaled_max))

func spawn_yarn():
	var yarn = yarn_scene.instantiate()
	get_parent().add_child(yarn)

	# Spawn at random X position above the camera view
	var spawn_x = randf_range(-spawn_width / 2, spawn_width / 2)
	var spawn_y = camera_top_y - 100  # Above visible area

	yarn.global_position = Vector2(spawn_x, spawn_y)

	# Play spawn sound
	AudioManager.play_sound("yarn_spawn")
