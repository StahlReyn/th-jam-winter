class_name BehaviorRose
extends EntityBehavior

@export var start_cooldown: float = 4.0
@export var cooldown: float = 6.0

@export var main_sprite: AnimatedSprite2D
@export var behavior_move: BehaviorMove

const BULLET_SCENE: PackedScene = preload("res://entities/bullets/bullet_arrow.tscn")

var timer_cooldown: Timer
var timer_check: Timer

var can_dash: bool = false

func _ready() -> void:
	add_to_group("stop_on_win")
	timer_cooldown = Timer.new()
	timer_cooldown.timeout.connect(cooldown_finish)
	add_child(timer_cooldown)
	timer_cooldown.start(start_cooldown)
	
	timer_check = Timer.new()
	timer_check.timeout.connect(check_dash)
	timer_check.wait_time = 0.2
	add_child(timer_check)
	timer_check.start()
	
	entity.died.connect(disable)

func disable() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func check_dash() -> void:
	if not is_inside_tree() or Game.is_game_won:
		return
	var player := Game.get_player()
	var dist_sq: float = entity.position.distance_squared_to(player.position)
	if dist_sq < 500**2 and can_dash:
		dash()
	
func cooldown_finish() -> void:
	can_dash = true

func dash() -> void:
	can_dash = false
	timer_cooldown.stop()
	var prev_process = behavior_move.process_mode
	behavior_move.process_mode = Node.PROCESS_MODE_DISABLED
	
	var squish_scale: Vector2 = Vector2(1.25, 0.75)
	if main_sprite.scale.x < 1:
		squish_scale.x *= -1
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_interval(0.2)
	tween.tween_property(main_sprite, "scale", squish_scale, 0.75)
	tween.parallel().tween_property(main_sprite, "modulate", Color.WHITE * 2, 0.5)
	await tween.finished
	
	var player := Game.get_player()
	var target_pos = entity.global_position
	target_pos += (player.global_position - entity.global_position) * 1.5
	
	tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(entity, "global_position", target_pos, 1.0).set_trans(Tween.TRANS_QUAD)
	tween.parallel().tween_property(main_sprite, "scale", Vector2.ONE, 0.5).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel().tween_property(main_sprite, "modulate", Color.WHITE, 0.5).set_trans(Tween.TRANS_QUAD)	
	
	shoot_set(6, 0.1)
	
	await tween.finished
	behavior_move.process_mode = prev_process
	timer_cooldown.start(cooldown)

func shoot_set(amount: float, interval: float) -> void:
	var player := Game.get_player()
	var pat := PatternFlower.new()
	pat.bullet_scene = BULLET_SCENE
	pat.bullet_color = Color.RED
	pat.petal_count = 1
	pat.petal_size = 4
	pat.arc_angle = PI/5
	pat.speed_min = 700
	pat.speed_max = 1400
	pat.rotation = entity.global_position.angle_to_point(player.global_position)

	for i in range(amount):
		AudioManager.play_shoot1()
		pat.position = entity.global_position
		pat.create()
		await create_tween().tween_interval(interval).finished
