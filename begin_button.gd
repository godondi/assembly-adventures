extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	# Set button text
	text = "Begin Challenge"

	# Center text
	alignment = HORIZONTAL_ALIGNMENT_CENTER

	# Create custom style
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0, 0, 0, 0) # Transparent background
	style.border_color = Color.WHITE
	style.border_width_left = 2
	style.border_width_right = 2
	style.border_width_top = 2
	style.border_width_bottom = 2
	style.corner_radius_top_left = 20
	style.corner_radius_top_right = 20
	style.corner_radius_bottom_left = 20
	style.corner_radius_bottom_right = 20

	add_theme_stylebox_override("normal", style)
	add_theme_stylebox_override("hover", style)
	add_theme_stylebox_override("pressed", style)

	# White text
	add_theme_color_override("font_color", Color.WHITE)
	add_theme_color_override("font_hover_color", Color.WHITE)
	add_theme_color_override("font_pressed_color", Color.WHITE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
