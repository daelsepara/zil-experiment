<OBJECT-TEMPLATE QUEST =
    OBJECT
        (SYNONYM BOUNTY)
        (SIZE 0)
        (QUEST-REWARD 0)
        (QUEST-ACCEPTED FALSE)
        (QUEST-INVESTIGATED FALSE)
        (QUEST-REPORTED FALSE)
        (QUEST-COMPLETED FALSE)
        (QUEST-MONSTER NONE)
        (QUEST-LOC NONE)
        (QUEST-UNLOCKS NONE)
        (MONSTER-APPEARANCE APPEAR-ANY)
        (VALUE 0)
        (FLAGS TAKEBIT READBIT QUESTBIT)>

<QUEST BOUNTY-BANDITS-I
    (DESC "Bounty: Raid Bandit Camp")
    (ADJECTIVE BANDIT BANDITS)
    (TEXT "A group of bandits, looters, deserters and other unsavoury people.")
    (QUEST-MONSTER BANDITS)
    (QUEST-ACCEPTED T)
    (QUEST-INVESTIGATED T)
    (QUEST-REPORTED T)
    (QUEST-LOC BANDIT-CAMP-I)
    (QUEST-MONSTER BANDITS)
    (VALUE 100)>

<QUEST BOUNTY-WHITE-ORCHARD
    (IN WHITE-ORCHARD-BOUNTY-BOARD)
    (DESC "Bounty: Beast of White Orchard")
    (ADJECTIVE BEAST)
    (TEXT "A vicious beast is terrorizing the White Orchard area. Travelling in and out of town is forbidden. Merchants should comply. Look for the alderman at White Orchard for further information.")
    (QUEST-REWARD 1500)
    (QUEST-LOC CROSSROADS)
    (QUEST-MONSTER GRIFFIN)
    (VALUE 500)>

<QUEST BOUNTY-WHITE-ORCHARD-INFESTATION
    (IN WHITE-ORCHARD-BOUNTY-BOARD)
    (DESC "Bounty: Farm infestation")
    (ADJECTIVE FARM INFESTATION)
    (TEXT "A farmer near White Orchard is having an infestation problem. He cannot plant his crops nor harvest them until this is resolved. Look for the farmer north west of the town.")
    (QUEST-REWARD 800)
    (QUEST-LOC WHITE-ORCHARD-FARM)
    (QUEST-MONSTER ALGHOUL)
    (VALUE 100)>

<QUEST BOUNTY-CAVE-BEAR
    (DESC "Bounty: Cave bear")
    (ADJECTIVE CAVE BEAR)
    (TEXT "There is a beast lurking inside a cave in the swamp.")
    (QUEST-ACCEPTED T)
    (QUEST-INVESTIGATED T)
    (QUEST-REPORTED T)
    (QUEST-LOC CAVE-LAIR)
    (QUEST-MONSTER BEAR)
    (QUEST-UNLOCKS CAVE-III)
    (VALUE 50)>

<QUEST QUEST-MISSING-HUSBAND
    (IN WHITE-ORCHARD-BOUNTY-BOARD)
    (DESC "Quest: Find Missing Husband")
    (SYNONYM QUEST)
    (ADJECTIVE MISSING HUSBAND)
    (TEXT "||..................||Help!||Please help me find my husband.  Missing for several days now.||Will pay with coins.||--- Lara||..................")
    (QUEST-REWARD 500)
    (QUEST-LOC CAVE-III)
    (VALUE 200)>

<QUEST CONTRACT-GHOST-IN-THE-WELL
    (DESC "Contract: Ghost in the Well")
    (IN ABANDONED-VILLAGE-BOUNTY-BOARD)
    (SYNONYM CONTRACT)
    (ADJECTIVE GHOST WELL)
    (TEXT "A ghost is haunting the well in the village. Townsfolk are suffering without access to the water supply.")    
    (QUEST-REWARD 300)
    (QUEST-LOC ABANDONED-VILLAGE-WELL)
    (QUEST-MONSTER WRAITH-JAENY)
    (QUEST-UNLOCKS ABANDONED-VILLAGE-WELL-BOTTOM)
    (MONSTER-APPEARANCE APPEAR-NIGHT)
    (VALUE 200)>

<QUEST CONTRACT-MISSING-BRACELET
    (DESC "Quest: Missing bracelet")
    (IN ODOLAN)
    (SYNONYM CONTRACT)
    (ADJECTIVE MISSING BRACELET)
    (TEXT "Odolan is looking for a memento from her late fiancee.")    
    (QUEST-REWARD 100)
    (QUEST-LOC ABANDONED-VILLAGE-WELL-BOTTOM)
    (QUEST-ITEMS MISSING-BRACELET-ITEMS)
    (VALUE 50)>

<QUEST BOUNTY-WATER-HAG
    (DESC "Bounty: Water Hag")
    (SYNONYM BOUNTY)
    (ADJECTIVE WATER HAG)
    (QUEST-ACCEPTED T)
    (QUEST-INVESTIGATED T)
    (QUEST-REPORTED T)
    (QUEST-REWARD 0)
    (QUEST-LOC SWAMP-III)
    (QUEST-MONSTER WATER-HAG)
    (QUEST-UNLOCKS HAG-LAIR)
    (MONSTER-APPEARANCE APPEAR-NIGHT)
    (VALUE 100)>