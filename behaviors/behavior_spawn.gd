class_name BehaviorSpawn
extends EntityBehavior

@export var main_sprite: AnimatedSprite2D

func _on_entity_spawn() -> void:
	entity.is_active = false
	var target_pos: Vector2 = main_sprite.position
	main_sprite.position.y -= 1000
	var target_mod: Color = main_sprite.modulate
	main_sprite.modulate = Color(3, 3, 3, 0)
	
	var flip_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	flip_tween.tween_property(main_sprite, "position", target_pos, 1.0)
	flip_tween.parallel().tween_property(main_sprite, "modulate", target_mod, 1.0)
	
	flip_tween.tween_property(main_sprite, "scale", Vector2(-1,1), 0.2)
	flip_tween.tween_property(main_sprite, "scale", Vector2(1,1), 0.2)
	flip_tween.tween_property(entity, "is_active", true, 0.0)
	flip_tween.play()
