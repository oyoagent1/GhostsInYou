extends Node3D
@export var projectile_path: String
@export var aim: Node3D
@onready var projectile
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func aim_at(pos: Vector3):
	aim.look_at(pos)

func shoot():
	projectile = load(projectile_path).instantiate()
	get_tree().root.add_child(projectile)
	projectile.transform = aim.global_transform
