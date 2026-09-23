extends Node2D


func update_button_press_anim():
	var button: Node2D = $Button
	var button_anim: AnimationPlayer = $Button/AnimationPlayer
	
	button.global_position = get_meta("button_position")
	button.global_rotation = deg_to_rad(get_meta("button_rotation"))
	
	var animation = button_anim.get_animation("Press")
	for idx in animation.get_track_count():
		var path = animation.track_get_path(idx)
		match path.get_concatenated_subnames():
			"position":
				animation.track_set_key_value(idx, 0, get_meta("button_position"))
				animation.track_set_key_value(idx, 1, get_meta("button_position") - Vector2(0, -10).rotated(deg_to_rad(get_meta("button_rotation"))))

func update_sword_fall_anim():
	var sword: Node2D = $FallingSword
	var sword_anim: AnimationPlayer = $FallingSword/AnimationPlayer
	
	sword.global_position = get_meta("sword_start_position")
	sword.global_rotation = deg_to_rad(get_meta("sword_rotation"))
	
	var animation = sword_anim.get_animation("Fall")
	for idx in animation.get_track_count():
		var path = animation.track_get_path(idx)
		match path.get_concatenated_subnames():
			"position":
				animation.track_set_key_value(idx, 0, get_meta("sword_start_position"))
				animation.track_set_key_value(idx, 1, get_meta("sword_end_position"))

func _ready() -> void:
	update_button_press_anim()
	update_sword_fall_anim()
