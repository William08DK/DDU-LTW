extends Area2D

signal game_finished


func _on_body_entered(body: Node2D) -> void:
	emit_signal("game_finished")
