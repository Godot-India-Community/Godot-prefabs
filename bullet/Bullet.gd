extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity
var speed = 300

func start(pos, dir):
	position = pos
	rotation = dir.angle()
	velocity = speed * dir
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
#	pass


func _on_Bullet_area_entered(area):
	if area.has_method("shot"):
		area.shot()
		queue_free()
		
