class_name ShadowSprite
extends Sprite2D

@export var main_sprite: Node2D
@export var base_width: float = 1.0
@export var mult_width: float = 0.015

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	scale.x = max(base_width + main_sprite.position.y * mult_width, 0)
