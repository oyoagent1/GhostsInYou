extends Node
var loaded_scene
var player_data
var game_state: gamestate
enum gamestate{MAIN_MENU, GAME_NORMAL, PAUSE_MENU, WEAPON_WHEEL}
@export var main_menu_path: String

signal all_flash

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_state = gamestate.MAIN_MENU
	load_scene(main_menu_path)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_P):
		all_flash.emit()

func load_scene(path: String):
	if loaded_scene != null:
		loaded_scene.queue_free()
	var new_scene = load(path)
	new_scene = new_scene.instantiate()
	add_child(new_scene)
	loaded_scene = get_child(0)