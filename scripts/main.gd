extends Node2D

@onready var player = $Player
@onready var camera = $Camera2D
@onready var yarn_spawner = $YarnSpawner
@onready var ui = $UI
@onready var victory_zone = $VictoryZone

const TOWER_HEIGHT = 7200  # 10 screen heights (720 * 10)
const CAMERA_DEADZONE_HEIGHT = 180  # 25% of screen height (720 * 0.25)
const CAMERA_SMOOTH_SPEED = 5.0  # How fast camera catches up
const DEATH_ZONE_Y = 200  # Kitty dies if she falls below y=200 (below starting platform)

var game_over = false
var victory = false
var target_camera_y = 0.0

func _ready():
	# Connect player signals
	player.hit_by_yarn.connect(_on_player_hit)
	player.catnip_collected.connect(_on_catnip_collected)

	# Connect victory zone
	victory_zone.body_entered.connect(_on_victory_zone_entered)

	# Start background music
	AudioManager.play_music("main_theme")

	# Position victory zone at top
	victory_zone.global_position.y = -TOWER_HEIGHT

	# Initialize camera position to player
	camera.global_position = player.global_position
	target_camera_y = player.global_position.y

func _process(delta):
	if game_over or victory:
		return

	# Check if player fell off the tower
	var player_y = player.global_position.y
	if player_y > DEATH_ZONE_Y:
		_on_player_fell()
		return

	# Camera follows player with deadzone and smooth scrolling
	var camera_y = camera.global_position.y
	var distance_from_camera = player_y - camera_y

	# Only move camera if player leaves the middle 50% of screen (deadzone)
	if abs(distance_from_camera) > CAMERA_DEADZONE_HEIGHT:
		# Determine target position (edge of deadzone)
		if distance_from_camera > 0:
			# Player below camera center
			target_camera_y = player_y - CAMERA_DEADZONE_HEIGHT
		else:
			# Player above camera center
			target_camera_y = player_y + CAMERA_DEADZONE_HEIGHT

		# Smoothly interpolate camera to target position
		camera.global_position.y = lerp(camera_y, target_camera_y, CAMERA_SMOOTH_SPEED * delta)

	# Keep camera horizontally centered
	camera.global_position.x = 0

	# Update yarn spawner with camera position
	if yarn_spawner:
		yarn_spawner.set_camera_top(camera.global_position.y - get_viewport_rect().size.y / 2)

	# Update UI
	if ui:
		ui.update_invincibility_timer(player.get_invincibility_time_remaining())
		ui.update_height(player.global_position.y, TOWER_HEIGHT)

func _on_player_hit():
	if not game_over:
		game_over = true
		AudioManager.stop_music()
		AudioManager.play_music("game_over_theme")
		if ui:
			ui.show_game_over()

func _on_player_fell():
	if not game_over:
		game_over = true
		AudioManager.stop_music()
		AudioManager.play_music("game_over_theme")
		if ui:
			ui.show_game_over("Kitty fell off the tower!")

func _on_catnip_collected():
	if ui:
		ui.show_invincibility_message()

func _on_victory_zone_entered(body):
	if body.is_in_group("player") and not victory:
		victory = true
		AudioManager.stop_music()
		AudioManager.play_music("victory_theme")
		if yarn_spawner:
			yarn_spawner.stop_spawning()
		# Freeze player and start fade out
		player.victory()
		if ui:
			ui.show_victory()

func restart_game():
	get_tree().reload_current_scene()
