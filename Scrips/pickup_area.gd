extends Area2D

signal pickup(id)

@export var sword: Node2D
@export var button_sword_root: Node2D

var picked_up = false
var pickupable = 0

func _ready() -> void:
	if not button_sword_root.get_meta("id", 0): assert(false)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not picked_up: pickupable = button_sword_root.get_meta("id", 0)

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D: pickupable = 0

func handle_pickup():
	if Input.is_action_just_pressed("pickup") and pickupable:
		emit_signal("pickup", pickupable)
		$AudioStreamPlayer2D.play()
		pickupable = 0
		sword.visible = false

func _process(delta: float) -> void:
	handle_pickup()
