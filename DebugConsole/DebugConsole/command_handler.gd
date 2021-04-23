extends Node


enum {
	ARG_INT,
	ARG_STRING,
	ARG_BOOL,
	ARG_FLOAT
}

const valid_commands = [
	["echo", [ARG_STRING]]
]

func echo(string):
	return string
