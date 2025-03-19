extends Control

func _ready() -> void:	
	var args = OS.get_cmdline_args()
	if len(args) >= 2:
		await $EchochamberPlayer.open(args[0], args[1])
		$EchochamberPlayer.play()
