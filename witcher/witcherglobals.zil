<CONSTANT CATS-EYE-DURATION 15>
<CONSTANT DAY-LENGTH 30>
<CONSTANT FALSE <>>
<CONSTANT FOOD-ABUNDANCE 5>
<CONSTANT NONE <>>

<CONSTANT HP-NEKKER 100>
<CONSTANT HP-BANDITS 400>
<CONSTANT HP-GRIFFIN 1500>
<CONSTANT HP-ALGHOUL 700>
<CONSTANT HP-GHOULS 300>
<CONSTANT HP-BEAR 500>
<CONSTANT HP-JAENY 900>

<CONSTANT WITCHER-CONSUMPTION 1>
<CONSTANT WITCHER-HEALING-RATE 50>
<CONSTANT WITCHER-MEDITATE-CYCLE 15>
<CONSTANT WITCHER-OIL-DURATION 20>
<CONSTANT WITCHER-TRAVEL-TIME 5>
<CONSTANT WITCHER-HEALTH-THRESHOLD 200>
<CONSTANT WITCHER-CRITICAL-HIT 10>

<CONSTANT ATTACK-DESCRIPTIONS <LTABLE 2 "attack" "swing at" "hack at" "hit" "charge at" "rush at" "have a go at" "strike" "damage" "injure">>
<CONSTANT BOUNTY-FLAG <TABLE "ACCEPTED" "INVESTIGATED" "REPORTED" "COMPLETED">>
<CONSTANT EDGE-OF-THE-WORLD <LTABLE 2 "You have reaced the end of the known world." "You are getting nowhere." "You decided against moving in that direction." "There is nothing for you there.">>
<CONSTANT ROACH-RESPONSES <LTABLE 2 "clueless" "amused" "fascinated" "bored" "interested" "enthusiastic">>
<CONSTANT THING-DESCRIPTIONS <LTABLE 2 "nothing special" "nothing extraordinary" "something terribly mundane" "nothing noteworthy">>

<GLOBAL CURRENT-VEHICLE NONE>
<GLOBAL DAYTIME T>
<GLOBAL LAST-LOC NONE>
<GLOBAL RIDING-VEHICLE FALSE>

<GLOBAL WITCHER-FOOD 20>
<GLOBAL WITCHER-BOMBS 5>
<GLOBAL WITCHER-HEALTH 0>
<GLOBAL WITCHER-MAX-HEALTH 1000>
<GLOBAL WITCHER-ORENS 100>
<GLOBAL WITCHER-DODGE-PROBABILITY 30>
<GLOBAL WITCHER-CATS-EYE FALSE>

; Bounties
<CONSTANT NEST-REMAINS "[ruins of a monster's nest]">
<CONSTANT RUBBLE "nothing but rubble left">
<CONSTANT DEFAULT-GREETINGS "Greetings, Witcher!">

<CONSTANT WHITE-ORCHARD-CLUES <LTABLE WHITE-ORCHARD-BROKEN-WAGON WHITE-ORCHARD-CARCASS WHITE-ORCHARD-WARES WHITE-ORCHARD-FEATHERS>>
<CONSTANT WHITE-ORCHARD-INVESTIGATIONS <LTABLE FALSE FALSE FALSE FALSE>>
<CONSTANT WHITE-ORCHARD-CONCLUSION "... large, destructive and powerful claws, mutilations by beak-like jaws, and feathers. All signs point to a Griffin. You should report back to ">
<CONSTANT WHITE-ORCHARD-ALDERMAN-NEWS "The townsfolk are wary and fearful of travelling. People say that a large winged creature is stalking the cross roads. A merchant was recently attack and he barely escaped with his life. Help us Witcher! This beast has already claimed lots of victims.">
<CONSTANT WHITE-ORCHARD-ALDERMAN-REPORT "We have Griffin problem, huh?. Please deal with this menance then come back again for your reward, Witcher!">

<CONSTANT FARM-CLUES <LTABLE FARM-NEST>>
<CONSTANT FARM-INVESTIGATIONS <LTABLE FALSE>>
<CONSTANT FARM-CONCLUSION "... there was a nest of ghouls hidden in the farm. They emerge during the night and prowl about. I have destroyed the nest but the alghoul may return. You should report back to ">
<CONSTANT FARMER-NEWS "Scarecrows do not seem to scare off the monsters ravaging my farm. We cannot proceed with  the harvest. No one wants to go to the farm with those creatures running around!">
<CONSTANT FARMER-REPORT "Thank you for destroying the nest, Witcher. The Alghoul was not in the nest? Please kill this monster then come back for your reward, Witcher!">

<CONSTANT MISSING-HUSBAND-CLUES <LTABLE CORPSE-MISSING-HUSBAND>>
<CONSTANT MISSING-HUSBAND-INVESTIGATIONS <LTABLE FALSE>>
<CONSTANT MISSING-HUSBAND-CONCLUSION "... There is no doubt this is the missing husband. Unfortunately, there is nothing else that can be done. You already dealt with the bear. You should report back to ">
<CONSTANT MISSING-HUSBAND-NEWS "He was last seen heading into the bog. I fear something may have happened to him.||[She then tells you some other details, what the man looked like, and what clothes he was wearing,]">
<CONSTANT MISSING-HUSBAND-GREETINGS "Have you seen my husband?">
<CONSTANT MISSING-HUSBAND-REPORT "You found him Witcher. You have my thanks. Thank you for dealing with the beast that killed him. Now let me mourn in peace.">

<CONSTANT ABANDONED-VILLAGE-CLUES <LTABLE JAENY-DIARY>>
<CONSTANT ABANDONED-VILLAGE-INVESTIGATIONS <LTABLE FALSE>>
<CONSTANT ABANDONED-VILLAGE-CONCLUSION "Jaeny, who died from the attack has now become a wraith and is haunting the well. You should report back to ">
<CONSTANT ABANDONED-VILLAGE-NEWS "Jaeny, who was to be married suddenly disappeared. Now a wraith is haunting the well. Is Jaeny the one haunting the well? Please find out what happened to her, Witcher.">
<CONSTANT ABANDONED-VILLAGE-REPORT "Jaeny is now haunting the well?. Please bring peace to her soul, witcher. Afterwards, come back for your reward, Witcher!">

<CONSTANT QUEST-MONSTER 1>
<CONSTANT QUEST-SEARCH 2>

<CONSTANT QUEST-RECOVER 3>
<CONSTANT QUEST-ACCEPT <LTABLE "Splendid! You should investigate " "Thanks Witcher! Please carry on with your search." "Thanks Witcher! Please come back as soon as you find it.">>
<CONSTANT QUEST-INVESTIGATE <LTABLE "You should probably continue investigating " "You should probabably continue searching." "Have you found it yet?">>
<CONSTANT QUEST-REPORT <LTABLE "Please come back after you have dealt with " "..." "Have you found it yet?">>
<CONSTANT QUEST-COMPLETE <LTABLE "Thanks, witcher! We are safe again!" "Thanks for your help, Witcher." "Thank you for recovering ">>
