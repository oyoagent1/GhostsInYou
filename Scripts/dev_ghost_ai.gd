extends CharacterBody3D

@export var nav_agent: NavigationAgent3D
@export var min_distance_to_target: float
@export var speed: float
@export var player: Node3D
@export var projectile_spawner: Node
var timer: Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = get_tree().create_timer()
	player = get_tree().get_first_node_in_group("Player")
	nav_agent.target_desired_distance = min_distance_to_target

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	nav_agent.target_position = player.position
	projectile_spawner.aim_at(player.position)
	move()

func move():
	if nav_agent.is_navigation_finished():
		return
	
	velocity = global_position.direction_to(nav_agent.get_next_path_position()) * speed
	move_and_slide()
