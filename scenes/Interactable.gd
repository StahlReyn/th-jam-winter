class_name Interactable
extends Entity

signal froze

@export_category("Gameplay")
@export var freeze_max: float = 5.0
@export var freeze_recover: float = 0.1
@export var power_amount: int = 25
@export var heal_amount: int = 10
@export var max_health_amount: int = 5
@export var score_drop: int = 20000
@export_category("Visuals")
@export var main_sprite: Sprite2D
@export var freeze_bar: TextureProgressBar
@export var init_sprite_x: int = 0 ## PLACEHOLDER TREE VARIANT

var freeze_value: float = 0.0
var is_frozen: bool = false

var shake_tween: Tween
var i_show_tween: Tween

func _ready() -> void:
	add_to_group("interactable")
	collision_layer = COL_INTERACTABLE
	collision_mask = COL_MAIN
	super()
	
	main_sprite.frame_coords.x = init_sprite_x
	shake_tween = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	shake_tween.tween_property(main_sprite, "position", Vector2(3, 0), 0.08)
	shake_tween.tween_property(main_sprite, "position", Vector2(-3, 0), 0.08)
	shake_tween.stop()
	
func _physics_process(delta: float) -> void:
	super(delta)
	freeze_bar.min_value = 0
	freeze_bar.max_value = freeze_max
	freeze_bar.value = freeze_value
	
	if not is_frozen:
		freeze_value -= freeze_recover * delta
	freeze_value = clamp(freeze_value, 0, freeze_max)

func progress_freeze(amount: float) -> void:
	freeze_value += amount
	if not is_frozen and freeze_value >= freeze_max:
		turn_frozen()

func turn_frozen():
	add_to_group("frozen_interactable")
	is_frozen = true
	froze.emit()
	# TEMPORARY METHOD
	main_sprite.frame_coords.y = 2
	
	var player := Game.get_player()
	player.mhp += max_health_amount
	player.heal(heal_amount)
	Game.add_power(power_amount)
	Game.add_score(score_drop)
	
	if shake_tween.is_running():
		shake_tween.stop()
	if i_show_tween and i_show_tween.is_running():
		i_show_tween.stop()
	i_show_tween = create_tween()
	i_show_tween.tween_property(freeze_bar, "modulate", Color(1,1,1,0), 0.1)
	
func show_freeze():
	if is_frozen:
		return
	shake_tween.play()
	if i_show_tween and i_show_tween.is_running():
		i_show_tween.stop()
	i_show_tween = create_tween()
	i_show_tween.tween_property(freeze_bar, "modulate", Color(1,1,1,1), 0.1)

func hide_freeze():
	if is_frozen:
		return
	if shake_tween.is_running():
		shake_tween.stop()
		var tween := create_tween()
		tween.tween_property(main_sprite, "position", Vector2(0, 0), 0.1)
	if i_show_tween and i_show_tween.is_running():
		i_show_tween.stop()
	i_show_tween = create_tween()
	i_show_tween.tween_property(freeze_bar, "modulate", Color(1,1,1,0.5), 0.1)
