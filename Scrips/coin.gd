extends Area2D


@onready var game_manager: Node = %GameManager

func _on_body_entered(body: Node2D) -> void:
	$CollisionShape2D.queue_free()
	$AnimatedSprite2D.queue_free()
	$AnimationPlayer.queue_free()
	$CoinSound.play()

func _on_coin_sound_finished() -> void:
	queue_free()
