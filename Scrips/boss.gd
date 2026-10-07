extends CharacterBody2D

const SPEED = 5

const MAX_HEATH = 10
var health = MAX_HEATH

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

func _process(delta: float) -> void:
	update_health_bar()

func _on_timer_timeout() -> void:
	velocity += Vector2(200, -300)
	velocity.x *= sign(PlayerInfo.global_position.x - global_position.x)
	$Timer.start()

func update_health_bar():
	$Control/ColorRect/HealthBar.size.x = max(0.0, 50.0 / MAX_HEATH * health)

func take_damage(amount):
	health -= amount
	if health <= 0:
		$CollisionShape2D.queue_free()
		$KillZone.queue_free()
		$GetHurtZone.queue_free()
		$Timer.start()

func _on_get_hurt_zone_body_entered(body: Node2D) -> void:
	take_damage(body.get_meta("damage", 0))
