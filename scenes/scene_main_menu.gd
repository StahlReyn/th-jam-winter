class_name SceneMainMenu
extends Node2D

@onready var start_node: Node2D = $Start

var starting_game: bool = false

func _ready() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_loops()
	tween.tween_property(start_node, "modulate", Color(1,1,1,0.5), 1)
	tween.tween_property(start_node, "modulate", Color(1,1,1,1), 1)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and not starting_game:
		start_game()

func start_game() -> void:
	starting_game = true
	SceneManager.goto_scene(SceneManager.SCENE_BATTLE)
