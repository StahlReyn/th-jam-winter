class_name BehaviorFloat
extends EntityBehavior

@export var main_sprite: AnimatedSprite2D

var float_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_loops()

func _on_enemy_died() -> void:
	float_tween.kill()

func _on_enemy_spawned() -> void:
	float_tween.tween_property(main_sprite, "position", Vector2(0, -8), 1.0)
	float_tween.tween_property(main_sprite, "position", Vector2(0, 8), 1.0)
	float_tween.play()
