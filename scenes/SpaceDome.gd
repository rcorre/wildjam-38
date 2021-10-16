extends Spatial

const AIR_MAX := 1.0
const AIR_REGEN := 0.01
const AIR_DEGEN := 0.02

signal air_changed(amount)

var air := 1.0

func _physics_process(delta: float):
	var broken_count := len(get_tree().get_nodes_in_group("broken"))
	var air_delta := AIR_REGEN - AIR_DEGEN * broken_count
	air = clamp(air + air_delta * delta, 0.0, 1.0)
	emit_signal("air_changed", air)
