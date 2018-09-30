extends Node

const SERVER_IP = "127.0.0.1"
const SERVER_PORT = 9292
const SERVER_ID = 1

var peer
var self_info
var self_instance
var id
var login_security_token

func _ready():
	get_tree().connect("connected_to_server", self, "_connection_success")
	get_tree().connect("connection_failed", self, "_connection_failure")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	
func connect_to_server(user, password):
	peer = NetworkedMultiplayerENet.new()
	peer.create_client(SERVER_IP, SERVER_PORT)
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer", peer)
	
func _connection_success():
	print("Connected to server")
	
func _connection_failure():
	print("Connection failed")
	
func _player_connected(id):
	print("A player has connected")
	
func register(user, password, email):
	return rpc_id(SERVER_ID, "register", user, password, email)
	
remote func network_init(security_token):
	login_security_token = security_token
	id = get_tree().get_network_unique_id()
	
	#Load map
	#Initialize self on map
	
	#var map = "res://Scenes/Maps/" + player_info.map + ".tscn"
	#self_info = player_info
	#self_instance = preload("res://Scenes/Creatures/Player/Slayer/Sworder.tscn").instance()
	#self_instance.hide()
	#self_instance.z_index += 1
	
	#get_tree().change_scene(map)
	#get_tree().get_root().add_child(self_instance)
	
	#self_instance.position = self_info.position
	#self_instance.show()
	
func login(user, password):
	if id > 1:
		rpc_id(SERVER_ID, "login", id, user, password.hash(), security_token)
	
remote func login_success(user_characters):
	#Build character selection screen
	pass