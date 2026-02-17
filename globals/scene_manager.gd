extends Node

var current_scene = null
var is_scene_loading = false

const SCENE_BATTLE = "res://scenes/scene_battle.tscn"
const SCENE_MAIN_MENU = "res://scenes/scene_main_menu.tscn"
const SCENE_ENDING = "res://scenes/scene_ending.tscn"
const SCENE_ENDING_STATS = "res://scenes/scene_ending_stats.tscn"

func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	prints("Current Scene:", current_scene)

func goto_scene(path: String) -> void:
	# Deferred to ensure scene is not deleted while code is running
	await trans_out()
	get_tree().paused = true
	is_scene_loading = true
	_deferred_goto_scene.call_deferred(path)

func reload_current_scene():
	await trans_out()
	get_tree().paused = true
	is_scene_loading = true
	_deferred_reload_current_scene.call_deferred()

func _deferred_reload_current_scene() -> void:
	prints("Reload Scene Before:", current_scene, get_tree().current_scene)
	get_tree().reload_current_scene()
	_deferred_reload_set_scene.call_deferred()
	prints("Reload Scene After:", current_scene, get_tree().current_scene)

func _deferred_reload_set_scene() -> void:
	current_scene = get_tree().current_scene
	prints("Reload Scene AFTER After:", current_scene, get_tree().current_scene)
	get_tree().paused = false
	is_scene_loading = false
	trans_in()

func _deferred_goto_scene(path: String) -> void:
	prints("Goto Scene Before:", current_scene, get_tree().current_scene)
	current_scene.free() 	# It is now safe to remove the current scene.
	var s = ResourceLoader.load(path) # Load the new scene.
	current_scene = s.instantiate() # Instance the new scene.
	get_tree().root.add_child(current_scene) # Add it to the active scene, as child of root.
	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	prints("Goto Scene After:", current_scene, get_tree().current_scene)
	get_tree().paused = false
	is_scene_loading = false
	trans_in()
	
func trans_out() -> void:
	var scene: Node = get_tree().current_scene
	if scene is CanvasItem:
		var tween := create_tween()
		tween.tween_property(scene, "modulate", Color.BLACK, 0.2)
		await tween.finished

func trans_in() -> void:
	var scene: Node = get_tree().current_scene
	if scene is CanvasItem:
		scene.modulate = Color.BLACK
		var tween := create_tween()
		tween.tween_property(scene, "modulate", Color.WHITE, 0.2)
		await tween.finished
