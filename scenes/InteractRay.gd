extends Area

const HOVER_METHOD := "on_interact_hover"
const BAR_SCENE := preload("res://scenes/SpaceDomeBar.tscn")

onready var grab_point: Spatial = $GrabPoint
var has_bar := false

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body: Node):
	if has_bar or not body.has_method("interact"):
		return

	# assuming only interactable is the chest
	body.call("interact")
	yield(get_tree().create_timer(1.0), "timeout")
	var bar := BAR_SCENE.instance()
	get_tree().current_scene.add_child(bar)
	bar.global_transform = body.global_transform
	has_bar = true
	bar.grab_point = grab_point
	yield(bar, "tree_exited")
	has_bar = false
