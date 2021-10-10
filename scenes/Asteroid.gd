extends StaticBody

onready var anim: AnimationPlayer = $AnimationPlayer

func on_interact_hover(on: bool):
	anim.play("hover" if on else "unhover")

func on_interact():
	queue_free()
