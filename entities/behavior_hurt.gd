class_name BehaviorHurt
extends EntityBehavior

@export var main_sprite: AnimatedSprite2D
@export var rotate_time: float = 0.1
@export var rotate_amount: float = 0.3

func _on_entity_took_damage(amount: int) -> void:
	var hurt_tween: Tween = create_tween()
	main_sprite.modulate = Color.PALE_VIOLET_RED
	hurt_tween.tween_property(main_sprite, "rotation", rotate_amount, rotate_time * 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	hurt_tween.parallel().tween_property(main_sprite, "modulate", Color.WHITE, rotate_time)
	hurt_tween.tween_property(main_sprite, "rotation", 0.0, rotate_time).set_trans(Tween.TRANS_SINE)
