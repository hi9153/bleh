extends CharacterBody2D


const SPEED = 450.00
const JUMP_VELOCITY = -750.00

var start_position = Vector2(70,50)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		if abs(velocity.x) > 10:
			anim.play("move")
		else:
			anim.play("idle")
	if velocity.x < 0:
		anim.flip_h = true
	else:
		anim.flip_h = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
	if velocity.y > 0:
		anim.play("fall")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
#respawn
	if position.y > 2000.00:
		respawn()
func respawn():
	position = start_position
	
	
 


@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
