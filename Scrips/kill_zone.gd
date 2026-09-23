extends Area2D

@onready var timer: Timer = $Timer

func kill_player(body: Node2D):
	print("You Died")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_body_entered(body: Node2D) -> void:
	kill_player(body)

func reload_scene():
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func _on_timer_timeout() -> void:
	reload_scene()
