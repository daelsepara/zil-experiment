<OBJECT-TEMPLATE BOUNTY =
    OBJECT
        (SYNONYM BOUNTY)
        (SIZE 0)
        (BOUNTY-REWARD 0)
        (BOUNTY-ACCEPTED FALSE)
        (BOUNTY-INVESTIGATED FALSE)
        (BOUNTY-REPORTED FALSE)
        (BOUNTY-COMPLETED FALSE)
        (BOUNTY-MONSTER NONE)
        (BOUNTY-LOC NONE)
        (BOUNTY-UNLOCKS NONE)
        (QUEST-TYPE 0)
        (VALUE 0)
        (FLAGS TAKEBIT READBIT BOUNTYBIT)>

<BOUNTY BOUNTY-BANDITS-I
    (DESC "Bounty: Raid Bandit Camp")
    (ADJECTIVE BANDIT BANDITS)
    (TEXT "A group of bandits, looters, deserters and other unsavoury people.")
    (BOUNTY-MONSTER BANDITS)
    (BOUNTY-ACCEPTED T)
    (BOUNTY-INVESTIGATED T)
    (BOUNTY-REPORTED T)
    (BOUNTY-LOC BANDIT-CAMP-I)
    (BOUNTY-MONSTER BANDITS)
    (QUEST-TYPE QUEST-MONSTER)
    (VALUE 100)>

<BOUNTY BOUNTY-WHITE-ORCHARD
    (IN WHITE-ORCHARD-BOUNTY-BOARD)
    (DESC "Bounty: Beast of White Orchard")
    (ADJECTIVE BEAST)
    (TEXT "A vicious beast is terrorizing the White Orchard area. Travelling in and out of town is forbidden. Merchants should comply. Look for the alderman at White Orchard for further information.")
    (BOUNTY-REWARD 1500)
    (BOUNTY-LOC CROSSROADS)
    (BOUNTY-MONSTER GRIFFIN)
    (QUEST-TYPE QUEST-MONSTER)
    (VALUE 500)>

<BOUNTY BOUNTY-WHITE-ORCHARD-INFESTATION
    (IN WHITE-ORCHARD-BOUNTY-BOARD)
    (DESC "Bounty: Farm infestation")
    (ADJECTIVE FARM INFESTATION)
    (TEXT "A farmer near White Orchard is having an infestation problem. He cannot plant his crops nor harvest them until this is resolved. Look for the farmer north west of the town.")
    (BOUNTY-REWARD 800)
    (BOUNTY-LOC WHITE-ORCHARD-FARM)
    (BOUNTY-MONSTER ALGHOUL)
    (QUEST-TYPE QUEST-MONSTER)
    (VALUE 100)>

<BOUNTY BOUNTY-CAVE-BEAR
    (DESC "Bounty: Cave bear")
    (ADJECTIVE CAVE BEAR)
    (TEXT "There is a beast lurking inside a cave in the swamp.")
    (BOUNTY-ACCEPTED T)
    (BOUNTY-INVESTIGATED T)
    (BOUNTY-REPORTED T)
    (BOUNTY-LOC CAVE-LAIR)
    (BOUNTY-MONSTER BEAR)
    (BOUNTY-UNLOCKS CAVE-III)
    (QUEST-TYPE QUEST-MONSTER)
    (VALUE 50)>

<BOUNTY QUEST-MISSING-HUSBAND
    (IN WHITE-ORCHARD-BOUNTY-BOARD)
    (DESC "Quest: Find Missing Husband")
    (SYNONYM QUEST HUSBAND)
    (ADJECTIVE MISSING)
    (TEXT "||..................||Help!||Please help me find my husband.  Missing for several days now.||Will pay with coins.||--- Lara||..................")
    (BOUNTY-REWARD 500)
    (BOUNTY-LOC CAVE-III)
    (BOUNTY-MONSTER NONE)
    (QUEST-TYPE QUEST-SEARCH)
    (VALUE 200)>

<BOUNTY CONTRACT-GHOST-IN-THE-WELL
    (DESC "Contract: Ghost in the Well")
    (SYNONYM CONTRACT)
    (ADJECTIVE GHOST WELL)
    (TEXT "A ghost is haunting the well in the village. Townsfolk are suffering without access to the water supply.")
    (BOUNTY-REWARD 300)
    (BOUNTY-MONSTER NONE)
    (QUEST-TYPE QUEST-RECOVER)
    (VALUE 200)>