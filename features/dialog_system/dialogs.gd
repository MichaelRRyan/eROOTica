extends Node

const NEUT = 0
const GOOD = 1
const BAD = 2

# Relationship (0 - 1), Attraction (0 - 1), Dialog, [ Answer, type, follow up (optional) ] ...
var dialogs = {
	"Rose": [
		
	],
	"Bella & Donna": [
		[ 0.1, 0.5, "Bella: hello there\nDonna: Hello... My name is Donna\nBella: and I’m Bella. We’re sisters, and story tellers.\nDonna: It’s nice to see you again, farmer.", 
			[ "Have we met before? I don’t recognize you...", NEUT, "Bella: Hehe... you’re not the only one.\nDonna: a lot of people don’t know who we are... You could say we live in the shadows" ], 
			[ "You two look a bit creepy...", BAD, "Shade: That’s not very nice, you know, farmer...\nNight: Have your parents never taught you any manners? You shouldn’t be rude to a plant’s face like that." ], 
			[ "I like your aesthetic.", GOOD, "Night: why thank you, farmer...\nShade: Even with our purple flower, we’re still as pretty as ever!\nNight: I’d like to think that’s part of our charm." ]
		],
		[ 0.2, 0.5, "Night: Have you heard the tale of the girl in the nearby forest?\nShade: they say she went to pick berries for a delicious pie...\nNight: but she never returned from her trip. What do you think happened to her, farmer?", 
			[ "Maybe she found a wolf, who scarfed her down?", NEUT, "Shade: oooh, I like that idea!\nNight: well it’s not how the story goes...\nShade: I don’t mind that, a story can be changed, after all.\nNight: but not this story!" ], 
			[ "She might have picked the wrong kind of berry.", GOOD, "Night: that’s right! You're a smart one, aren’t you?\nShade: we like smart people like you, farmer. Maybe you could tell us a story next time?" ], 
			[ "I don’t really care much for fairy tales.", BAD, "Night: You’re no fun!\nShade: I don’t think he would like this particular story, anyways\nNight: yeah, you’re right." ]
		],
	],
	"Poppy": [
		
	],
	"Sunflower": [
		
	],
}
