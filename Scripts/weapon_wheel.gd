extends Node

@onready var divider = preload("res://Scenes/weapon_wheel_divider.tscn")
@onready var icon = preload("res://Scenes/weapon_wheel_sprite.tscn")
@export var hands: Node3D
signal selectweapon(index)
var default_icon = "res://Art/Sprites/health.png"
var mouse_input: Vector2
@export var num_slices: int = 5
@export var icons: Array
var slice_angles: Array
var slices: Array
var selector: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selector = $Node2D
	var angle_incriement = 360 / num_slices
	var i = 0
	var sprite_i = 0
	while i <= 360:
		slice_angles.append(i)
		add_child(divider.instantiate())
		get_child(get_child_count()-1).rotation = (deg_to_rad(i))
		print(i)
		print(rad_to_deg(get_child(get_child_count()-1).rotation))
		if i < 360:
			add_child(icon.instantiate())
			get_child(get_child_count()-1).rotation = (deg_to_rad(i + angle_incriement/2))
			var sprite: Sprite2D = get_child(get_child_count()-1).get_child(0)
			if sprite_i >= icons.size():
				sprite.texture = load(default_icon) 
			else: 
				sprite.texture = load(icons[sprite_i]) 
		print(i)
		i += angle_incriement
		sprite_i += 1
	print(slice_angles)
	i = 0
	while i+1 < slice_angles.size():
		slices.append(Vector2(slice_angles[i], slice_angles[i+1]))
		i += 1 
	print(slices)

	
func _input(event):
	if event is InputEventMouseMotion:
		mouse_input = event.velocity

func close():
	hands.switch_weapons(get_slected_slice())

# Called every frame. 'delta' is the el2apsed time since the previous frame.
func _process(delta: float) -> void:
	selector.rotate((mouse_input.x) * delta * 0.2)
	var selector_rotation = rad_to_deg(selector.rotation)
	if selector_rotation > 360:
		selector.rotation = deg_to_rad(0)
	elif selector_rotation < 0:
		selector.rotation = deg_to_rad(359)
	mouse_input = Vector2.ZERO
	#get_slected_slice()

func get_slected_slice() -> int:
	var selector_rotation = rad_to_deg(selector.rotation)
	var i = 0
	while i+1 <= slices.size():
		if selector_rotation > slices[i].x && selector_rotation < slices[i].y:
			print(i)
			print(selector_rotation)
			return i
		i += 1 
	return -1