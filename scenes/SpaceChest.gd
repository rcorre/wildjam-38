extends Spatial

onready var anim: AnimationPlayer = $AnimationPlayer

func on_interact_hover(on: bool):
	if on:
		anim.play("Open")
	else:
		anim.play_backwards("Open")
