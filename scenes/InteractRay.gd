extends Area

const HOVER_METHOD := "on_interact_hover"
const BAR_SCENE := preload("res://scenes/SpaceDomeBar.tscn")

onready var grab_point: Spatial = $GrabPoint

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body: Node):
	if grab_point.get_child_count() > 0:
		return

	if not body.has_method("interact"):
		return

	# assuming only interactable is the chest
	body.call("interact")
	yield(get_tree().create_timer(1.0), "timeout")
	var bar := BAR_SCENE.instance()
	grab_point.add_child(bar)
	bar.grab_point = grab_point
