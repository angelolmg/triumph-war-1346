extends Node2D

signal state_changed(new_state)

enum State {
	PATROL,
	ENGAGE
}

onready var patrol_timer = $PatrolTimer

var current_state: int = -1 setget set_state
var actor: KinematicBody2D = null
var target: KinematicBody2D = null
var weapon: Weapon = null
var team: int = -1

# Patrol state
var origin: Vector2 = Vector2.ZERO
var patrol_location: Vector2 = Vector2.ZERO
var patrol_location_reached: bool = false
var actor_velocity: Vector2 = Vector2.ZERO

func _ready():
	set_state(State.PATROL)

func _physics_process(delta):
	match current_state:
		State.PATROL:
			if not patrol_location_reached:
				actor.move_and_slide(actor_velocity,Vector2( 0, 0),false,1)
				actor.rotate_toward(patrol_location)
				if actor.global_position.distance_to(patrol_location) < 5:
					patrol_location_reached = true
					origin = global_position
					actor_velocity = Vector2.ZERO
					patrol_timer.start()
		State.ENGAGE:
			if target != null and weapon != null:
				actor.rotate_toward(target.global_position)
				var angle_to_target = actor.global_position.direction_to(target.global_position).angle()
				if (actor.rotation - angle_to_target) < 0.1:
					weapon.shoot()
			else:
				print("Engage state but no weapon/target")
				
		_:
			print("Error: found enemy state that should not exist")

func set_state(new_state: int):
	if new_state == current_state:
		return
	
	if new_state == State.PATROL:
		origin = global_position
		patrol_timer.start()
		patrol_location_reached = true
	
	current_state = new_state
	emit_signal("state_changed", current_state)

func initialize(actor: KinematicBody2D, weapon: Weapon, team: int):
	self.actor = actor
	self.weapon = weapon
	self.team = team
	

func _on_PatrolTimer_timeout():
	var patrol_range = 150
	var random_x = rand_range(-patrol_range, patrol_range)
	var random_y = rand_range(-patrol_range, patrol_range)
	var new_x = clamp(random_x + origin.x, 50, 950)
	var new_y = clamp(random_y + origin.y, 50, 550)
	patrol_location = Vector2(new_x, new_y)
	patrol_location_reached = false
	actor_velocity = actor.velocity_toward(patrol_location)


func _on_DetectionZone_body_entered(body):
	if body.has_method("get_team") and body.get_team() != team and body.get_team() != 2:
		set_state(State.ENGAGE)
		target = body


func _on_DetectionZone_body_exited(body):
	if target and body == target:
		set_state(State.PATROL)
		target = null
	
