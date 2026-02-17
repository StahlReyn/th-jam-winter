extends Area2D

@export var player: Player
@export var snow_size: int = 70
@export var freeze_strength: float = 1.0
@export var object_freeze_ratio: float = 2.0

@onready var main_collision: CollisionShape2D = $CollisionShape2D

var circle_col: CircleShape2D

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	rng.seed = 12345
	
	circle_col = main_collision.shape

func _physics_process(delta: float) -> void:
	circle_col.radius = snow_size * object_freeze_ratio
	
	if player.velocity != Vector2.ZERO:
		Game.set_paint_brush_size(snow_size)
		Game.paint_map(player.position + Vector2(rng.randi_range(-20,20), rng.randi_range(-20,20)))
	
	for area: Area2D in get_overlapping_areas():
		if area is Interactable:
			area.progress_freeze(freeze_strength * delta)


func _on_area_entered(area: Area2D) -> void:
	if area is Interactable:
		area.show_freeze()

func _on_area_exited(area: Area2D) -> void:
	if area is Interactable:
		area.hide_freeze()
