extends Area

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body: Node):
	get_parent().set_visible(true)
	body.queue_free()
	queue_free()
