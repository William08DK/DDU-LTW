extends CharacterBody2D


const SPEED: float = 130.0
const JUMP_VELOCITY: float = -300.0

var gravity_multiplier: int = 1

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
	"primary": "hit",
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

func update_attack(delta: float) -> void:
	attack_cooldown = max(attack_cooldown - delta, 0.0)
	
	if attack_cooldown > 0.0:
		return
	
	if Input.is_action_just_pressed("attack_primary"):
		current_attack = attacks["primary"]
		return
	
	if Input.is_action_just_pressed("attack_secondary"):
		current_attack = attacks["secondary"]
		return

func update_sprite() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction: $AnimatedSprite2D.flip_h = true if direction < 0 else false
	
	$AnimatedSprite2D.play(current_state)

func handle_gravity(delta: float) -> void:
	if not is_on_floor() or gravity_multiplier != 1:
		coyote_timeout = max(coyote_timeout - delta, 0.0)
		velocity += get_gravity() * delta * gravity_multiplier
	else:
		coyote_timeout = 0.1

func handle_horizontal_movement() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func handle_jump() -> void:
	if Input.is_action_pressed("jump") and coyote_timeout > 0.0:
		coyote_timeout = 0.0
		velocity.y = JUMP_VELOCITY

func handle_movement(delta: float) -> void:
	handle_gravity(delta)
	handle_horizontal_movement()
	handle_jump()
	move_and_slide()

func _physics_process(delta: float) -> void:
	update_state()
	update_attack(delta)
	update_sprite()
	handle_movement(delta)

func _on_pickup_area_pickup(id: int) -> void:
	weapon = id
	$SwordPickup.play()

func _on_wind_detector_set_wind(value: bool) -> void:
	gravity_multiplier = -1 if value else 1
	print(gravity_multiplier)
