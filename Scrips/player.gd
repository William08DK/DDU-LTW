extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var time_since_ground = 0.0
var has_jumped = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		has_jumped = false
		time_since_ground = 0.0
		
	time_since_ground += delta * 1000

	# Handle jump.
	if Input.is_action_pressed("jump") and not has_jumped and time_since_ground < 125:
		velocity.y = JUMP_VELOCITY
		has_jumped = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Play animations
	
	if is_on_floor():
		if direction == 0:
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("jump")
	

	
	if direction:
		$AnimatedSprite2D.flip_h = true if direction < 0 else false
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
