class_name Bullet
extends Entity

@export var velocity: Vector2 = Vector2.ZERO
@export var damage: int = 1

func _ready() -> void:
	collision_layer = COL_BULLET
	collision_mask = COL_PLAYER

func _process(delta: float) -> void:
	position += velocity * delta

func despawn() -> void:
	call_deferred("queue_free")

func _on_area_entered(area: Area2D) -> void:
	if area is Entity:
		area.take_damage(damage)
		despawn()
