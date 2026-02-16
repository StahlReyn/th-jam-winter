class_name Player
extends Entity

func _ready() -> void:
	collision_layer = COL_PLAYER
	collision_mask = 0
	super()

func take_damage(amount: int) -> void:
	super(amount)
	AudioManager.play_block()

func die() -> void:
	super()
	AudioManager.play_pichuun()
