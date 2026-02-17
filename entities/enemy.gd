class_name Enemy
extends Entity

func _ready() -> void:
	collision_layer = COL_ENEMY
	collision_mask = COL_MAIN
	super()
	add_to_group("alive_enemy")

func die() -> void:
	super()
	remove_from_group("alive_enemy")
