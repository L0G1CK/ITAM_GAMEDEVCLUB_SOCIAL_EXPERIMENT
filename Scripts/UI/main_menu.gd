extends Node3D

@onready var logo: TextureRect = $CanvasLayer/Logo

var time: float = 0.0
func _process(delta: float):
	time += delta * 5
	logo.position.y = sin(time) * 2



func _on_play_pressed() -> void:
	await Transition.switch(true,1)
	$CanvasLayer/Buttons/Play.disabled = true
	
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
