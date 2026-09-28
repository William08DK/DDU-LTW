extends Area2D

signal set_wind(value: bool)

var in_wind = 0

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is TileMapLayer:
		in_wind += 1
		emit_signal("set_wind", true)


func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is TileMapLayer:
		in_wind -= 1
		if not in_wind: emit_signal("set_wind", false)
