extends Node2D

@export var windstream2: StaticBody2D
@export var windstream3: StaticBody2D
@export var moving_platform: AnimationPlayer
@onready var animated_sprite: AnimatedSprite2D = $Button/ButtonSprite
@onready var click_audio: AudioStreamPlayer2D = $Button/AudioStreamPlayer2D
var pressed: bool = false

func _on_press_area_body_entered(body: Node2D) -> void:
	if pressed: return
	animated_sprite.play("press")
	click_audio.play()
	windstream2.visible = true
	windstream2.collision_layer = 8
	windstream3.visible = true
	windstream3.collision_layer = 8
	moving_platform.play("Up_and_Down")
	pressed = true
