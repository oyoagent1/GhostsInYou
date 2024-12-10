extends Node


@export var weapons: Array
var active_weapon: int = 0
var weapon_swap: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapons.append(get_children())
	print(weapons)
	switch_weapons(1)
	print(weapon_swap, " ", active_weapon)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func switch_weapons(index:int):
	if index == active_weapon:
		return
	weapon_swap = active_weapon
	active_weapon = index
	get_child(weapon_swap).process_mode = Node.PROCESS_MODE_DISABLED
	get_child(weapon_swap).hide()
	print(get_child(weapon_swap))
	print(weapon_swap)
	print(active_weapon)

