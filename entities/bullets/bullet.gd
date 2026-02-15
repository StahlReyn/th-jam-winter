class_name Bullet
extends Entity

@export var velocity: Vector2 = Vector2.ZERO
@export var damage: int = 1

@onready var main_sprite: Sprite2D = $Sprite2D

var despawn_size: Vector2 = Game.map_halfsize + Vector2(64,64)

func _ready() -> void:
	collision_layer = COL_BULLET
	collision_mask = COL_PLAYER
	super()
	z_index = 10
	spawn_anim()

func _process(delta: float) -> void:
	position += velocity * delta
	
	if abs(position.x) > despawn_size.x or abs(position.y) > despawn_size.y:
		despawn()

func spawn_anim() -> void:
	var spawn_tween: Tween = create_tween().set_parallel()
	var orig_scale = main_sprite.scale
	var orig_modulate = main_sprite.modulate
	main_sprite.scale *= 2
	main_sprite.modulate.a = 0
	spawn_tween.tween_property(main_sprite, "scale", orig_scale, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	spawn_tween.tween_property(main_sprite, "modulate", orig_modulate, 0.2)

func set_color(color: Color):
	main_sprite.material.set_shader_parameter("blend", color)

func _on_area_entered(area: Area2D) -> void:
	if area is Entity:
		area.take_damage(damage)
		AudioManager.play_hit()
		despawn()
	elif area is GrazeArea:
		Game.graze += 1
		AudioManager.play_graze()
