extends RigidBody2D

var alive = true
var flip = false
var speed = 500

func _process(delta: float) -> void:
	if linear_velocity.x < speed and alive:
		alive = false
		$KnifeHurtArea.queue_free()
		$Timer.start()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	linear_velocity.y = 0

func _ready() -> void:
	$AnimatedSprite2D.flip_v = flip
	var direction = -1 if flip else 1
	linear_velocity.x = direction * speed

func _on_timer_timeout() -> void:
	queue_free()
