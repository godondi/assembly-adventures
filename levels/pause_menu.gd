extends CanvasLayer

@onready var control: Control = $Control
@onready var color_rect: ColorRect = $Control/ColorRect
@onready var menu_container: VBoxContainer = $Control/ColorRect/VBoxContainer

@onready var continue_button: Button = $Control/ColorRect/VBoxContainer/ContinueButton
@onready var restart_button: Button = $Control/ColorRect/VBoxContainer/RestartButton
@onready var control_center_button: Button = $Control/ColorRect/VBoxContainer/ControlCenterButton

var tween: Tween
var target_center_y: float

func _ready() -> void:
	# Hide initially
	hide()
	
	# Connect signals
	continue_button.pressed.connect(_on_continue_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	control_center_button.pressed.connect(_on_control_center_pressed)
	
	# Wait one frame so container layout positions update accurately
	await get_tree().process_frame
	target_center_y = menu_container.position.y

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			unpause()
		else:
			pause()

func pause() -> void:
	get_tree().paused = true
	show()
	
	# Kill running tween if toggled mid-animation
	if tween and tween.is_running():
		tween.kill()
		
	tween = create_tween().set_parallel(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	# Initial off-screen position & backdrop opacity
	menu_container.position.y = -menu_container.size.y - 100
	color_rect.modulate.a = 0.0
	
	# Animate in (Slide down + Fade backdrop)
	tween.tween_property(menu_container, "position:y", target_center_y, 0.4)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)
		
	tween.tween_property(color_rect, "modulate:a", 1.0, 0.3)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)

func unpause() -> void:
	# Kill running tween if toggled mid-animation
	if tween and tween.is_running():
		tween.kill()
		
	tween = create_tween().set_parallel(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	# Animate out (Slide up + Fade backdrop out)
	tween.tween_property(menu_container, "position:y", -menu_container.size.y - 100, 0.25)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_IN)
		
	tween.tween_property(color_rect, "modulate:a", 0.0, 0.25)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_IN)
	
	# Unpause game logic and hide node after animation completes
	tween.chain().tween_callback(func():
		get_tree().paused = false
		hide()
	)

func _on_continue_pressed() -> void:
	unpause()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_control_center_pressed() -> void:
	print("Opening Control Center...")
	get_tree().change_scene_to_file("res://control_center.tscn")
