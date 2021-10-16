extends Spatial

const OPEN_SOUND := preload("res://assets/audio/toolBoxOpen.wav")
const CLOSE_SOUND := preload("res://assets/audio/toolBoxClose.wav")

onready var anim: AnimationPlayer = $AnimationPlayer
onready var sound: AudioStreamPlayer3D = $AudioStreamPlayer3D

func interact():
	anim.play("Open")
	sound.stream = OPEN_SOUND
	sound.play()
	yield(anim, "animation_finished")
	anim.play_backwards("Open")
	sound.stream = CLOSE_SOUND
	sound.play()
