class_name BehaviorDeath
extends EnemyBehavior

@export var main_sprite: AnimatedSprite2D

static var grayscale_shader: Shader = preload("res://shaders/grayscale.gdshader")
static var grayscale_material: ShaderMaterial = ShaderMaterial.new()

func _init() -> void:
	grayscale_material.shader = grayscale_shader

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_enemy_died() -> void:
	main_sprite.material = grayscale_material
	var flip_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	flip_tween.tween_property(main_sprite, "scale", Vector2(1,1), 0.3)
	flip_tween.tween_property(main_sprite, "scale", Vector2(-1,1), 0.3)
	
	var target_pos: Vector2 = main_sprite.position
	target_pos.y -= 1500
	var target_mod: Color = main_sprite.modulate
	target_mod.a = 0
	flip_tween.tween_property(main_sprite, "position", target_pos, 1.4)
	flip_tween.parallel().tween_property(main_sprite, "modulate", target_mod, 1.4)
	flip_tween.tween_callback(enemy.despawn)
