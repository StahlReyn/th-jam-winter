class_name Enemy
extends Entity

func _ready() -> void:
	collision_layer = COL_ENEMY
	collision_mask = 0

func _process(delta: float) -> void:
	pass
