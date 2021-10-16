extends Area

func _ready():
	# below function was used to suck bar out when approaching from wrong angle
	# but I thought maybe it was too confusing / unclear why repairs wouldn't work
	pass

func _on_body_entered(body: Node):
	# don't collide with repair detectors any more
	body.call("set_collision_layer_bit", 2, false)
	body.grab_point = $GrabPoint
	get_tree().create_timer(1.0).connect("timeout", body, "queue_free")
