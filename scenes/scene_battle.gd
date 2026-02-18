class_name SceneBattle
extends Node2D

signal game_won

@onready var game_map: GameMap = $GameMap
@onready var stage_handler: StageHandler = $StageHandler

@onready var player: Player = $Player
@onready var lose_popup: Node2D = $GameCamera/LosePopup
@onready var win_popup: Node2D = $GameCamera/WinPopup
@onready var stats_label: Label = $GameCamera/WinPopup/Stats

@onready var audio_win: AudioStreamPlayer = $WinSound

var game_over: bool = false
var game_win: bool = false
var game_time: float = 0.0
var can_restart: bool = false

func _ready() -> void:
	Game.reset_game_variables()
	Game.set_player(player)
	lose_popup.modulate = Color(1,1,1,0)
	win_popup.modulate = Color(1,1,1,0)
	stage_handler.test_wave()

func _physics_process(delta: float) -> void:
	if can_restart and Input.is_action_just_pressed("bomb"):
		SceneManager.reload_current_scene()
		return
	
	# Slight leniency, isnt seen in rounding
	if Game.coverage_ratio >= 0.99996 and not game_win:
		win_game()
	
	if not (game_over or game_win):
		Game.game_time += delta

func spawn_bullet(scene: PackedScene) -> Bullet:
	var bullet: Bullet = scene.instantiate()
	add_child(bullet)
	return bullet

func spawn_enemy(scene: PackedScene) -> Enemy:
	var enemy: Enemy = scene.instantiate()
	add_child(enemy)
	return enemy

func win_game() -> void:
	game_win = true
	Game.is_game_won = true
	game_won.emit()
	
	audio_win.play()
	
	var init_score: int = Game.score
	var bonus_score: int = 1000000 * max(1 - Game.game_time / 600, 0) 
	var final_score: int = init_score + bonus_score
	stats_label.text = (
		"  Game Score: " + str(init_score) + 
		"\n+ Time Bonus: " + str(bonus_score) + 
		"\nFinal Score: " + str(final_score)
	)
	
	var tween := create_tween()
	tween.tween_property(win_popup, "modulate", Color.WHITE, 1.0)
	tween.tween_interval(1.0)
	await tween.finished
	can_restart = true
	
func _on_player_died() -> void:
	game_over = true
	var tween := create_tween()
	tween.tween_interval(1.0)
	tween.tween_property(lose_popup, "modulate", Color.WHITE, 1.0)
	await tween.finished
	can_restart = true

func _on_coverage_timer_timeout() -> void:
	if not game_over:
		Game.update_coverage_ratio()
