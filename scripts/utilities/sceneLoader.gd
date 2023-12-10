extends Node

class_name MySceneLoader
var current_scene: Node = null

var scenes = [
	"res://packedscenes/Menu/menu_ui.tscn",
	"res://Main.tscn",
	"res://packedscenes/Levels/temp_scene_2.tscn"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	print(current_scene)

func menuScene():
	call_deferred("_deferred_goto_scene", 0)
func gameScene():
	call_deferred("_deferred_goto_scene", 1)
func gameScene2():
	call_deferred("_deferred_goto_scene", 2)

func _deferred_goto_scene(sceneNumber):
	var s = ResourceLoader.load(scenes[sceneNumber])
	current_scene.free()
	current_scene = s.instantiate()
	print("test")
	print(current_scene)
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	get_tree().paused = false
	

