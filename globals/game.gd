extends Node

var player: Player
var score: int = 0
var power: int = 0
var graze: int = 0
var game_time: float = 0.0
var coverage_ratio: float = 0.0

var is_game_won: bool = false

var max_power: int = 400
const map_size: Vector2 = Vector2(4096, 4096)
const map_halfsize: Vector2 = map_size / 2

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 

@warning_ignore("shadowed_variable")
func set_player(player: Player) -> void:
	self.player = player
	
func get_player() -> Player:
	return player

func reset_game_variables() -> void:
	is_game_won = false
	score = 0
	power = 0
	graze = 0
	game_time = 0.0
	coverage_ratio = 0.0

func add_score(amount: int) -> void:
	score += amount

func add_power(amount: int) -> void:
	power += amount
	power = clamp(power, 0, max_power)

func get_alive_enemy_count() -> int:
	return get_tree().get_node_count_in_group("alive_enemy")

func get_interactable_count() -> int:
	return get_tree().get_node_count_in_group("interactable")

func get_frozen_interactable_count() -> int:
	return get_tree().get_node_count_in_group("frozen_interactable")

# Spawning
func spawn_bullet_enemy(bullet_scene: PackedScene, color: Color = Color.WHITE) -> Bullet:
	var scene: SceneBattle = get_tree().current_scene
	var bullet: Bullet = scene.spawn_bullet(bullet_scene)
	bullet.set_color(color)
	bullet.collision_mask = Entity.COL_PLAYER
	return bullet

func spawn_bullet_player(bullet_scene: PackedScene, color: Color = Color.WHITE) -> Bullet:
	var scene: SceneBattle = get_tree().current_scene
	var bullet: Bullet = scene.spawn_bullet(bullet_scene)
	bullet.set_color(color)
	bullet.collision_mask = Entity.COL_ENEMY
	return bullet

# Paints
func update_coverage_ratio() -> void:
	var scene: SceneBattle = get_tree().current_scene
	coverage_ratio = scene.game_map.get_coverage_ratio()

func get_game_map() -> GameMap:
	var scene: SceneBattle = get_tree().current_scene
	return scene.game_map

func paint_map(position: Vector2) -> void:
	var scene: SceneBattle = get_tree().current_scene
	scene.game_map.paint_global(position)

func set_paint_brush_size(brush_size: int) -> void:
	var scene: SceneBattle = get_tree().current_scene
	scene.game_map.set_brush_size(brush_size)
