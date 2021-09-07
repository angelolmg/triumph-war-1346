extends KinematicBody2D
class_name Player

export (int) var speed = 200

const AllyDieSound = preload("res://Sounds/AllyDieSound.tscn")

onready var weapon: Weapon = $Weapon
onready var health_stat = $Health
onready var team = $Team

func _ready():
	weapon.initialize(team.team)

func _physics_process(delta):
	var movement_direction := Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		movement_direction.y = -1
	if Input.is_action_pressed("down"):
		movement_direction.y = 1
	if Input.is_action_pressed("left"):
		movement_direction.x = -1
	if Input.is_action_pressed("right"):
		movement_direction.x = 1
	
	movement_direction = movement_direction.normalized()
	move_and_slide(movement_direction * speed)
	look_at(get_global_mouse_position())
	
func _unhandled_input(event):
	if event.is_action_released("shoot"):
		weapon.shoot()

func get_team() -> int:
	return team.team

func handle_hit():
	health_stat.health -= 20
	if health_stat.health <= 0:
		#Criar instancia
		var GrabedInstance= AllyDieSound.instance()
		#Adicionar a arvore game
		get_tree().get_root().get_node("Main").add_child(GrabedInstance)
		queue_free()
	#print("player hit", health_stat.health)

