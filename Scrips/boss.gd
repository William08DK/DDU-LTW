extends CharacterBody2D

const SPEED = 5

func _ready() -> void:
	global_position = Vector2(get_meta("pos_x"), get_meta("pos_y"))
	$Timer.start()

func handle_gravity(delta):
	if not is_on_floor(): velocity += get_gravity() * delta

func handle_horizontal_movement():
	velocity.x = move_toward(velocity.x, 0, SPEED)

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_horizontal_movement()
	move_and_slide()


func _on_timer_timeout() -> void:
	velocity += Vector2(200, -300)
	velocity.x *= sign(PlayerInfo.global_position.x - global_position.x)
	$Timer.start()
