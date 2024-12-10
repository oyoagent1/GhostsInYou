extends Node3D

@export var weapons: Array
var active_weapon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapons.append(get_child(0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(weapons)
