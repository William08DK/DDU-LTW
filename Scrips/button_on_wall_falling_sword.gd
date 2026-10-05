extends Node2D

signal pickup_external(id)

func update_sword_fall_anim():
	var sword: Node2D = $FallingSword
	var sword_anim: AnimationPlayer = $FallingSword/AnimationPlayer
	
	sword.global_position = get_meta("sword_start_position")
	sword.global_rotation = deg_to_rad(get_meta("sword_rotation"))
	
	var animation = sword_anim.get_animation("Fall")
	for idx in animation.get_track_count():
		var path = animation.track_get_path(idx)
		match path.get_concatenated_subnames():
			"global_position":
				animation.track_set_key_value(idx, 0, get_meta("sword_start_position"))
				animation.track_set_key_value(idx, 1, get_meta("sword_end_position"))

func _ready() -> void:
	update_sword_fall_anim()

func _on_pickup_area_pickup(id: Variant) -> void:
	emit_signal("pickup_external", id)
