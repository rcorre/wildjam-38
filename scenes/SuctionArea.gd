extends Area

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body: Node):
	# don't collide with repair detectors any more
	body.call("set_collision_layer_bit", 2, false)
	body.call("on_grab", $GrabPoint)
	get_tree().create_timer(1.0).connect("timeout", body, "queue_free")
