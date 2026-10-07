extends Node

var level_2 = preload("res://Scene/level_2.tscn")
var current_scene
var current_level = preload("res://Scene/level_1.tscn")

var coins = 0

func _ready() -> void:
	var scene = current_level.instantiate()
	scene.connect("level_finished", _on_level_1_level_finished)
	add_child(scene)
	current_scene = scene

func reset():
	current_scene.queue_free()
	var scene = current_level.instantiate()
	scene.connect("level_finished", _on_level_1_level_finished)
	add_child(scene)
	current_scene = scene
	PlayerInfo.health = PlayerInfo.MAX_HEATH

func _on_level_1_level_finished() -> void:
	var next_level = level_2.instantiate()
	next_level.connect("global_finished", _game_over)
	add_child(next_level)
	current_level = level_2
	current_scene.queue_free()
	current_scene = next_level

func _game_over():
	current_scene.queue_free()
	add_child(load("res://Scene/game_over.tscn").instantiate())
