extends Node

const NEUT = 0
const GOOD = 1
const BAD = 2

# Relationship (0 - 1), Attraction (0 - 1), Dialog, [ Answer, type, follow up (optional) ] ...
var dialogs = {
	"Rose": [
		[ 0.1, 0.5, "Hey there, cutie! My name is Rose... What are you doing around here? ", 
			[ "This is my garden, I'm taking care of it.", NEUT, "Oh, so you own all this land? That's kind of hot. Don't tell this to anyone, but I’m a bit of a material girl." ], 
			[ "Looking for beautiful flowers like you", GOOD, "Oh my! You flatter me, dearie. I could get used to this kind of treatment!" ], 
			[ "I don’t have time to talk to you, I have work to do", BAD, "Ugh, alright then. Run along, I’m sure you have more important stuff to do..." ]
		],
		[ 0.2, 0.5, "It’s been quite chilly lately, hasn’t? I’m feeling a bit cold... Oh, if only there was something I could do about it...  ", 
			[ "I could warm you up.", GOOD, "Oh, you’re such a gentleman! I know many ways to warm somebody up, if you know what I mean.." ], 
			[ "The weather forecast said it should get warmer soon", NEUT, "Huh? Oh, that’s nice, I suppose. Although I was hoping for a more immediate solution..." ], 
			[ "Damn, girl, I can’t control the weather!", BAD, "That’s not what I- ugh, just forget it. Guys these days, I swear- one dumber than the other..." ]
		],
		[ 0.3, 0.5, "I’ve met all these different roses in my past, but none of them really appreciated me! I’ve tried getting to know some of them, but it never led anywhere... I need someone to REALLY seal the deal.  ", 
			[ "Maybe you should stick with roses instead of trying to get on with an old gardener.", BAD, "I just told you- nevermind... I’m not looking to get together with any of them." ], 
			[ "So you’ve got a lot of experience with dates, huh?", NEUT, "Huh? Well, not exactly... No one has caught my attention yet, until recently..." ], 
			[ "Let me deflower you, baby", GOOD, "Ohohohoh! Now you’re speaking my language, baby! I’m sure we could come up with something fun..." ]
		],
		[ 0.4, 1, "Hello there, darling. You look like you’re worked up over something. Surely I’m not making you nervous, am I?   ", 
			[ "No, I’m just sweaty from gardening.", NEUT, "Oh, huh... that’s not very sexy, is it?" ], 
			[ "There’s so many beautiful flowers around here, I feel a bit flustered", BAD, "Excuse me? Flowers? As in, multiple? Alright, if that’s the way you want to play, go on ahead!" ], 
			[ "Your rose petals are just so romantic, they make me nervous", GOOD, "Ohoho, I had a hunch it might be because of me! What can I say, roses embody romance~" ]
		],
		[ 0.5, 1, "My darling, I’m feeling a bit down, all this growing is really tiring. I need someone to cheer me up...", 
			[ "Orange you glad to see me?", NEUT, "Huh? Oh, Ahaha... I suppose that one is a classic..." ], 
			[ "Don't be sad, Rose! You’re sexy and you grow it, girl!", GOOD, "You're right, I do know it! Thanks for the pick-me-up, I’ll be sure to pay it back to you." ], 
			[ "Everyday, i get so excited to see you, I wet my “plants”", BAD, "...Huh? Do you have lie, problems holding in your pee? Don't answer that actually, I don't want to know." ]
		],
		[ 0.6, 1, "My love, I cannot wait any longer, I want you to hold me. I want your sweet nectar. Please, let’s make some sweet memories together.", 
			[ "I will plant my seed in you, Rose", GOOD, "oh my GOD, YES! Let's make some memories we will never forget!" ], 
			[ "I would, my love, but I would get hurt by your thorns.", NEUT, "I - I would be careful! Please, you have to reconsider! I swear I’ll make it worth your while!" ], 
			[ "I’m actually seeing a different flower”", BAD, "Excuse me, WHAT?? I’ve been your side-chick pea this whole time? I can’t believe you... I’m either top choice or no choice!" ]
		],
		[ 0.4, 0, "Oh, it’s you... Why aren’t you with the other flowers? I’m sure you would rather spend time with them than with an ugly rose like me...", 
			[ "Don’t mess with me like this, you know you’re not ugly", NEUT, "But I am! I just feel so bad, none of the other roses never want- I mean, they were never good enough for me" ], 
			[ "See, this is why I don’t want to talk to you anymore.", BAD, "Fine! Then don’t! I don’t need a dusty old gardener like you anyways..." ], 
			[ "Rose, there’s no need to be so thorny. And you’re very pretty, by the way.", GOOD, "Ah, thank you. I just really doubt myself sometimes. But deep down, I know I’m really the prettiest rose in the world!" ]
		],
		[ 0.5, 0, "It’s you again... You don’t like me, so why do you keep talking to me? Honestly, it would just be better if you left me without any water.", 
			[ "Alright, will do!", BAD, "Huh? Excuse me? I didn't...Don't do that!" ], 
			[ "You’re talking nonsense again.", NEUT, "So what if I am? Am I not allowed to exaggerate  a little? It's not like you understand me anyways." ], 
			[ "I keep coming back because I like you, Rose! Even if you don’t see that.", GOOD, "I suppose that’s true... Alright, I forgive you gardener, I hope we can still get on well" ]
		],
		[ 0.6, 0, "Why are you here... We both know there’s nothing happening between us, and everyday you just come back here to rub it in my face! I should have just stuck to those stupid roses...", 
			[ "It's not like any of them rally loved you anyways...", BAD, "What??? How insulting! I’ve just about had it with you, gardener. I’m telling you, you will regret this!" ], 
			[ "Romance isn’t everything, you know...  ", NEUT, "it is to me! See, this is what I was talking about, you clearly don’t get me at all." ], 
			[ "Maybe we could start over again? I know we didn’t get off on the best foot... ", GOOD, "...alright... If you really mean it, the sure. I could give you another chance. No harm in trying, I suppose..." ]
		],
		#[0.9, 1, "Hi Honey, I’m feeling kind of thirsty... but not in the fun way, I mean it in the “I’m dying” kind of way.  What’s that? You don’t have any more water? Hmmm.. You know... Some fertilizer would do me good as well. You do know how compost is made, right? Maybe you could... make some? There's plenty of... “material” in your garden, after all... "
		#],
		#[0.9, 0, "Oh gardener! I need some water. Or Fertilizer. I’m wilting all over! Oh my, I’m getting uglier by the minute. I need it! I know you hate me, but you wouldn’t leave me to die, right?" ],
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
		[ 0.3, 0.5, "Night: it can get a bit lonely out here, we’re not exactly popular with the other flowers... \nShade: You might even say we’re scaring them away \nNight: but that’s not our fault! This is just the way we are...", 
			[ "I would be gladly keep you company instead", GOOD, "Shade: and we would gladly have you! \nNight: Shade, control yourself a little... \nShade: sorry, I just got exited over making a new friend..." ], 
			[ "You have each other, don’t you?", NEUT, "Night: I suppose that is true, Yes... \nShade: but there isn’t much to talk about between twins, you see? \nNight: But it is true that we have each other’s backs. \nShade: literally!" ], 
			[ "I think I understand why you’re freaking them out.", BAD, "Night: do we freak you out too? \nShade: well that’s too bad, isn’t it? We can get much, much creepier if we want to... \nNight: maybe we should show you, so you will appreciate us for how we are normally..." ]
		],
		[ 0.4, 1, "Shade: it’s a shame we don’t have our berries anymore... \nNight: you should have seen them, farmer! I’m sure they would have charmed you. They were both very big, and... voluptuous.", 
			[ "I bet they were very juicy. I’d love to see them once they grow back.", GOOD, "Shade: Oh my! You're such a flatterer, you know that, farmer? \nNight: It might take a while, but we would be happy to show you once they’re ready. \nShade: maybe you could even have a taste.. Hehe~" ], 
			[ "Whose berry was bigger?", BAD, "Shade: That would be me... \nNight: What? No way! Mine was bigger! \nShade: Well mine got picked first! \nNight: that doesn’t matter! Wait a second... farmer... are you trying to sow the seed of doubt between us? \nShade: oh, are you now? Good luck with that, you can’t separate sister." ], 
			[ "I’m more of a leaf guy myself", NEUT, "Shade: Oh, we don’t exactly have many leaves... \nNight: we have our petals, if that’s more your style?" ]
		],
		[ 0.5, 1, "Night: Oh, our dearest farmer... there you are again! \nShade: I think Night wants to say she’s glad to see you. And so am I! \nNight: Would you tell us a story? Oh, I hope it's be a good one!", 
			[ "How about a story of two lone mushrooms feeding on a rotten tree trunk?", NEUT, "Shade: hehe, that kind of reminds me of us, Night! \nNight: It sounds very familiar, but I’ve never heard it \nShade: me neither, tell us all about if, farmer!" ], 
			[ "How about one about a cute kittens in sweaters?", BAD, "Shade: oh no no no... we don’t do these kinds of stories... \nNight: cuteness is overrated, farmer. And way too simple. Where’s the metaphors? The deeper thought?" ], 
			[ "I know one about an old oak tree filled with regret.", GOOD, "Shade: I think I’ve heard of this one! The oak had a beloved birch tree. One of the was struck by lightning, the other one by grief... It’s a deep story. \nNight: Ah, I see, it’s this one... I bet you’re quite familiar with it, aren’t you?" ]
		],
		[ 0.6, 1, "Shade: hello there farmer! Night: we have been thinking of writing another story. \nShade: but we need some inspiration... We were thinking of writing a romance novel \nNight: but we’ve never been in any kind of romance before... Maybe we could change that..? ", 
			[ "I’ve always wanted to take it further with you two – let's write our story together!", GOOD, "Shade: oh my! Yes! Yes! We would be so happy to work with you!  \nNight: I cannot believe this is actually happening! We promise, we will be yours forever, farmer!" ], 
			[ "why not stick to your ‘dark mysterious’ thing?", NEUT, "Night: well... it gets kind of boring after a time, doesn’t it? \nShade: I think so too... \nNight: well, if that’s what you think, farmer, then we suppose we should." ], 
			[ "I’m more of a comedy kinda guy.", BAD, "Night: Huh? After all this time...? \nShade: how could you say something like that? I thought you understood us..." ]
		],		
		[ 0.4, 0, "Shade: Ooooh farmer~  have you seen the flock of ravens in the sky? \nNight: I’ve seen them all bickering, fighting, competing for all the seeds they found... \nShade: It was quite violent, I’ve heard a bunch of ravens were falling out of the sky! \nNight: I even heard of one which fell right into our garden! Have you heard of this Raven, farmer? ", 
			[ "There’s no raven in here...", NEUT, "Night: Oh, farmer, you’re not very good with metaphors, are you?" ], 
			[ "I think I know what you’re talking about", GOOD, "Shade: would you look at that, maybe he’s got something in that near-empty skull after all..." ], 
			[ "Stop that, you have idea what really happened!", BAD, "Night: someone afraid of the truth, wouldn’t you say? Shade: I think so too... well, at some point, you can’t run away from it anymore..." ]
		],
		[ 0.5, 0, "Night: time for another story! Shade: I have one, it’s about a family of canaries, broken apart by a big Eagle!  Night: The mommy canary was left alone to take care of her fledgling. But little does she know, the Eagle is still around, and she is dependent on him to survive... Shade: I wonder, what would she do if she knew the truth? ", 
			[ "Your stories are very creepy... ", NEUT, "Night: that’s the charm of them, farmer. \nShade: some stories need to be heard, whether you like them or not." ], 
			[ "I didn’t kill the canary!  You’re both out of your mind!", BAD, "Night: but who ever said that you were the Eagle, farmer? \nShade: I think there’s more to the Eagle than meets the eye..." ], 
			[ "Is there any redemption for the Eagle?", GOOD, "Night: Maybe. Maybe not. I think the canary could never forgive him, but there’s always other ways to change for the better... " ]
		],
		[ 0.5, 0, "Night: time for another story! Shade: I have one, it’s about a family of canaries, broken apart by a big Eagle!  Night: The mommy canary was left alone to take care of her fledgling. But little does she know, the Eagle is still around, and she is dependent on him to survive... Shade: I wonder, what would she do if she knew the truth? ", 
			[ "Your stories are very creepy... ", NEUT, "Night: that’s the charm of them, farmer. \nShade: some stories need to be heard, whether you like them or not." ], 
			[ "I didn’t kill the canary!  You’re both out of your mind!", BAD, "Night: but who ever said that you were the Eagle, farmer? \nShade: I think there’s more to the Eagle than meets the eye..." ], 
			[ "Is there any redemption for the Eagle?", GOOD, "Night: Maybe. Maybe not. I think the canary could never forgive him, but there’s always other ways to change for the better... " ]
		],
		[ 0.5, 0, "Shade: Story time! Story time! \nNight: This one’s from our special collection. A parakeet kept in a cage, to contain its beauty. \nShade: nobody cared that it was lonely, because its sorrow brought the most beautiful songs. \nNight: Those songs soothed the mind of someone in their final moments. That’s kind of beautiful, don’t you think? ", 
			[ "How do you know this? Where did you get this from!? ", BAD, "Shade: A little birdie told us! \nNight: we’re very good listeners, farmer... Now tell us, did she really deserve to die in that room?" ], 
			[ "It wasn’t fair to the parakeet, and I see that now... ", GOOD, "Night: That is the truth. But you can’t turn back time \nShade: At least the parakeet is in a better place now... too bad she didn't make it... both of them wilted that day..." ], 
			[ "Ì don’t really understand these stories of yours...", NEUT, "Shade: There’s no need to play dumb, farmer. \nNight: maybe he’s not pretending. Our metaphors are very sophisticated, after all..." ]
		],
		[ 0.6, 0, "time for a very special story, farmer... \nNight: there once was a fair queen, who had herself a handsome king. \nShade: One night, her subject have their gifts to the beloved queen. \nNight: But it didn't go well, for one of them was an assassin. The assassin mistakenly gave the queen a fruit meant for one of her targets. \nShade: the queen bit into it, and immediately fell very ill!   \nNight: the kingdom grieved her loss, but most of all, the king was stricken by despair... \nShade: How will you continue the story, my liege? ", 
			[ "Stop that! No more stories! How dare you two kill the queen! ", BAD, "Night: you should watch your tongue, my liege... \nShade: or else you’ll join your queen! Night: and we wouldn’t want that, now would we?" ], 
			[ "Why did the queen die!? ... why did the assassin not tell her about the apple? ", NEUT, "Night: Remember the story! The assassin didn’t mean to kill the queen. There was no one who paid for her death. \nShade: it was an accident... we didn’t... I mean, the assassin didn’t... \nNight: that’s enough, Shade." ], 
			[ "The king has to lead its people, no matter what...  I must try my best...", GOOD, "Night: that’s a good way to look at it. Your subject still depend on you, after all... \nShade: just try not to kill everyone, alright?" ]
		],
		#[ 0.9, 1, "Night: oh, farmer, something terrible is happening! \nShade: we’re dying! Please, we’re withering! Wilting! Drying up and crumbling away! \nNight: please, farmer, we need some sustenance...  ", 
		#	],
		#[ 0.9, 0, "Night: you don’t like our stories much, do you?  \nShade: do you want us to take our secrets to our grave? That's quite harsh, isn’t it? \nNight: It’s your decision, farmer, But remember: killing us won’t erase your sins.  ", 
		#	],	
	],
	"Poppy": [
		[ 0.1, 0.5, "Poppy: Hello there! \nBobby: hello, Mister!  \nPoppy: you seems like you’re this garden’s gardener. Why don’t you tell us more about yourself? Let’s see... oh!  I know! What do you enjoy the most while gardening?", 
			[ "Taking care of flowers like you. ", GOOD, "Poppy: Oh, I suppose that makes sense. I’m glad to have someone take care of us like this." ], 
			[ "Mowing the lawn is pretty relaxing. ", BAD, "...The lawn, you say? \nBobby: I don’t like the lawnmower, it’s... scary... \nPoppy: I know Bobby, I don’t like it either..." ], 
			[ "Decorating, deciding which flower would look the best in which place.", NEUT, "Poppy: That’s nice! I can tell you enjoy it." ]
		],
		
		[ 0.2, 0.5, "I wish I could be young again, sometimes. Carefree, not having any responsibilities, just like a little kid again. ", 
			[ "Yeah, being old sucks, I  would know...", NEUT, "Poppy: It does... And worst of all, there’s no way out. I guess I shouldn’t think about it too hard.. " ], 
			[ "No one can turn back time, that’s the harsh truth. ", BAD, "Poppy that’s true... Ah, I just... I guess not everything is just sunshine and rainbows... don’t tell Bobby I said that." ], 
			[ "How about we all play a game, just like when we were kids?", GOOD, "Bobby: are we gonna play? Oooh, I know a game all of us can play together! Come on, I’ll explain the rules to you! \nPoppy: Alright, alright... let’s go play" ]
		],
		
		[ 0.3, 0.5, " Bobby: Mommy? Where do seeds come from? \nPoppy: oh, I’ll tell you when you’re older, bobby. \nBobby: but I wanna know now! \nPoppy: oh dear... I’m not really prepared for a “birds and the bees” talk, could you help me out farmer? ", 
			[ "You see Bobby, when a bee lands on a daddy flower... ", GOOD, "Bobby: Oh! So that’s how it all works! I knew all these bugs around were great, but I didn’t know they brought children too! Hehe!" ], 
			[ "All the little seeds are carried here by a stork – he poops them out! ", NEUT, "(Bobby: Hahahaha! That’s silly! I got pooped out by a bird? \nPoppy: I don’t think that’s quite how it works, but... it’s close enough, I guess." ], 
			[ "Your mother had sex, Bobby.", BAD, "Poppy: What are you talking about!? You can’t just say that, he’s too young! \nBobby: What is sex, mommy? Poppy: I’ll tell you when you’re older! " ]
		],
		
		[ 0.4, 1, " Bobby: I wanna play! Mr. Gardener, would you like to play with me? I’ll teach you a game my daddy taught me!", 
			[ "Of course I'd love to play! ", GOOD, "Bobby: Yay! Alright, here’s what daddy taught me! You have to lie on the ground, and cover yourself with as many fallen leaves as you can manage! It’s called “the hiding game”! I used to play it with him all the time!" ], 
			[ "Your father? Where is he now? ", BAD, "Bobby: Oh, Ummm... he isn’t around anymore... My mommy said he went far away, but she wouldn’t say where..." ], 
			[ "Sorry kiddo, I don't have time right now.", NEUT, "Oh, that’s alright... maybe we can play later?" ]
		],
		[ 0.5, 1, " Oh hello there farmer! I’ve been waiting for you. I've been really tired lately, Bobby couldn’t sleep well last night... I've just had a lot on my plate recently.", 
			[ "I can play with Bobby for a bit if you need a break ", GOOD, "Poppy: Oh, that would be wonderful! Thank you, gardener. \nBobby: Oh, do you wanna play a game, Mr. Gardener? Okay! Let's go!" ], 
			[ "I'm sorry to hear that. ", NEUT, "Poppy: It’s not even that hard to raise a kid, but the thing is, you get no breaks. That's whatwears you down." ], 
			[ "Too bad you’re alone in this parenting thing, huh?", BAD, "Poppy: Y-yeah... Too bad for me, I guess..." ]
		],
		[ 0.6, 1, " You know, farmer, I’ve been a bit lonely lately. I’m on my own with Bobby, But it doesn’t have to stay that way, if you know what I’m saying... ", 
			[ "I’d be happy to join you and Bobby ", GOOD, "Poppy: That’s wonderful! I’m sure Bobby is happy to hear that, too! Bobby, the gardener is going to stay with us. We're going to be a family of three again! \nBobby: Yay! Um... Is It alright if I still call you Mr. Gardener? " ], 
			[ "I don’t think I could stand living with Bobby, sorry. ", BAD, "Poppy: Huh? But... I thought you loved kids! I guess I was wrong... sorry about that." ], 
			[ "I think I know what you mean, but I need more time.", NEUT, "Poppy: that’s alright with me! I know it’s a big commitment, so no pressure!" ]
		],
		[ 0.4, 0, "Poppy: oh, Hello, gardener. \nBobby: *sniff* waaaahhhh... \nPoppy:what’s wrong, bobby? \nBobby: I’m scared... I don’t like Mr. gardener.  ", 
			[ "Don’t be scared, Bobby, I’m the one who’s taking care of you ", GOOD, " Poppy: he’s right, Bobby. Don't forget he waters us every day, alright? \nBobby: I guess that’s true.. " ], 
			[ "Maybe we could play a little game? ", NEUT, "Bobby: I don’t feel like playing any games today... *sniff*" ], 
			[ "Good. Cry me a river, Bobby", BAD, "Bobby: WAAAAAAAHHHH... \nPoppy: what is wrong with you? Oh, come on, Bobby, shhh... I’m here.." ]
		],
		[ 0.5, 0, "Poppy: Oh, it's the gardener. Say hello, Bobby. \nBobby:... \nPoppy: come on bobby, say hi to the gardener for me. \nBobby: NO! I HATE MR. GARDENER! GO AWAY! \nPoppy: Bobby! Calm down!  ", 
			[ "I’m sorry you don’t like me, Bobby, could you tell me why? ", GOOD, " Bobby: you make mommy sad! And I like my mommy. Please be nicer to her, Mr. Gardener. \nPoppy: Oh...Gardener... well... Bobby is right" ], 
			[ "I’ve always hated little brats like you ", BAD, "Bobby: WAAAAAAHHHHHHH.... WAHHHH.." ], 
			[ "I’ll leave you alone if you’re in a bad mood right now", NEUT, "Bobby: that’s right! Go away! And be nicer to us next time!" ]
		],
		
		[ 0.6, 0, "Poppy: Hello, gardener, Bobby just fell asleep...I know yout two don't get along too well, so... maybe we could finally have a talk. I don't really like you, gardener, because... you keep bringing up past wounds. ", 
			[ "I’m sorry if I made you uncomfortable. I also lost a loved one recently, I guess I've been fixated on that... ", GOOD, " Poppy: Oh... I see... i'm sorry for your loss... but please don't bring up my husband, it's still painful for me." ], 
			[ "I think you should move on, you have Bobby to live for now. ", NEUT, "Poppy: I suppose that’s true, but it gets tough with him sometimes... no, You’re right, I should focus on him, for now." ], 
			[ "That's because I'm the one who killed your husband.", BAD, "Poppy: … You... What!??? You’re the one who was mowing the lawn? Oh my god.... It all makes sense.... YOU MURDERER! \nBobby: mommy, what’s going on? \nPoppy: oh, nothing sweety... Gardener, leave us alone. Now.)" ]
		],
		
		
		#[ 0.9, 1, "Gardener, could you please give us some water? Little Bobby isn’t doing well, and I’m not much better either...  ", ],
		#[ 0.9, 0, "You monster, you’re starving us out, aren’t you? I can’t believe we’re all going to end up like... nevermind that. I’m begging you, please give us something, for Bobby’s sake. ", ],
		
	],
	"Sunflower": [
		[ 0.1, 0.5, "Hiya there! Nice to meet you! My name is Sunflower, but you can call me Sunny. How are you doing on this sunny day? Hehe~  ", 
			[ " I’m alright. I’m just glad to get back to gardening after a long time. ", NEUT, "Oh, are you returning to your old hobby again? I think that’s neat! I hope you’ll take good care of us!" ], 
			[ "I’m doing great! You're looking quite lovely today, by the way. ", GOOD, "Aw thank you! You're not looking half bad either, if I do say so myself! I hope to see you around later!" ], 
			[ "You look just like a sunflower I saw by the side of the road.", BAD, "Huh? Oh, you must be mistaken... I'm prety sure that was a different sunflower..." ]
		],
		[ 0.2, 0.5, "It’s great to see all these different flowers around. I’ve never seen some of them before! Like, have you seen Night and Shade? They seem so dark, and mysterious... I think they’re like poets, or something? Anyways, I’d like to hear some of their stories sometime.", 
			[ "I don’t think there’s anything special about them, just another melodramatic weirdo. ", BAD, "Now hold on, don’t be so judgmental! Everyone has something a little special about them. Everyone’s got their story, and I wanna hear theirs!" ], 
			[ "They’re a complete polar opposite to you, what makes you want to meet them? ", NEUT, "I think it’s important to broaden your horizons, don’tcha think? You can’t be stuck in a group of plants that are exactly like you, silly!" ], 
			[ "I kind of like their metaphors, even if it’s not my usual style.",GOOD, "That’s the spirit! Maybe we could go and listen to them together!" ]
		],
		[ 0.3, 0.5, "Hiya, gardener! I’m kind of curious about you. I feel like we should get to know each other more. How about you tell me where you’re from and I’ll tell you something about myself! ", 
			[ "I grew up on a farm, actually. We used to have fields full of sunflowers like you.", BAD, "Huh? I actually grew up in one of those fields... Was your farm somewhere near here? You know what, don’t answer that. I don’t want to know..." ], 
			[ "I’ve lived in this house almost all my life ", GOOD, "So you’re really a gardener by heart, huh? That's nice! I'm from the countryside too, and... well, let’s just say I'm glad to be here now, instead!" ], 
			[ "I used to be a city slicker. ",NEUT, "Oh, I can’t even imagine what that sort of life would be like! I’ve never been to the city, so I think it would all seem so foreign to me. I gre up in the countryside, y'see?" ]
		],
		[ 0.4, 1, "Hiya there, farmer! I’ve been feeling really grateful for being in this garden, ya know? It’s not too crowded here, plenty of sun and water... I guess what I’m trying to say is, Thank you for planting me here! Ehe~ ", 
			[ "I’m glad I planted you here as well, you really brighten up the whole garden! ", GOOD, "Aww, gee, thank you! I try my best to have a positive outlook on life, ya know? There's always something good to look forward to, and even after a gloomy day, another one that’s full of sun will come!" ], 
			[ "Aren’t you a bit lonely here, though? ", NEUT, "Huh? Not at all! I have you, after all, and it’s nice to have some time for myself during the day. I’m used to having to deal with people all day, but right now, it’s pretty tranquil here, so I can’t really complain." ], 
			[ "Don’t you miss your friends and family from back home? ",BAD, " ...Well... how do I put this...um, I  don’t really want to talk about my home right now... Sorry" ]
		],
		[ 0.5, 1, "Hiya there, gardener! How's your garden doing today? I hope there aren’t any pests that are giving you trouble. Would you like to cloud gaze with me? There's I can see a few over there... do any of them remind you of something?", 
			[ "That one looks just like you, Sunny! Look at those petals, and that wonderful smile!", GOOD, "Oh my gosh, you’re such a charming one... I think it kind of looks like you actually, I think that’s more like your straw hat rather than my petals! Oh, and that big smile too, of course!" ], 
			[ "I think that cloud looks like a cute puppy with floppy ears! ", NEUT, "Oh my gosh, you’re so right! It does look like that! I remember a puppy I saw once, except that one had pointy ears instead." ], 
			[ "That big one looks like a combine harvester to me.  ",BAD, " Huh..? O-oh, yeah, you’re right... it looks like a harvester, driving around the field... reaping the harvest of... uh, sorry, I suddenly don’t feel like cloud gazing anymore... " ]
		],
		[ 0.6, 1, "Hiya there, gardener! I- I actually wanted to tell you something today... You see.. I think I have a little crush on you! Now, I understand if you don’t share these feelings, but I don’t think I can keep them all in anymore! So... I guess what I’m asking is... do... you like me too?", 
			[ "Sunny! Of course I love you back!", GOOD, "That’s- that’s amazing! Oh my gosh, I wasn’t expecting you to actually like me back, I’m so happy!" ], 
			[ "This is a lot to take in, I’m not sure... could you give me some time to think? ", NEUT, "O-Oh! Of course! You can tell me later, that’s alright! Tell me when you make up your mind!" ], 
			[ "Oh, I’m sorry Sunny, but I can’t say I feel the same...  ",BAD, " Oh... I see... well, I’m hoping we could at least stay friends, if that’s alright with you... " ]
		],
		[ 0.4, 0, " Oh, hiya gardener!...um... sorry, I’m not really feeling too great right now... I’m kind of stuck in thought, you know how it is... sorry I’m not as cheerful as always...", 
			[ "That’s alright! You don’t have to push yourself, and you can talk to me about it, if you want!", GOOD, "Oh... thank you, gardener... I know sunflowers are known for being cheerful all the time, but it’s hard to live up to that every day, ya know?" ], 
			[ "No worries Sunny, I’ll talk to you when you’re feeling better. ", NEUT, "Oh, I see... I- I'll see you later, then..." ], 
			[ "Why be sad when you can just be happy instead? Cheer up, Sunny!  ",BAD, " Huh? I- I'm not sure if it's that simple... but I’ll try it. For you, gardener" ]
		],
		[ 0.5, 0, " Oh, it’s you, gardener... Isn’t it a lovely day today? Gosh, I’m so sorry, I really can’t do this right now... I can’t make myself be happy, no matter how hard I try... will you please forgive me?", 
			[ "Please, don’t be so hard on yourself! I don’t care whether you’re happy or not, we’ll get through this together, ok?", GOOD, "...Thank you... Gardener... I really value your words. Sorry for being gloomy. I’ll try and rest up for tomorrow, I haven’t slept well last night..." ], 
			[ "You don’t have to apologize for anything, It just is what it is", NEUT, "I... I guess you’re right. Sometimes I’m just sad, and that’s the end of it. Thank you" ], 
			[ " I should have gotten a different sunflower... one that’s not gloomy like you.  ",BAD, " What? No! I’m sorry, I swear I’ll be happier tomorrow, I just need to rest up until then, promise! Just give me time until then!" ]
		],
		[ 0.6, 0, " I can’t do this anymore gardener, I just can’t... I couldn’t be a happy sunflower back in my home field, and can’t be happy here either... I think I just can’t get over all the horrors I saw there... all the harvesters... I was only lucky because I was at the side of the field... sorry, I’m rambling, Aren’t I? I’ll just stop now...", 
			[ "It’s alright if you need to speak your mind. I’m always here to lend an ear.", GOOD, "...Thank you, gardener. I appreciate that, really." ], 
			[ "Whoa, that sounds like a lot. Maybe you should try to move on?", NEUT, "I’ve been trying to do that, but I just can’t! It’s not always that simple, you know..." ], 
			[ "You know, Sunny, I wasn’t always just a Gardener. I used to work on a farm. And we grew sunflowers every year. ",BAD, " Wait... what? What do you mean? Are you saying... you... You’re the farmer? You planted me in that field? You're the one who made me grow up in that gos-aswful place, and now you're just teasing me about it!? I hate YOU! YOU. MAKE. ME. SICK!" ]
		],
	#[ 0.9, 1, "Hiya, gardener! Ya know, I’m not in the best shape right now, Could ya be a dear and get me some water? Maybe some fertilizer too, if you have some... I’d be grateful for anything! ", ],	
	#[ 0.9, 0, "Hi... gardener... I’ve been feeling really unwell, in more ways than one... could you spare something, anything, for me? I don’t think I can hold out for much longer... ", ],	
	],
}
