class_name Player
extends Entity

var aim_angle: float

func _ready() -> void:
	collision_layer = COL_PLAYER
	collision_mask = COL_MAIN
	super()

func _physics_process(delta: float) -> void:
	super(delta)
	position = position.clamp(-Game.map_halfsize, Game.map_halfsize)
	
func take_damage(amount: int) -> void:
	super(amount)
	AudioManager.play_block()
	
func die() -> void:
	super()
	AudioManager.play_pichuun()
