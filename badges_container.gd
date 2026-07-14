# badges_container.gd — attach to BadgesContainer
extends HBoxContainer  # match whatever BadgesContainer actually is (GridContainer, HBoxContainer, etc.)

const GRAYSCALE_SHADER := preload("res://badge_grayscale.gdshader")

# Names of badges the player has already earned.
# Swap this for real save/progress data later.
@export var earned_badges: Array[String] = []

func _ready() -> void:
	for badge in get_children():
		_setup_badge(badge)

func _setup_badge(badge: Node) -> void:
	if not badge is TextureRect:
		return

	# Required so gui_input actually fires on this control
	badge.mouse_filter = Control.MOUSE_FILTER_STOP

	# Give each badge its own ShaderMaterial instance
	var mat := ShaderMaterial.new()
	mat.shader = GRAYSCALE_SHADER
	badge.material = mat

	var is_earned := badge.name in earned_badges
	mat.set_shader_parameter("gray_amount", 0.0 if is_earned else 1.0)

	badge.gui_input.connect(_on_badge_gui_input.bind(badge))

func _on_badge_gui_input(event: InputEvent, badge: TextureRect) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_reveal_color(badge)

func _reveal_color(badge: TextureRect) -> void:
	var mat: ShaderMaterial = badge.material
	var tween := create_tween()
	tween.tween_method(
		func(v): mat.set_shader_parameter("gray_amount", v),
		mat.get_shader_parameter("gray_amount"), 0.0, 0.4
	).set_trans(Tween.TRANS_SINE)
