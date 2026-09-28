extends Area2D

signal set_wind(value: float, rotation: float)

var in_wind = 0

func _on_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		in_wind += 1
		emit_signal("set_wind", body.get_meta("strength"), body.get_meta("rotation", 0))

func _on_body_exited(body: Node2D) -> void:
	if body is StaticBody2D:
		in_wind -= 1
		if not in_wind: emit_signal("set_wind", 1, 0)
