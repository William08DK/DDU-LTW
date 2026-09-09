extends Node

@onready var level_1: Node2D = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(level_1)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
