extends Node2D


onready var bullet_manager = $BulletManager
onready var player: Player = $Player


# Called when the node enters the scene tree for the first time.
func _ready():
	_update_allies()
	randomize()
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	

func _update_allies():
	var allyNumb = get_tree().get_nodes_in_group("Allies")
	$HUD/HBoxContainer/Bars/AlliesStats/Background/Number.text = str(allyNumb.size())
	
func _process(delta):#Roda todo frame
	_update_allies()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
