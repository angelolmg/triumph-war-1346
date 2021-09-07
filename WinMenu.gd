extends Control

const MenuHitSound = preload("res://Sounds/MenuHitSound.tscn")
const WinSound = preload("res://Sounds/WinSound.tscn")

func _ready():
	#Criar instancia
	var GrabedInstance= WinSound.instance()
	#Adicionar a arvore game
	self.add_child(GrabedInstance)

func _on_TryAgain_pressed():
	#Criar instancia
	var GrabedInstance= MenuHitSound.instance()
	#Adicionar a arvore game
	self.add_child(GrabedInstance)
	get_tree().change_scene("res://Main.tscn")

func _on_GoToMenu_pressed():
	#Criar instancia
	var GrabedInstance= MenuHitSound.instance()
	#Adicionar a arvore game
	self.add_child(GrabedInstance)
	get_tree().change_scene("res://MainMenu.tscn")
