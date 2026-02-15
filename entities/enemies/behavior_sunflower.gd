class_name BehaviorSunflower
extends EntityBehavior

@export var start_cooldown: float = 3.0
@export var cooldown: float = 8.0

@export var main_sprite: AnimatedSprite2D
@export var behavior_move: BehaviorMove

const BULLET_SCENE: PackedScene = preload("res://entities/bullets/bullet_oval.tscn")

var timer: Timer

func _ready() -> void:
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
	tween.tween_property(main_sprite, "scale", prev_scale * Vector2(1.2, 0.8), 1.0)
	tween.parallel().tween_property(main_sprite, "modulate", Color.WHITE * 2, 1.0)
	await tween.finished
	
	tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(main_sprite, "scale", prev_scale, 0.5).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(main_sprite, "modulate", Color.WHITE, 0.5).set_trans(Tween.TRANS_QUAD)
	
	shoot_spiral(16, TAU/64, 0.05)
	await shoot_spiral(16, -TAU/64, 0.05)
	
	behavior_move.process_mode = prev_process
	timer.start(cooldown)
	
func shoot_spiral(amount: float, rotation: float, interval: float) -> void:
	var p_circle := PatternCircle.new()
	p_circle.bullet_scene = BULLET_SCENE
	p_circle.bullet_color = Color.YELLOW
	p_circle.amount = 6
	p_circle.speed = -300
	p_circle.acceleration = 300

	for i in range(amount):
		if entity.is_dead:
			return
		p_circle.position = entity.global_position
		p_circle.create()
		await get_tree().create_timer(interval, false, true).timeout
		p_circle.rotation += rotation
