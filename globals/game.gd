extends Node

var player: Player
var graze: int = 0

const map_size: Vector2 = Vector2(4096, 4096)
const map_halfsize: Vector2 = map_size / 2

func _ready() -> void:
	pass

func set_player(player: Player) -> void:
	self.player = player
	
func get_player() -> Player:
	return player

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
func get_coverage_ratio() -> float:
	var scene: SceneBattle = get_tree().current_scene
	return scene.game_map.get_coverage_ratio()

func get_game_map() -> GameMap:
	var scene: SceneBattle = get_tree().current_scene
	return scene.game_map

func paint_map(position: Vector2) -> void:
	var scene: SceneBattle = get_tree().current_scene
	scene.game_map.paint_global(position)

func set_paint_brush_size(brush_size: int) -> void:
	var scene: SceneBattle = get_tree().current_scene
	scene.game_map.set_brush_size(brush_size)
