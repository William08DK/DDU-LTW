extends Node2D


func _ready() -> void:
	$Label.text = "Game over!\nYou collected " + str(Globals.coins) + " coins!"
