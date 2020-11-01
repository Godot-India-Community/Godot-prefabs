extends KinematicBody2D

var velocity
var speed = 10
var by = ""
var dir 

func start(pos, _dir):
	position = pos
	velocity = speed * _dir
	dir = _dir
	
func _process(_delta):
	var collision = move_and_collide(velocity)
	if collision != null:
		if collision.collider.has_method("damage"):
			collision.collider.damage(5, by)
		queue_free()
