class_name BehaviorDandelion
extends EntityBehavior

@export var start_cooldown: float = 4.0
@export var cooldown: float = 9.0

@export var main_sprite: AnimatedSprite2D
@export var behavior_move: BehaviorMove

const BULLET_SCENE: PackedScene = preload("res://entities/bullets/bullet_dot.tscn")

var timer: Timer

func _ready() -> void:
	add_to_group("stop_on_win")
	timer = Timer.new()
	timer.timeout.connect(shoot_main)
	add_child(timer)
	timer.start(start_cooldown)
	
	entity.died.connect(disable)

func disable() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	
func shoot_main() -> void:
	var prev_process = behavior_move.process_mode
	behavior_move.process_mode = Node.PROCESS_MODE_DISABLED
	
	var prev_scale = main_sprite.scale
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(main_sprite, "scale", prev_scale * Vector2(1.2, 0.8), 0.5)
	tween.parallel().tween_property(main_sprite, "modulate", Color.WHITE * 2, 0.5)
	await tween.finished
	
	tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(main_sprite, "scale", prev_scale, 0.5).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(main_sprite, "modulate", Color.WHITE, 0.5).set_trans(Tween.TRANS_QUAD)
	
	shoot_spiral(8, TAU/17, 0.05)
	await shoot_spiral(8, -TAU/17, 0.05)
	
	behavior_move.process_mode = prev_process
	if not is_inside_tree() or Game.is_game_won:
		return
	timer.start(cooldown)
	
func shoot_spiral(amount: float, rotation: float, interval: float) -> void:
	var p_circle := PatternCircle.new()
	p_circle.bullet_scene = BULLET_SCENE
	p_circle.bullet_color = Color.RED
	p_circle.amount = 3
	p_circle.speed = -100
	p_circle.acceleration = 200

	for i in range(amount):
		AudioManager.play_shoot_soft()
		p_circle.position = entity.global_position
		p_circle.create()
		p_circle.rotation += rotation
		await create_tween().tween_interval(interval).finished
