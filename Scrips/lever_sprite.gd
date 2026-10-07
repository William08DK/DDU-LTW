extends AnimatedSprite2D

var lem_opened: bool = false
@export var leverAudio: AudioStreamPlayer2D

func _on_lever_body_entered(body: Node2D) -> void:
	if not body is CharacterBody2D: return
	if lem_opened: return
	lem_opened = true
	leverAudio.play()
	play("pull")
