extends KinematicBody2D

#onready var health_stat: int = 100
onready var ai = $AI
onready var weapon: Weapon = $Weapon
onready var health_stat = $Health
onready var team = $Team

export (int) var speed = 100

signal ally_killed
signal enemy_killed

func _ready():
	ai.initialize(self, weapon, team.team)
	weapon.initialize(team.team)

func rotate_toward(location: Vector2):
	rotation = lerp(rotation, global_position.direction_to(location).angle(), 0.1)
	
func velocity_toward(location: Vector2) -> Vector2:
	return global_position.direction_to(location) * speed

func get_team() -> int:
	return team.team

func handle_hit():
	health_stat.health -= 20
	if health_stat.health <= 0:
		if team.team == 0:
			emit_signal("ally_killed")
		if team.team == 1:
			emit_signal("enemy_killed")
		queue_free()

