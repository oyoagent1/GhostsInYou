extends Node
@export var play_path: String
var dark_mode: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_button_pressed() -> void:
	get_parent().load_scene(play_path)

func _on_button_2_pressed() -> void:
	$CanvasLayer/Control/Button2.text = "this button and the moon- Lukas \n everything else - me"


func _on_button_moon_pressed() -> void:
	if !dark_mode:
		$"Sprite-0002".texture = load("res://Art/Sprites/Sprite-0003.png")
	else:
		$"Sprite-0002".texture = load("res://Art/Sprites/Sprite-0002.png")
	dark_mode = !dark_mode
