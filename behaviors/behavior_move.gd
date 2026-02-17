class_name BehaviorMove
extends EntityBehavior

enum State {
	FOLLOW,
	IDLE,
	AVOID
}

@export var main_sprite: AnimatedSprite2D
@export var move_speed: float = 200
@export var stop_distance: float = 0.0
@export var avoid_distance: float = 0.0 ## Avoid should be smaller than stop
@export var avoid_speed: float = 200

@export var state_check_interval: float = 0.1

var flip_tween: Tween
var is_flipped: bool = false

var state_check_timer: Timer
var cur_state = State.FOLLOW

func _ready() -> void:
	state_check_timer = Timer.new()
	state_check_timer.wait_time = state_check_interval
	state_check_timer.autostart = true
	state_check_timer.timeout.connect(update_state)

func _physics_process(delta: float) -> void:
	if not entity.is_active:
		if flip_tween:
			flip_tween.stop()
		return
	
	var final_speed: float = move_speed
	var player: Player = Game.get_player()
	var dir: Vector2 = entity.position.direction_to(player.position)
	if cur_state == State.AVOID:
		final_speed = -avoid_speed
	elif cur_state == State.IDLE:
		final_speed = 0.0
	entity.position += dir * final_speed * delta
	
	main_sprite.play("default")
	if dir.x > 0 and is_flipped: # right but was left
		if flip_tween: flip_tween.stop()
		flip_tween = create_tween()
		flip_tween.tween_property(main_sprite, "scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_SINE)
		is_flipped = false
	if dir.x < 0 and not is_flipped: # left but was right
		if flip_tween: flip_tween.stop()
		flip_tween = create_tween()
		flip_tween.tween_property(main_sprite, "scale", Vector2(-1,1), 0.2).set_trans(Tween.TRANS_SINE)
		is_flipped = true

func update_state() -> void:
	if avoid_distance > 0.0 or stop_distance > 0.0: # Only calculate when it actually needs to
		var player: Player = Game.get_player()
		var dist_sq: float = entity.position.distance_squared_to(player.position)
		if dist_sq < avoid_distance ** 2:
			cur_state = State.AVOID
		elif dist_sq < stop_distance ** 2:
			cur_state = State.IDLE
		else:
			cur_state = State.FOLLOW
