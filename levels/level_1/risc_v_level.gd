extends Control

@onready var question_label: Label = $CanvasLayer/QuestionContainer/QuestionLabel
@onready var options_container: VBoxContainer = $CanvasLayer/QuestionContainer/OptionsContainer
@onready var feedback_label: Label = $CanvasLayer/QuestionContainer/FeedbackLabel

@onready var badge_popup: PanelContainer = $CanvasLayer/BadgePopup
@onready var continue_button: Button = $CanvasLayer/BadgePopup/PopupVBox/ContinueButton

# RISC-V Challenge Data
var question_text: String = "What does the following RISC-V instruction do?\n\n    addi x5, x6, 10"
var options: Array[String] = [
	"A) Adds the contents of x5 and x6, storing the result in 10",
	"B) Adds 10 to the value in x6 and stores the result in x5",
	"C) Multiplies x5 by 10 and stores it in x6",
	"D) Loads the memory address 10 into register x5"
]
var correct_option_index: int = 1 # Option B is correct

func _ready() -> void:
	badge_popup.hide()
	feedback_label.text = ""
	continue_button.pressed.connect(_on_continue_button_pressed)
	
	setup_question()

func setup_question() -> void:
	question_label.text = question_text
	
	var buttons = options_container.get_children()
	for i in range(buttons.size()):
		if buttons[i] is Button:
			var btn = buttons[i] as Button
			btn.text = options[i]
			# Connect each button with its respective index
			if not btn.pressed.is_connected(_on_option_selected):
				btn.pressed.connect(_on_option_selected.bind(i))

func _on_option_selected(selected_index: int) -> void:
	if selected_index == correct_option_index:
		feedback_label.text = "[CORRECT] Memory sector stabilized!"
		feedback_label.modulate = Color.GREEN
		
		# Disable buttons to prevent double-clicking
		for child in options_container.get_children():
			if child is Button:
				child.disabled = true
				
		show_badge_popup()
	else:
		feedback_label.text = "Incorrect opcode execution! The Chip Chomper advances..."
		feedback_label.modulate = Color.RED

func show_badge_popup() -> void:
	# Unlock the badge globally so Control Center remembers it!
	# Make sure "Badge1" matches the exact node name in BadgesContainer
	PlayerData.unlock_badge("badge_1") 
	
	badge_popup.scale = Vector2.ZERO
	badge_popup.pivot_offset = badge_popup.size / 2.0
	badge_popup.show()
	
	var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(badge_popup, "scale", Vector2.ONE, 0.4)
	
func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://control_center.tscn")
