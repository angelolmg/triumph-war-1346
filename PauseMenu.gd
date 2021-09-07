extends Control

const MenuHitSound = preload("res://Sounds/MenuHitSound.tscn")

func _ready():
	pass # Replace with function body.

func _on_TryAgain_pressed():
	#Criar instancia
	var GrabedInstance= MenuHitSound.instance()
	#Adicionar a arvore game
	self.add_child(GrabedInstance)
	get_tree().change_scene("res://Main.tscn")
	get_tree().paused = false

func _on_GoToMenu_pressed():
	#Criar instancia
	var GrabedInstance= MenuHitSound.instance()
	#Adicionar a arvore game
	self.add_child(GrabedInstance)
	get_tree().change_scene("res://MainMenu.tscn")
	get_tree().paused = false

func _input(event):
	if event.is_action_pressed("pause"):
		#Criar instancia
		var GrabedInstance= MenuHitSound.instance()
		#Adicionar a arvore game
		self.add_child(GrabedInstance)
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
