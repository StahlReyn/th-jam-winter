extends SubViewport

@onready var brush: Brush = $Brush

func paint(position: Vector2, color: Color = Color.WHITE):
	brush.queue_brush(position, color)

func set_brush_size(brush_size: int) -> void:
	brush.brush_size = brush_size
