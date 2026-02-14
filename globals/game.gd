extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_player() -> Player:
	return get_tree().get_nodes_in_group("player")[0]

func get_coverage_ratio() -> float:
	var scene_battle: SceneBattle = get_tree().current_scene
	return scene_battle.game_map.get_coverage_ratio()
