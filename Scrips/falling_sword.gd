extends Node2D

var on_ground: bool = false;

@export var buttonAnimationPlayer: AnimationPlayer
@export var buttonAudioStream: AudioStreamPlayer2D

func _on_press_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if not on_ground:
			on_ground = true
			$SwordSprite/AudioPlayer.play()
			$AnimationPlayer.play("Fall")
			buttonAnimationPlayer.play("Press")
			buttonAudioStream.play()


func _on_impact_sprite_animation_finished() -> void:
	$ImpactSprite.queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$ImpactSprite.visible = true
	$ImpactSprite.play("default")
