extends KinematicBody2D

onready var health_stat = $Health
onready var team = $Team

func get_team() -> int:
	return team.team

func handle_hit():
	health_stat.health -= 20
	if health_stat.health <= 0:
		queue_free()
