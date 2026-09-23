extends Node

var level_2 = preload("res://Scene/level_2.tscn")


func _on_level_1_level_finished() -> void:
	$Level1.queue_free()
	add_child(level_2.instantiate())
