extends Node

var player: Player

var map_size: Vector2 = Vector2(4096, 4096)
var map_halfsize: Vector2 = map_size / 2

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func set_player(player: Player) -> void:
	self.player = player
	
func get_player() -> Player:
	return player

func get_coverage_ratio() -> float:
	var scene_battle: SceneBattle = get_tree().current_scene
	return scene_battle.game_map.get_coverage_ratio()

func get_game_map() -> GameMap:
	var scene_battle: SceneBattle = get_tree().current_scene
	return scene_battle.game_map

func paint_map(position: Vector2) -> void:
	var scene_battle: SceneBattle = get_tree().current_scene
	scene_battle.game_map.paint_global(position)

func set_paint_brush_size(brush_size: int) -> void:
	var scene_battle: SceneBattle = get_tree().current_scene
	scene_battle.game_map.set_brush_size(brush_size)
