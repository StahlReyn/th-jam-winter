class_name BehaviorMove
extends EntityBehavior

@export var main_sprite: AnimatedSprite2D
@export var move_speed: float = 100

var flip_tween: Tween = create_tween()
var is_flipped: bool = false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if not entity.is_active:
		flip_tween.stop()
		return
		
	var player: Player = Game.get_player()
	var dir: Vector2 = entity.position.direction_to(player.position)
	entity.position += dir * move_speed * delta
	
	main_sprite.play("default")
	if dir.x > 0 and is_flipped: # right but was left
		flip_tween.stop()
		flip_tween = create_tween()
		flip_tween.tween_property(main_sprite, "scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_SINE)
		flip_tween.play()
		is_flipped = false
	if dir.x < 0 and not is_flipped: # left but was right
		flip_tween.stop()
		flip_tween = create_tween()
		flip_tween.tween_property(main_sprite, "scale", Vector2(-1,1), 0.2).set_trans(Tween.TRANS_SINE)
		flip_tween.play()
		is_flipped = true
