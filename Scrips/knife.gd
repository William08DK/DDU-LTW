extends RigidBody2D

var alive = true
var flip = false
const SPEED = 500

func _process(delta: float) -> void:
	if linear_velocity.x < SPEED and alive:
		alive = false
		$KnifeHurtArea.queue_free()
		$Timer.start()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	linear_velocity.y = 0

func _ready() -> void:
	scale.x = -1 if flip else 1
	var direction = -1 if flip else 1
	linear_velocity.x = direction * SPEED

func _on_timer_timeout() -> void:
	queue_free()
