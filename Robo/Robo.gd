extends KinematicBody2D

const GRAVITY_VECTOR = Vector2(0, 980)
const UP_DIRECTION = Vector2(0, -1)

export var walk_speed = 250
export var jump_height = 500

var linear_velocity = Vector2()

func _physics_process(delta):
	# apply gravity
	linear_velocity += delta * GRAVITY_VECTOR
	linear_velocity = move_and_slide(linear_velocity, UP_DIRECTION, false)
	
	var target_speed = 0
	if Input.is_action_pressed("move_left"):
		target_speed -= 1
		$sprite.scale.x = -1
	if Input.is_action_pressed("move_right"):
		target_speed += 1
		$sprite.scale.x = 1
		
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		linear_velocity.y = -jump_height
	
	target_speed *= walk_speed
	linear_velocity.x = lerp(linear_velocity.x, target_speed, 0.1)
	
		
