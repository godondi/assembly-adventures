extends Node2D

@onready var text_label: RichTextLabel = $CanvasLayer/RichTextLabel
@onready var background: ColorRect = $CanvasLayer/ColorRect

# Define the storyline with custom durations and formatting types
var story: Array [Dictionary] = [
	{"text": "[center][font_size=32][b]Assembly Adventures:\nThe Lost Instructions[/b][/font_size][/center]", "duration": 4.0, "type": "flicker"},
	{"text": "[center][i]The screen flickers to life.[/i][/center]", "duration": 2.5, "type": "flicker"},
	{"text": "[center][i]A warning pulses across the terminal.[/i][/center]", "duration": 2.5, "type": "fade"},
	{"text": "[center][color=red][b]SYSTEM ALERT:\nCRITICAL MEMORY CORRUPTION DETECTED[/b][/color][/center]", "duration": 4.0, "type": "pulse"},
	{"text": "[center]Deep inside the processor, something has gone wrong.[/center]", "duration": 3.0, "type": "fade"},
	{"text": "[center]The world of Assembly—the very instructions that power everything—are disappearing.[/center]", "duration": 4.5, "type": "fade"},
	{"text": "[center]Opcodes are vanishing. The stack is collapsing. Pipelines are breaking.[/center]", "duration": 4.5, "type": "fade"},
	{"text": "[center]And at the center of it all… is the [color=purple][b]Chip Chomper[/b][/color].[/center]", "duration": 4.0, "type": "fade"},
	{"text": "[center]A rogue program.[/center]", "duration": 2.0, "type": "fade"},
	{"text": "[center]A glitch turned monster.[/center]", "duration": 2.0, "type": "fade"},
	{"text": "[center]A devourer of logic.[/center]", "duration": 2.5, "type": "fade"},
	{"text": "[center]It feeds on mistakes, corrupts memory, and erases knowledge—one instruction at a time.[/center]", "duration": 5.0, "type": "fade"},
	{"text": "[center]Every student who has entered this system has tried to stop it.[/center]", "duration": 4.0, "type": "fade"},
	{"text": "[center]Every one of them has failed.[/center]", "duration": 3.0, "type": "fade"},
	{"text": "[center][b]Until now.[/b][/center]", "duration": 3.0, "type": "flicker"},
	{"text": "[center]You wake up inside the system—standing on a glowing path of instructions, stretching endlessly ahead.[/center]", "duration": 5.0, "type": "fade"},
	{"text": "[center]Lines of [color=green]RISC-V code[/color] flash beneath your feet like a living road.[/center]", "duration": 4.5, "type": "fade"},
	{"text": "[center]A voice echoes through the system:\n[color=cyan]“If you’re seeing this… it means the system chose you.”[/color][/center]", "duration": 5.0, "type": "fade"},
	{"text": "[center]The Chip Chomper is close. You can hear it—glitching, growling, consuming everything behind you.[/center]", "duration": 5.0, "type": "fade"},
	{"text": "[center]“You are the chosen one.”[/center]", "duration": 3.0, "type": "fade"},
	{"text": "[center]Your mission is simple—but not easy:\n[b]Run.[/b][/center]", "duration": 3.5, "type": "fade"},
	{"text": "[center]Jump across broken instructions.[/center]", "duration": 2.5, "type": "fade"},
	{"text": "[center]Answer challenges to stabilize the system.[/center]", "duration": 3.0, "type": "fade"},
	{"text": "[center]Restore lost knowledge before it disappears forever.[/center]", "duration": 4.0, "type": "fade"},
	{"text": "[center]Each level you survive brings you closer to restoring the system:[/center]", "duration": 3.5, "type": "fade"},
	{"text": "[center]• Rebuild basic instructions\n• Decode opcodes\n• Repair pipelining failures[/center]", "duration": 4.5, "type": "fade"},
	{"text": "[center]• Stabilize the stack\n• Trace corrupted code\n• Rewrite what was lost[/center]", "duration": 4.5, "type": "fade"},
	{"text": "[center]But be careful.[/center]", "duration": 2.0, "type": "fade"},
	{"text": "[center]The Chip Chomper learns from your mistakes.[/center]", "duration": 3.0, "type": "fade"},
	{"text": "[center]Every wrong answer… it gets closer.[/center]", "duration": 3.0, "type": "fade"},
	{"text": "[center]Every hesitation… it speeds up.[/center]", "duration": 3.0, "type": "fade"},
	{"text": "[center]Collect badges. Prove your mastery. Restore the system.[/center]", "duration": 4.5, "type": "fade"},
	{"text": "[center]Or get caught—and watch everything you’ve learned be erased.[/center]", "duration": 4.5, "type": "fade"},
	{"text": "[center][i]The system flickers again.[/i][/center]", "duration": 2.5, "type": "flicker"},
	{"text": "[center][color=green][b]The path loads.[/b][/color][/center]", "duration": 2.5, "type": "fade"},
	{"text": "[center][color=red][b]The chase begins.[/b][/color][/center]", "duration": 3.0, "type": "pulse"},
	{"text": "[center][font_size=24][b]Press Start… if you’re ready to run.[/b][/font_size][/center]", "duration": 9999.0, "type": "blink"} # Keeps text on screen until input
]

var current_line: int = 0

func _ready() -> void:
	text_label.modulate.a = 0.0
	play_next_line()

func play_next_line() -> void:
	if current_line >= story.size():
		# Intro over, transition to the game menu or level
		return

	var line_data = story[current_line]
	text_label.text = line_data["text"]
	
	var tween = create_tween()
	
	match line_data["type"]:
		"fade":
			# Standard smooth transition
			tween.tween_property(text_label, "modulate:a", 1.0, 0.5)
			tween.tween_interval(line_data["duration"] - 1.0)
			tween.tween_property(text_label, "modulate:a", 0.0, 0.5)
			
		"flicker":
			# Terminal glitch simulation
			tween.tween_property(text_label, "modulate:a", 1.0, 0.05)
			tween.tween_interval(0.1)
			tween.tween_property(text_label, "modulate:a", 0.2, 0.05)
			tween.tween_interval(0.08)
			tween.tween_property(text_label, "modulate:a", 1.0, 0.05)
			tween.tween_interval(line_data["duration"] - 0.7)
			tween.tween_property(text_label, "modulate:a", 0.0, 0.4)
			
		"pulse":
			# Alarm system panic pulse
			tween.tween_property(text_label, "modulate:a", 1.0, 0.3)
			for i in range(int(line_data["duration"] - 1.0)):
				tween.tween_property(text_label, "modulate:a", 0.4, 0.5)
				tween.tween_property(text_label, "modulate:a", 1.0, 0.5)
			tween.tween_property(text_label, "modulate:a", 0.0, 0.5)
			
		"blink":
			# Infinite looping call to action
			text_label.modulate.a = 1.0
			var blink_tween = create_tween().set_loops()
			blink_tween.tween_property(text_label, "modulate:a", 0.0, 0.6)
			blink_tween.tween_property(text_label, "modulate:a", 1.0, 0.6)
			return # Break out so it doesn't auto-advance

	tween.finished.connect(_on_line_finished)

func _on_line_finished() -> void:
	current_line += 1
	play_next_line()

func _input(event: InputEvent) -> void:
	# Allows players to skip/fast-forward lines by pressing Space or Enter
	if event.is_action_pressed("ui_accept"):
		if current_line < story.size() - 1:
			current_line += 1
			play_next_line()
		else:
			# If they press accept on the final prompt, load the main game
			print("Start the game!")
			# get_tree().change_scene_to_file("res://Game.tscn")
