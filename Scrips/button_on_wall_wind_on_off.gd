extends Node2D

@onready var windstream2: StaticBody2D = $"/root/Level2/TileMapLayer/Wind/Wind2"
@onready var windstream3: StaticBody2D = $"/root/Level2/TileMapLayer/Wind/Wind3"
@onready var button: Node2D = $Button
var pressed = false
func _ready() -> void:
	windstream2.visible = false
	windstream3.visible = false
	pressed = false
	_on_press_area_body_entered


func _on_press_area_body_entered(body: Node2D) -> void:
	if pressed == true:
		windstream2.visible
		windstream3.visible
	if pressed == false:
		windstream2.notvisible
		windstream3.notvisible
