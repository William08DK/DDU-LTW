extends Area2D

func _on_body_entered(body: Node2D) -> void:
	Globals.coins += 1
	$CollisionShape2D.queue_free()
	$AnimatedSprite2D.queue_free()
	$AnimationPlayer.queue_free()
	$CoinSound.play()

func _on_coin_sound_finished() -> void:
	queue_free()
