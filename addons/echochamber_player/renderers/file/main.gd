extends Control

@onready var container: AspectRatioContainer = $AspectRatioContainer
@onready var player: VideoStreamPlayer = $AspectRatioContainer/VideoStreamPlayer

func open(renderable: String) -> bool:
	player.stream.file = renderable
	var size = player.get_video_texture().get_size()
	container.ratio = size.x / size.y
	return true

func play():
	player.play()
