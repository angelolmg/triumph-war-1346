extends KinematicBody2D

onready var health_stat: int = 300
onready var team = $Team

const Enemy = preload("res://actors/Enemy.tscn")

func _ready():
	pass # Replace with function body.

func get_team() -> int:
	return team.team

func _on_Timer_timeout():
	var GrabedInstance= Enemy.instance()
	self.add_child(GrabedInstance)
	var x_pos = global_position.x
	x_pos = x_pos - 30
	var y_pos = global_position.y
	GrabedInstance.global_transform.origin = Vector2(x_pos, y_pos)
	$Timer.wait_time = 10 #setar tempo para respawnar

func handle_hit():
	health_stat -= 20
	if health_stat <= 0:
		queue_free()
