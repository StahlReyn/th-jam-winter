class_name BehaviorDeathFall
extends EntityBehavior

@export var main_sprite: AnimatedSprite2D

const GRAYSCALE_MATERIAL: ShaderMaterial = preload("res://shaders/grayscale_material.tres")

func _on_entity_died() -> void:
	main_sprite.material = GRAYSCALE_MATERIAL
	var target_mod: Color = main_sprite.modulate
	target_mod.a = 0
	
	var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(main_sprite, "scale", Vector2(1,1), 0.3)
	tween.tween_property(main_sprite, "scale", Vector2(-1,1), 0.3)
	
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(main_sprite, "position", Vector2(0,-32), 0.2)
	tween.parallel().tween_property(main_sprite, "rotation", PI/2, 0.6)
	tween.tween_property(
		main_sprite, "position", Vector2(0,48), 0.6
	).set_trans(Tween.TRANS_BOUNCE)
