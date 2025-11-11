extends CanvasLayer

@onready var invincibility_label = $InvincibilityLabel
@onready var height_label = $HeightLabel
@onready var game_over_panel = $GameOverPanel
@onready var game_over_message = $GameOverPanel/VBoxContainer/MessageLabel
@onready var victory_panel = $VictoryPanel
@onready var restart_button = $GameOverPanel/RestartButton
@onready var victory_restart_button = $VictoryPanel/RestartButton

func _ready():
	game_over_panel.hide()
	victory_panel.hide()
	invincibility_label.hide()

	if restart_button:
		restart_button.pressed.connect(_on_restart_pressed)
	if victory_restart_button:
		victory_restart_button.pressed.connect(_on_restart_pressed)

func update_invincibility_timer(time_left: float):
	if time_left > 0:
		invincibility_label.show()
		invincibility_label.text = "INVINCIBLE: %d" % ceil(time_left)
	else:
		invincibility_label.hide()

func update_height(player_y: float, tower_height: float):
	var progress = abs(player_y) / tower_height * 100.0
	progress = clamp(progress, 0, 100)
	height_label.text = "Height: %.0f%%" % progress

func show_invincibility_message():
	# Flash message
	var label = Label.new()
	label.text = "CATNIP POWER!"
	label.add_theme_font_size_override("font_size", 32)
	label.position = Vector2(640, 200)
	label.modulate = Color(1, 1, 0, 1)
	add_child(label)

	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 0.0, 2.0)
	tween.tween_callback(label.queue_free)

func show_game_over(message: String = "Kitty was hit by flaming yarn!"):
	if game_over_message:
		game_over_message.text = message
	game_over_panel.show()

func show_victory():
	victory_panel.show()

func _on_restart_pressed():
	get_tree().reload_current_scene()
