extends Area2D

@onready var timer: Timer = $Timer

func kill_player(body: Node2D, damage: int):
	PlayerInfo.health -= damage
	if PlayerInfo.health > 0: return
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_body_entered(body: Node2D) -> void:
	if not body is CharacterBody2D: return
	kill_player(body, get_meta("damage", 0))

func reload_scene():
	Engine.time_scale = 1
	get_tree().current_scene.reset()

func _on_timer_timeout() -> void:
	reload_scene()
