class_name PlayerMovement
extends Node

@export var player: Player
@export var speed: int = 400
@export var focus_speed: int = 200
@export var player_sprite: AnimatedSprite2D
@export var focus_sprite: Sprite2D
@export var graze_sprite: Sprite2D

var velocity: Vector2 = Vector2.ZERO

var graze_rotation_speed: float = 1
var focus_anim_speed: float = 20
var focused_scale: Vector2 = Vector2.ONE * 3
var unfocused_scale: Vector2 = Vector2.ONE * 6
var focused_alpha: float = 1
var unfocused_alpha: float = 0

var is_moving: bool = false
var player_bounce_tween: Tween
var bounce_time: float = 0.07

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	rng.seed = 1234
	
	player_bounce_tween = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	player_bounce_tween.tween_property(player_sprite, "position", Vector2(0,-20), bounce_time)
	player_bounce_tween.parallel().tween_property(player_sprite, "rotation", 0.2, bounce_time*2)
	player_bounce_tween.tween_property(player_sprite, "position", Vector2(0,0), bounce_time)
	player_bounce_tween.tween_property(player_sprite, "position", Vector2(0,-20), bounce_time)
	player_bounce_tween.parallel().tween_property(player_sprite, "rotation", -0.2, bounce_time*2)
	player_bounce_tween.tween_property(player_sprite, "position", Vector2(0,0), bounce_time)
	player_bounce_tween.stop()
	
func _physics_process(delta: float) -> void:
	if player.is_dead:
		return
		
	process_movement(delta)
	process_focus(delta)
	if is_moving:
		player_bounce_tween.play()
	else:
		player_bounce_tween.stop()
		var reset_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		reset_tween.tween_property(player_sprite, "position", Vector2(0,0), bounce_time)
		reset_tween.parallel().tween_property(player_sprite, "rotation", 0.0, bounce_time)
		reset_tween.play()

func get_speed() -> int:
	if Input.is_action_pressed("focus"):
		return focus_speed
	return speed

func process_movement(delta: float) -> void:
	var dir: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
		var flip_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		flip_tween.tween_property(player_sprite, "scale", Vector2(1, 1), 0.1)
	if Input.is_action_pressed("ui_left"):
		dir.x += -1
		var flip_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		flip_tween.tween_property(player_sprite, "scale", Vector2(-1, 1), 0.1)
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_up"):
		dir.y += -1
	dir = dir.normalized()
	
	if dir == Vector2.ZERO:
		is_moving = false
	else:
		is_moving = true
		velocity = dir * get_speed()
		player.position += velocity * delta
		player.position = player.position.clamp(-Game.map_halfsize, Game.map_halfsize)
	
	if velocity != Vector2.ZERO:
		Game.set_paint_brush_size(70)
		Game.paint_map(player.position + Vector2(rng.randi_range(-20,20), rng.randi_range(-20,20)))

func process_focus(delta: float) -> void:
	graze_sprite.rotate(graze_rotation_speed * delta)
	if Input.is_action_pressed("focus"):
		focus_sprite.modulate.a = MathUtils.lerp_smooth(focus_sprite.modulate.a, focused_alpha, focus_anim_speed, delta)
		focus_sprite.scale = MathUtils.lerp_smooth(focus_sprite.scale, focused_scale, focus_anim_speed, delta)
		graze_sprite.modulate.a = MathUtils.lerp_smooth(graze_sprite.modulate.a, focused_alpha, focus_anim_speed, delta)
		graze_sprite.scale = MathUtils.lerp_smooth(graze_sprite.scale, focused_scale, focus_anim_speed, delta)
	else:
		focus_sprite.modulate.a = MathUtils.lerp_smooth(focus_sprite.modulate.a, unfocused_alpha, focus_anim_speed, delta)
		focus_sprite.scale = MathUtils.lerp_smooth(focus_sprite.scale, unfocused_scale, focus_anim_speed, delta)
		graze_sprite.modulate.a = MathUtils.lerp_smooth(graze_sprite.modulate.a, unfocused_alpha, focus_anim_speed, delta)
		graze_sprite.scale = MathUtils.lerp_smooth(graze_sprite.scale, unfocused_scale, focus_anim_speed, delta)

func clean_up_focus() -> void:
	var time := 0.2
	var tween := create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(focus_sprite, "modulate", Color(1,1,1,0), time)
	tween.parallel().tween_property(graze_sprite, "modulate", Color(1,1,1,0), time)
	tween.parallel().tween_property(focus_sprite, "scale", unfocused_scale, time)
	tween.parallel().tween_property(graze_sprite, "scale", unfocused_scale, time)

func _on_player_died() -> void:
	player_bounce_tween.stop()
	clean_up_focus()
