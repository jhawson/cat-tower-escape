extends Area2D

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer

func _ready():
	body_entered.connect(_on_body_entered)
	# Floating animation - would play here if we had animations set up
	# if animation_player and animation_player.has_animation("float"):
	#	animation_player.play("float")

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.collect_catnip()
		# Play collection animation - would play here if we had animations set up
		# if animation_player and animation_player.has_animation("collect"):
		#	animation_player.play("collect")
		#	await animation_player.animation_finished
		queue_free()
