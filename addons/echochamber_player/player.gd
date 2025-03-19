@tool
extends Control

const RENDERERS_DIR = "addons/echochamber_player/renderers"
enum {CLOSED, OPENING, STOPPED, PLAYING}
var state = CLOSED
var _current_renderer: Node

func _renderer_dir(renderer: String) -> String:
	if OS.has_feature("standalone"):
		var ret = OS.get_executable_path().path_join(RENDERERS_DIR).path_join(renderer)
		if DirAccess.dir_exists_absolute(ret):
			return ret
	return "res://".path_join(RENDERERS_DIR).path_join(renderer)

func open(renderer: String, renderable: String) -> bool:
	if renderer.get_base_dir() != "":
		push_error("Renderer string must not be a path")
		return false

	var renderer_scene = load(_renderer_dir(renderer).path_join("main.tscn")).instantiate()
	if !renderer_scene:
		push_error("Renderer not found: " + renderer)
		return false
	
	if _current_renderer:
		remove_child(_current_renderer)
		_current_renderer.free()
	
	_current_renderer = renderer_scene
	add_child(renderer_scene)
	
	state = OPENING
	await renderer_scene.open(renderable)
	state = STOPPED
	
	return true

func play():
	if state != STOPPED:
		push_error("Player state is not STOPPED, it's " + state)
	_current_renderer.play()
