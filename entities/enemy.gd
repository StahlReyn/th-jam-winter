class_name Enemy
extends Entity

# Temporary
@export var score_drop: int = 10000
@export var power_drop: int = 1

func _ready() -> void:
	collision_layer = COL_ENEMY
	collision_mask = COL_MAIN
	super()
	add_to_group("alive_enemy")

func die() -> void:
	super()
	Game.add_score(score_drop)
	Game.add_power(power_drop)
	remove_from_group("alive_enemy")
