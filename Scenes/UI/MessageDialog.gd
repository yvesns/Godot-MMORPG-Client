extends AcceptDialog

func _ready():
	Network.connect_registration_success_signal(self, "_on_registration_result")
	Network.connect_registration_failure_signal(self, "_on_registration_result")
	
func _on_registration_result(message):
	window_title = "Registration"
	dialog_text = message
	show()