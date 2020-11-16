extends Node

var SAVFILE = "user://save_file.sav"

var save_dict = {
	"high_score": 0
}

var password = "" 

func _ready():
	password = OS.get_unique_id()
	if password == "":
		password = "aihhiadiafioaodapodaojpdoj"
	load_data()

func save_data():
	var save_file = File.new()
	save_file.open_encrypted_with_pass(SAVFILE, File.WRITE, password)
	save_file.store_line(to_json(save_dict))
	save_file.close()
	load_data()

func load_data():
	var save_file = File.new()
	if not save_file.file_exists(SAVFILE):
		save_data()	
	save_file.open_encrypted_with_pass(SAVFILE, File.READ, password)
	save_dict = parse_json(save_file.get_line())
	save_file.close()
