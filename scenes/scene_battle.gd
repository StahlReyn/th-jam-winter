class_name SceneBattle
extends Node2D

@onready var game_map: GameMap = $GameMap
@onready var stage_handler: StageHandler = $StageHandler

@onready var death_sprite: Node2D = $GameCamera/CenterGradient

var game_over: bool = false
var game_time: float = 0.0

func _ready() -> void:
	Game.reset_game_variables()
	Game.set_player($Player)
	death_sprite.modulate = Color(1,1,1,0)
	stage_handler.test_wave()

func _physics_process(delta: float) -> void:
	if game_over:
		if Input.is_action_just_pressed("shoot"):
			SceneManager.reload_current_scene()
		return
	
	Game.game_time += delta

func spawn_bullet(scene: PackedScene) -> Bullet:
	var bullet: Bullet = scene.instantiate()
	add_child(bullet)
	return bullet

func spawn_enemy(scene: PackedScene) -> Enemy:
	var enemy: Enemy = scene.instantiate()
	add_child(enemy)
	return enemy

func _on_player_died() -> void:
	var tween := create_tween()
	tween.tween_interval(1.0)
	tween.tween_property(death_sprite, "modulate", Color.WHITE, 1.0)
	await tween.finished
	game_over = true

func _on_coverage_timer_timeout() -> void:
	if not game_over:
		Game.update_coverage_ratio()
