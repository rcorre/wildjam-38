extends Spatial

const SPEED := 5.0

var grab_point: Spatial = null

func _ready():
	add_to_group("grabbable")

func _physics_process(delta: float):
	if grab_point:
		var dest := grab_point.global_transform
		global_transform = global_transform.interpolate_with(dest, delta * SPEED)

func on_interact_hover(on: bool):
	pass

func on_grab(grabber: Spatial):
	grab_point = grabber
