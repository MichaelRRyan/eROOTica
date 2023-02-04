extends Node

const NEUT = 0
const GOOD = 1
const BAD = 2

# Relationship (0 - 1), Attraction (0 - 1), Dialog, [ Answer, type ] ...
var dialogs = [
	[ 0, 0.5, "Hi there", [ "Hey, sexy ;)", BAD ], [ "Hello, how are you?", GOOD ], [ "Fuck off", BAD ] ],
]
