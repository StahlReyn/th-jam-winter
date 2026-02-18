extends Area2D

@export var player: Player
@export var snow_size: int = 70
@export var freeze_strength: float = 1.0
@export var object_freeze_ratio: float = 2.0

@onready var main_collision: CollisionShape2D = $CollisionShape2D
@onready var main_sprite: Sprite2D = $Sprite2D

var player_last_pos: Vector2
var circle_col: CircleShape2D

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	rng.seed = 12345
	circle_col = main_collision.shape
	player_last_pos = player.position

func _physics_process(delta: float) -> void:
	# PLACEHOLDER: For now scale snow size with power
	snow_size = 50 + Game.power * 0.1 + Game.coverage_ratio * 50.0
	freeze_strength = 1.0 + Game.power * 0.005 + Game.coverage_ratio * 2.0
	circle_col.radius = snow_size * object_freeze_ratio
	
	main_sprite.scale = Vector2.ONE * (snow_size * object_freeze_ratio / 64)
	main_sprite.rotate(0.4 * delta)
	
	# Draw everytime player move, including pushed around
	if player_last_pos != player.position:
		Game.set_paint_brush_size(snow_size)
		Game.paint_map(player.position + Vector2(rng.randi_range(-20,20), rng.randi_range(-20,20)))
	
	for area: Area2D in get_overlapping_areas():
		if area is Interactable:
			area.progress_freeze(freeze_strength * delta)
	player_last_pos = player.position
	
func _on_area_entered(area: Area2D) -> void:
	if area is Interactable:
		area.show_freeze()

func _on_area_exited(area: Area2D) -> void:
	if area is Interactable:
		area.hide_freeze()

func _on_player_died() -> void:
	collision_layer = 0
