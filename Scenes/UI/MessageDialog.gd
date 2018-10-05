extends HBoxContainer

func _ready():
	Network.connect_registration_success_signal(self, "_on_registration_result")
	Network.connect_registration_failure_signal(self, "_on_registration_result")
	
func _on_registration_result(message):
	find_node("Label").text = message
	show()

func _on_Button_button_up():
	hide()