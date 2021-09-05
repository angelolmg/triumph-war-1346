extends Node2D


onready var bullet_manager = $BulletManager
onready var player: Player = $Player

#Para instanciar por código
const Ally = preload("res://actors/Ally.tscn")
const callHelp = preload("res://CallHelp.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	_update_allies()
	randomize()
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	

func _update_allies():
	var allyNumb = get_tree().get_nodes_in_group("Allies")
	$HUD/HBoxContainer/Bars/AlliesStats/Background/Number.text = str(allyNumb.size())
	
func _process(delta): #Roda todo frame
	_update_allies()

func _generate_allies(body):
	var y_pos = 250; #posição y
	for n in 4: #Rode 4 vezes (0 a 4)
		#Criar instancia
		var GrabedInstance= Ally.instance()
		#Adicionar a arvore
		self.add_child(GrabedInstance)
		#Posicionar
		GrabedInstance.global_transform.origin = Vector2(40, y_pos)
		y_pos = y_pos + 25;

func _on_Timer_timeout():
	var x_pos = rand_range(0, 1000) #posição x
	var y_pos = rand_range(0, 600) #posição y
	#Criar instancia
	var GrabedInstance= callHelp.instance()
	#Adicionar a arvore game
	self.add_child(GrabedInstance)
	#Posicionar
	GrabedInstance.global_transform.origin = Vector2(x_pos, y_pos)
	GrabedInstance.connect("body_entered", self, "_generate_allies")
	$Timer.wait_time = 50 #setar tempo para respawnar
