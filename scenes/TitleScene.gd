extends Spatial

onready var anim: AnimationPlayer = $AnimationPlayer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(ev: InputEvent):
	if ev is InputEventMouseButton or ev is InputEventKey or ev is InputEventJoypadButton:
		anim.play("Start")
		yield(anim, "animation_finished")
		get_tree().change_scene("res://scenes/SpaceDome.tscn")
