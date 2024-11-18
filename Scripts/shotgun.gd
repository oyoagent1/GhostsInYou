extends Node3D
var anim_player: AnimationPlayer
@export var range: float
@export var camera: Camera3D

func _ready() -> void:
	anim_player = $AnimationPlayer

func shoot():
	pass

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("fire"):
		shoot()


	
