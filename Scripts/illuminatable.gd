extends Node3D

@export var visibility: float
@export var max_vis: float
@export var sprite: AnimatedSprite3D
@export var flash_fade_time: float
@export var flash_timer: Timer
@export var light: OmniLight3D
@export var light_brightness: float
var game_node: Node


var flashing: bool

func _ready() -> void:
	flash_timer.wait_time = flash_fade_time
	game_node = get_tree().root.get_node("Game")
	game_node.connect("all_flash", flash)


func _process(delta: float) -> void:
	if flashing:
		set_vis((flash_timer.time_left/flash_fade_time)*100)
		if visibility == 0:
			flashing = false
			flash_timer.stop

func set_vis(vis):
	visibility = vis
	sprite.modulate.a = vis/100.0 #convert to %
	light.light_energy = (vis/100.0)*light_brightness
	
func change_vis_by(vis):
	visibility += vis
	if visibility > max_vis:
		visibility = max_vis
	elif visibility < 0:
		visibility = 0
	sprite.modulate.a = visibility/100.0 #convert to %

func flash():
	print("Flash!")
	flash_timer.start()
	flashing = true
	set_vis(max_vis)
