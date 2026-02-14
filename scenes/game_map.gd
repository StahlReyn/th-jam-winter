class_name GameMap
extends Node2D

@onready var draw_viewport: SubViewport = $DrawViewport
var paint_texture: ViewportTexture
var step_size: int = 4 # Performance reason to skip some pixels

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	paint_texture = draw_viewport.get_texture()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_coverage_ratio() -> float:
	var pixel_count: int = 0
	var image := paint_texture.get_image()
	var size := image.get_size()
	var total_pixel_count: int = (size.x / step_size) * (size.y / step_size)
	
	for y in range(0, size.y, step_size):
		for x in range(0, size.x, step_size):
			var pixel = image.get_pixel(x, y)
			if pixel.b > 0.1:
				pixel_count += 1
	
	return float(pixel_count) / float(total_pixel_count)
