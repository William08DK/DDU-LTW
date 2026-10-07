extends CharacterBody2D

const SPEED: float = 130.0
const JUMP_VELOCITY: float = -320.0

var knife = preload("res://Scene/knife.tscn")

@export var camera_3d: Node3D
@export var weapon_instruction: Label

var gravity_multiplier: float = 1.0
var gravity_rotation: float = 0.0

var coyote_timeout: float = 0.0
var has_jumped: bool = false

var weapon: int = 0

var current_state: String = "idle"

const states: Dictionary = {
	"idling": "idle",
	"moving": "run",
	"jumping": "jump"
}

var current_attack: String = ""
var attack_cooldown: float = 0.0

const attacks: Dictionary = {
	"primary": "throw",
	"secondary": "shoot"
}

func update_state() -> void:
	if not is_on_floor():
		current_state = states["jumping"]
		return
	
	if velocity.length() != 0.0:
		current_state = states["moving"]
		return
	
	current_state = states["idling"]
	return

func do_attack():
	match current_attack:
		"throw":
			var new_knife = knife.instantiate()
			new_knife.flip = $AnimatedSprite2D.flip_h
			new_knife.global_position = global_position + Vector2(0, -10)
			get_tree().current_scene.add_child(new_knife)
	
	if current_attack != "":
		current_attack = ""
		attack_cooldown = 0.5

func update_attack(delta: float) -> void:
	attack_cooldown = max(attack_cooldown - delta, 0.0)
	
	if attack_cooldown > 0.0:
		return
	
	if not weapon:
		return
	
	if Input.is_action_just_pressed("attack_primary"):
		current_attack = attacks["primary"]
		return
	
	if Input.is_action_just_pressed("attack_secondary"):
		#current_attack = attacks["secondary"]
		return
	
	do_attack()

func update_sprite() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction: $AnimatedSprite2D.flip_h = true if direction < 0 else false
	
	$AnimatedSprite2D.play(current_state)

func handle_gravity(delta: float) -> void:
	if not is_on_floor() or gravity_multiplier != 1.0:
		coyote_timeout = max(coyote_timeout - delta, 0.0)
		var gravity = get_gravity()
		if gravity_multiplier != 1.0:
			gravity = gravity.rotated(deg_to_rad(gravity_rotation)) * gravity_multiplier
		velocity += gravity * delta
	else:
		coyote_timeout = 0.1

func handle_horizontal_movement() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		if gravity_multiplier == 1 or gravity_rotation == 0: velocity.x = move_toward(velocity.x, 0, SPEED)

func handle_jump() -> void:
	if Input.is_action_pressed("jump") and coyote_timeout > 0.0:
		coyote_timeout = 0.0
		velocity.y = JUMP_VELOCITY

func update_3d_camera():
	if not RotatingCubeCheck.rotating_cube: return
	if not camera_3d: return
	
	camera_3d.position.y = max(-(global_position.y / 20 + 10), -12)
	camera_3d.global_rotation.y = ((global_position.x - 144) / 1872) * (2 * PI)

func handle_movement(delta: float) -> void:
	handle_horizontal_movement()
	handle_gravity(delta)
	handle_jump()
	move_and_slide()

func update_player_info():
	PlayerInfo.global_position = global_position
	$Control/ColorRect/HealthBar.size.x = max(0.0, 24.0 / PlayerInfo.MAX_HEATH * PlayerInfo.health)

func _physics_process(delta: float) -> void:
	update_state()
	update_attack(delta)
	update_sprite()
	update_3d_camera()
	handle_movement(delta)
	update_player_info()

func _on_pickup_area_pickup(id: int) -> void:
	weapon = id
	$SwordPickup.play()

func _on_wind_detector_set_wind(value: float, wind_rotation: float) -> void:
	gravity_multiplier = value
	gravity_rotation = wind_rotation

func _on_button_on_wall_falling_sword_pickup_external(id: Variant) -> void:
	weapon = id
	weapon_instruction.visible = true
