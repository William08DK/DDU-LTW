extends Node2D

@onready var button_anim: AnimationPlayer = $Button/AnimationPlayer
@onready var sword_anim: AnimationPlayer = $FallingSword/AnimationPlayer

func _ready() -> void:
	var animation
	
	$Button.global_position = get_meta("button_position")
	$Button.global_rotation = deg_to_rad(get_meta("button_rotation"))
	
	animation = button_anim.get_animation("Press")
	for idx in animation.get_track_count():
		var path = animation.track_get_path(idx)
		match path.get_concatenated_subnames():
			"position":
				animation.track_set_key_value(idx, 0, get_meta("button_position"))
				animation.track_set_key_value(idx, 1, get_meta("button_position") - Vector2(0, -10).rotated(deg_to_rad(get_meta("button_rotation"))))
	
	
	
	$FallingSword.global_position = get_meta("sword_start_position")
	$FallingSword.global_rotation = deg_to_rad(get_meta("sword_rotation"))
	
	animation = sword_anim.get_animation("Fall")
	for idx in animation.get_track_count():
		var path = animation.track_get_path(idx)
		match path.get_concatenated_subnames():
			"position":
				animation.track_set_key_value(idx, 0, get_meta("sword_start_position"))
				animation.track_set_key_value(idx, 1, get_meta("sword_end_position"))
