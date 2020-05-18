extends KinematicBody2D

const UP = Vector2.UP
const SPEED = 140
const GRAVITY = 500
const JUMPFORCE = -400

var velocity = Vector2.ZERO

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMPFORCE
	else:
		velocity.y += GRAVITY * delta
	
	velocity = move_and_slide(velocity, UP)

	velocity.x = lerp(velocity.x, 0, 0.1)

	if not is_on_floor():
		$Sprite.play("air")
	elif velocity.x > 0 and int(velocity.x) > 20:
		$Sprite.play("walk")
	elif velocity.x < 0 and int(velocity.x) < -20:
		$Sprite.play("walk")
	else:
		$Sprite.play("idle")
		
	$Sprite.flip_h = velocity.x < 0
	
