extends Spatial

const AIR_MAX := 1.0
const AIR_REGEN := 0.01
const AIR_DEGEN := 0.102

signal air_changed(amount)

onready var anim: AnimationPlayer = $AnimationPlayer

var air := 1.0
var ended := false

func _physics_process(delta: float):
	var broken_count := len(get_tree().get_nodes_in_group("broken"))
	var air_delta := AIR_REGEN if broken_count == 0 else -AIR_DEGEN * broken_count
	air = clamp(air + air_delta * delta, 0.0, 1.0)
	emit_signal("air_changed", air)

	if air == 0.0 and not ended:
		ended = true
		anim.play("end")
		yield(anim, "animation_finished")
		get_tree().change_scene("res://scenes/TitleScene.tscn")
