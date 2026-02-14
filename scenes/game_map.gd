class_name GameMap
extends Node2D

@onready var draw_viewport: SubViewport = $DrawViewport
var paint_texture: ViewportTexture
var step_size: int = 4 # Performance reason to skip some pixels

var offset: Vector2 = Vector2(2048, 2048)
var scale_offset: float = 4.0

func _ready() -> void:
	paint_texture = draw_viewport.get_texture()
	
func paint_global(position: Vector2, color: Color = Color.WHITE):
	draw_viewport.paint((position + offset) / scale_offset, color)

func set_brush_size(brush_size: int) -> void:
	draw_viewport.set_brush_size(brush_size)

func get_coverage_ratio() -> float:
	var pixel_count: int = 0
	var image := paint_texture.get_image()
	var size := image.get_size()
	var total_pixel_count: int = (size.x / step_size) * (size.y / step_size)
	
	for y in range(step_size/2, size.y, step_size):
		for x in range(step_size/2, size.x, step_size):
			var pixel = image.get_pixel(x, y)
			if pixel.b > 0.1:
				pixel_count += 1
	
	return float(pixel_count) / float(total_pixel_count)
