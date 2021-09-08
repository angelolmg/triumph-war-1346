extends Node2D

onready var bullet_manager = $BulletManager
onready var player: Player = $Player

#Para instanciar por código
const Ally = preload("res://actors/Ally.tscn")
const callHelp = preload("res://CallHelp.tscn")
const enemyTransf = preload("res://EnemyTransf.tscn")

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
	_check_game_status()

func _generate_allies(body):
	var x_pos = rand_range(30, 60) #posição x
	var y_pos = rand_range(100, 580) #posição y
	for n in 4: #Rode 4 vezes (0 a 4)
		#Criar instancia
		var GrabedInstance= Ally.instance()
		#Adicionar a arvore
		self.add_child(GrabedInstance)
		#Posicionar
		GrabedInstance.global_transform.origin = Vector2(x_pos, y_pos)
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
	$HelpCallerGen.wait_time = 5 #setar tempo para respawnar

func _check_game_status(): #Checar se os aliados/player estão mortos ou os inimigos estão mortos
	var allyNumb = get_tree().get_nodes_in_group("Allies").size()
	allyNumb = allyNumb + get_tree().get_nodes_in_group("player").size()
	var enemyNumb = get_tree().get_nodes_in_group("Enemy").size()
	if allyNumb == 0:
		get_tree().change_scene("res://DeathMenu.tscn")
	if enemyNumb == 0:
		get_tree().change_scene("res://WinMenu.tscn")

func _on_EnemyTransGen_timeout():
	var x_pos = rand_range(20, 800) #posição x
	var y_pos = rand_range(20, 550) #posição y
	#Criar instancia
	var GrabedInstance= enemyTransf.instance()
	#Adicionar a arvore game
	self.add_child(GrabedInstance)
	#Posicionar
	GrabedInstance.global_transform.origin = Vector2(x_pos, y_pos)
	$EnemyTransGen.wait_time = 10 #setar tempo para respawnar
