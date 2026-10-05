extends Node2D

var boss = preload("res://Scene/boss.tscn")

var lem_opened: bool = false

func _ready() -> void:
	RotatingCubeCheck.rotating_cube = true

func open_lem() -> void:
	lem_opened = true
	$TileMapLayer/Lem/AnimationPlayer.play("open")
	$TileMapLayer/Lem2/AnimationPlayer.play("open")

func spawn_boss() -> void:
	var boss_enemy: Node2D = boss.instantiate()
	add_child(boss_enemy)

func _on_lever_body_entered(body: Node2D) -> void:
	if not body is CharacterBody2D: return
	if lem_opened: return
	open_lem()
	spawn_boss()
