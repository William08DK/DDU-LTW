extends RigidBody2D

var speed = 60

var health = 1

var direction = 1
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	position.x += direction * speed * delta

func take_damage(amount):
	health -= amount
	if health <= 0:
		speed = 0
		animated_sprite.play("die")
		$CollisionShape2D.queue_free()
		$KillZone.queue_free()
		$GetHurtZone.queue_free()
		$Timer.start()

func _on_get_hurt_zone_body_entered(body: Node2D) -> void:
	take_damage(body.get_meta("damage", 0))


func _on_timer_timeout() -> void:
	queue_free()
