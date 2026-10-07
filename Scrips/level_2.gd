extends Node2D

signal global_finished

var boss = preload("res://Scene/boss.tscn")

var lem_opened: bool = false

func _ready() -> void:
	RotatingCubeCheck.rotating_cube = true

func open_lem() -> void:
	lem_opened = true
	$TileMapLayer/Lem/AnimationPlayer.play("open")
	$TileMapLayer/Lem2/AnimationPlayer.play("open")
	$TileMapLayer/Wind/Wind1.queue_free()
	$TileMapLayer/Wind/Wind4.queue_free()

func spawn_boss() -> void:
	var boss_enemy: Node2D = boss.instantiate()
	add_child(boss_enemy)
	boss_enemy.connect("boss_dead", _on_boss_dead)

func _on_boss_dead():
	$TileMapLayer/Wind/Wind5.visible = true
	$TileMapLayer/Wind/Wind5.collision_layer = 8

func _on_lever_body_entered(body: Node2D) -> void:
	if not body is CharacterBody2D: return
	if lem_opened: return
	open_lem()
	spawn_boss()


func _on_win_zone_game_finished() -> void:
	emit_signal("global_finished")
