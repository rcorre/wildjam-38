extends Spatial

const SPEED := 7.0

var grab_point: Spatial = null

func _physics_process(delta: float):
	if grab_point:
		var dest := grab_point.global_transform
		global_transform = global_transform.interpolate_with(dest, delta * SPEED)
