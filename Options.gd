extends Control

const MenuHitSound = preload("res://Sounds/MenuHitSound.tscn")

func _ready():
	pass # Replace with function body.

func _on_BackButton_pressed():
	#Criar instancia
	var GrabedInstance= MenuHitSound.instance()
	#Adicionar a arvore game
	self.add_child(GrabedInstance)
	get_tree().change_scene("res://MainMenu.tscn")
