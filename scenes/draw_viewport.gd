extends SubViewport

@onready var brush: Brush = $Brush

var offset: Vector2 = Vector2(2048, 2048)
var scale_offset: float = 4.0

func _process(delta: float) -> void:
	var player: Player = Game.get_player()
	paint((player.position + offset) / scale_offset)

func paint(position: Vector2, color: Color = Color.WHITE):
	brush.queue_brush(position, color)
