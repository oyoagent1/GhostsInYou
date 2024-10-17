extends CharacterBody3D
var move_input
var slide_dir
var input_dir: Vector3 = Vector3.ZERO
var head
var dash_cooldown
var headbob_time: float = 0.0
var slide_y_scale: float = 0.5
var sliding = false
var slamming = false

#export vars
@export var look_sense: float = 0.01
@export var walk_speed: float = 1
@export var jump_velocity: float = 10
@export var air_cap: float = 0.05
@export var air_accel: float = 800.0
@export var air_move_speed: float = 500.0
@export var dash_velocity: float = 15
@export var slide_velocity: float = 30
@export var slide_jump_mult = 1.5
@export var slam_fall_mult = 2
#consts
const HEADBOB_AMOUNT = 0.12
const HEADBOB_FREQUENCY = 0.8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	head = $Head

func _unhandled_input(event: InputEvent) -> void:
	#mouse look
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * look_sense)
		head.rotate_x(-event.relative.y * look_sense)
		#clamp head rotation
		head.rotation.x = deg_to_rad(clampf(rad_to_deg(head.rotation.x), -90, 90))

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	move_input = Input.get_vector("left", "right", "up", "down").normalized()
	input_dir = self.transform.basis * Vector3(move_input.x, 0.0, move_input.y)

	if is_on_floor():
		if slamming:
			slamming = false
		if Input.is_action_just_pressed("slide"):
			slide_dir = input_dir
			print(slide_dir)
			scale.y = 0.5
			sliding = true
		elif Input.is_action_just_released("slide"):
			scale.y = 1
			sliding = false
		if sliding:
			if Input.is_action_pressed("jump"):
				self.velocity.y = jump_velocity * 1.5
				scale.y = 1
				sliding = false
			_handle_slide_physics(delta)
		else:
			if Input.is_action_pressed("jump"):
				self.velocity.y = jump_velocity
			_handle_ground_physics(delta)
	else:
		_handle_air_physics(delta)

	move_and_slide()

func _handle_ground_physics(delta):
	velocity.z = input_dir.z * walk_speed
	velocity.x = input_dir.x * walk_speed
	_headbob_effect(delta)

func _handle_air_physics(delta):
	if Input.is_action_just_pressed("slide"):
		slamming = true
		velocity = Vector3(0, -1, 0)
	elif Input.is_action_just_released("slide"):
		slamming = false
	if slamming:
		velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta * slam_fall_mult
	else:
		velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta
	var current_speed_in_input_dir = velocity.dot(input_dir)
	var capped_speed = min((air_move_speed * input_dir).length(), air_cap)
	var add_speed_until_cap = capped_speed - current_speed_in_input_dir
	if add_speed_until_cap > 0:
		var accel_speed = air_accel * air_move_speed * delta
		accel_speed = min(accel_speed, add_speed_until_cap)
		velocity += accel_speed * input_dir

func _handle_slide_physics(delta):
	velocity.z = slide_dir.z * slide_velocity
	velocity.x = slide_dir.x * slide_velocity

func dash():
	pass

func _headbob_effect(delta):
	headbob_time += delta * self.velocity.length()
	$Head/Camera3D.transform.origin = Vector3(
		cos(headbob_time * HEADBOB_FREQUENCY * 0.5) * HEADBOB_AMOUNT,
		sin(headbob_time * HEADBOB_FREQUENCY) * HEADBOB_AMOUNT,
		0
	)
