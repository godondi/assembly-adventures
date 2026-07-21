# badges_container.gd — attach to BadgesContainer
extends HBoxContainer

const GRAYSCALE_SHADER := preload("res://badge_grayscale.gdshader")

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

	# Check against our global PlayerData singleton
	var is_earned := badge.name in PlayerData.earned_badges
	
	# Set directly to full color (0.0 gray) if earned globally, otherwise grayscale (1.0)
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
