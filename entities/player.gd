class_name Player
extends Entity

func _ready() -> void:
	super()
	collision_layer = COL_PLAYER
	collision_mask = 0

func _process(delta: float) -> void:
	pass
