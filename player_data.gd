extends Node

# Stores the node names of earned badges globally across scene changes
var earned_badges: Array[String] = []

func unlock_badge(badge_name: String) -> void:
	if not earned_badges.has(badge_name):
		earned_badges.append(badge_name)
		print("Badge unlocked: ", badge_name)
