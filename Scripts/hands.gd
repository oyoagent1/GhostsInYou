extends Node


@export var weapons: Array
@export var weapon_wheel: Node
@export var player: Node3D
# How long the swap key should be held before opening the weapon wheel instead
@export var swap_action_hold_time: float 
var active_weapon: int = 0
var weapon_swap: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon_wheel.hide()
	weapon_wheel.process_mode = Node.PROCESS_MODE_DISABLED
	weapons.append(get_children())
	print(weapons)
	switch_weapons(1)
	print(weapon_swap, " ", active_weapon)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("wheel"):
		toggle_weapon_wheel(true)
	elif Input.is_action_just_released("wheel"):
		toggle_weapon_wheel(false)
	if Input.is_action_just_pressed("swap"):
		print("swap")
		switch_weapons(weapon_swap)

func _input(event: InputEvent):
	pass
func switch_weapons(index:int):
	if index == active_weapon || index > get_child_count() - 1:
		return
	weapon_swap = active_weapon
	active_weapon = index
	get_child(weapon_swap).process_mode = Node.PROCESS_MODE_DISABLED
	get_child(weapon_swap).hide()
	print(get_child(weapon_swap))
	print(weapon_swap)
	print(active_weapon)
	get_child(active_weapon).show()
	get_child(active_weapon).process_mode = Node.PROCESS_MODE_PAUSABLE

func toggle_weapon_wheel(open: bool):
	if (open):
		weapon_wheel.show()
		weapon_wheel.process_mode = Node.PROCESS_MODE_PAUSABLE
		player.can_move = false
		Engine.time_scale = 0.01
	else:
		weapon_wheel.close()
		weapon_wheel.process_mode = Node.PROCESS_MODE_DISABLED
		weapon_wheel.hide()
		player.can_move = true
		Engine.time_scale = 1
	pass
