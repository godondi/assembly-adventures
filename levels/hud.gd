extends CanvasLayer

@onready var menu_button: Button = $MenuButton

func _ready() -> void:
	# Connect the button press event
	menu_button.pressed.connect(_on_menu_button_pressed)

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://control_center.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
