extends HBoxContainer

#The dialog box should be implemented as a modal dialog, but
#for some reason the "exclusive" property is not working for
#blocking inputs until the dialog is closed.

func _ready():
	Network.connect_login_failure_signal(self, "_on_login_failure")
	Network.connect_registration_success_signal(self, "_on_registration_result")
	Network.connect_registration_failure_signal(self, "_on_registration_result")

func _on_login_failure():
	find_node("Label").text = "Invalid username or password"
	show()
	
func _on_registration_result(message):
	find_node("Label").text = message
	show()

func _on_Button_button_up():
	hide()
