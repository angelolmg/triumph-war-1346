extends KinematicBody2D

#onready var health_stat: int = 100
onready var ai = $AI
onready var weapon: Weapon = $Weapon
onready var health_stat = $Health
onready var team = $Team

const AllyDieSound = preload("res://Sounds/AllyDieSound.tscn")
const EnemyDieSound = preload("res://Sounds/EnemyDieSound.tscn")
const EnemyGen = preload("res://actors/EnemyGen.tscn")
const Enemy = preload("res://actors/Enemy.tscn")

export (int) var speed = 100

func _ready():
	ai.initialize(self, weapon, team.team)
	weapon.initialize(team.team)
	var GrabedInstance= EnemyGen.instance() #Adiciona um gerador de inimigos, desde que ele gera inimigos
	self.add_child(GrabedInstance)
	var x_pos = self.global_position.x
	var y_pos = self.global_position.y
	GrabedInstance.global_transform.origin = Vector2(x_pos, y_pos)
	GrabedInstance.hide()
	

func rotate_toward(location: Vector2):
	rotation = lerp(rotation, global_position.direction_to(location).angle(), 0.1)
	
func velocity_toward(location: Vector2) -> Vector2:
	return global_position.direction_to(location) * speed

func get_team() -> int:
	return team.team

func handle_hit():
	health_stat.health -= 20
	
	var body = get_node("Body")
	var head = get_node("Head")
	body.modulate = Color8(body.modulate.r8-25,body.modulate.g8-25,body.modulate.b8-25)
	head.modulate = Color8(head.modulate.r8-25,head.modulate.g8-25,head.modulate.b8-25)
	
	if health_stat.health <= 0:
		#Criar 4 novos inimigos
		var x_pos = global_position.x
		var y_pos = global_position.y
		x_pos = x_pos - 20
		for n in 4: #Rode 4 vezes (0 a 4)
			var newEnemyInstance= Enemy.instance()
			get_tree().get_root().get_node("Main").add_child(newEnemyInstance)
			newEnemyInstance.global_transform.origin = Vector2(x_pos, y_pos)
			x_pos = x_pos + 10
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
