extends Area2D
class_name Bullet

export (int) var speed = 10

onready var kill_timer = $KillTimer

const BulletShootSound = preload("res://Sounds/BulletShootSound.tscn")

var direction := Vector2.ZERO
var team: int = -1

func _ready():
	var GrabedInstance= BulletShootSound.instance()
	get_tree().get_root().get_node("Main").add_child(GrabedInstance)
	kill_timer.start()

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity

func set_direction(direction: Vector2):
	self.direction = direction
	self.rotation += direction.angle()


func _on_KillTimer_timeout():
	queue_free()


func _on_Bullet_body_entered(body):
	if body.has_method("handle_hit"):
		if body.has_method("get_team") and body.get_team() != team:
			body.handle_hit()
		queue_free()
