extends Node2D

# Helper script to place catnip bundles throughout the tower
# This would be attached to the Collectibles node

@export var catnip_scene: PackedScene
@export var catnip_positions = [
	Vector2(-300, -900),
	Vector2(350, -2000),
	Vector2(-250, -3200),
	Vector2(280, -4400),
	Vector2(-180, -5600),
	Vector2(200, -6700)
]

func _ready():
	if catnip_scene:
		for pos in catnip_positions:
			var catnip = catnip_scene.instantiate()
			add_child(catnip)
			catnip.global_position = pos
