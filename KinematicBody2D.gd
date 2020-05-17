extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 140
const GRAVITY = 10
const JUMPFORCE = -400

var motion = Vector2(0, 0)

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$Sprite.play("walk")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$Sprite.play("walk")
	else:
		$Sprite.play("idle")
		
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		motion.y = JUMPFORCE
	else:
		motion.y += GRAVITY
	
	
	motion = move_and_slide(motion, UP)
	
	if (motion.y != 0):
		$Sprite.play("air")
		
	$Sprite.flip_h = motion.x < 0
		
	motion.x = lerp(motion.x, 0, 0.1)
