extends AcceptDialog

# TODO
# 1. Find a way to center the popup when showing it

func _ready():
	Network.connect_login_failure_signal(self, "_on_login_failure")
	Network.connect_registration_success_signal(self, "_on_registration_result")
	Network.connect_registration_failure_signal(self, "_on_registration_result")

func _on_login_failure():
	window_title = "Login"
	dialog_text = "Invalid username or password"
	popup_centered()
	
func _on_registration_result(message):
	window_title = "Register"
	dialog_text = message
	popup_centered()