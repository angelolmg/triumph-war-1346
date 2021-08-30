extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TryAgain_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Main.tscn")


func _on_GoToMenu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://MainMenu.tscn")

func _process(delta):
	if Input.is_action_pressed("pause"):
		if get_tree().paused == true:
			get_tree().paused = false
			hide()
