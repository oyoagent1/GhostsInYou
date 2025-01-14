extends Node3D
var anim_player: AnimationPlayer
@export var range: float
@export var camera: Camera3D
@export var damage: float
@export var firerate: float
var cooldown: float

func _ready() -> void:
	anim_player = $AnimationPlayer

func shoot():
	if cooldown > 0:
		return
	anim_player.play("shoot")
	var direct_state = get_world_3d().direct_space_state
	var params: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(camera.global_position,  camera.global_position - camera.global_transform.basis.z * 100)
	var collision = direct_state.intersect_ray(params)
	if collision && collision["collider"].get_child_count() > 0:
		print(collision["collider"].position)
		if collision["collider"].get_child(0).has_method("change_health"):
			collision["collider"].get_child(0).change_health(-damage) 
	cooldown = firerate

func _process(delta: float) -> void:
	if cooldown > 0:
		cooldown -= delta
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("fire"):
		shoot()


	
