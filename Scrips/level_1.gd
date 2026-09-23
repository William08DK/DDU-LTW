extends Node2D

signal level_finished


func _on_win_zone_body_entered(body: Node2D) -> void:
	print(body)
	if body is CharacterBody2D: emit_signal("level_finished")
