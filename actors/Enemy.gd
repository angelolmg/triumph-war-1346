extends KinematicBody2D

#onready var health_stat: int = 100
onready var ai = $AI
onready var weapon: Weapon = $Weapon
onready var health_stat = $Health
onready var team = $Team

const AllyDieSound = preload("res://Sounds/AllyDieSound.tscn")
const EnemyDieSound = preload("res://Sounds/EnemyDieSound.tscn")

export (int) var speed = 100

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
			#Criar instancia
			var GrabedInstance= AllyDieSound.instance()
			#Adicionar a arvore game
			get_tree().get_root().get_node("Main").add_child(GrabedInstance)
		if team.team == 1:
			#Criar instancia
			var GrabedInstance= EnemyDieSound.instance()
			#Adicionar a arvore game
			get_tree().get_root().get_node("Main").add_child(GrabedInstance)
		queue_free()

func _on_Area2D_body_entered(body): #Caso algo bata nele
	if body.get_collision_layer() == 5 or body.get_collision_layer() == 256: #vê se ta no layer de camada 9, bit 8, valor 256
		#Criar instancia
		var GrabedInstance= AllyDieSound.instance()
		#Adicionar a arvore game
		get_tree().get_root().get_node("Main").add_child(GrabedInstance)
		body.queue_free()
