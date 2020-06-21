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
        (VALUE 0)
        (FLAGS TAKEBIT READBIT BOUNTYBIT)>

<BOUNTY BOUNTY-BANDITS
    (DESC "Bounty: Raid Bandit Camp")
    (ADJECTIVE BANDIT BANDITS)
    (TEXT "Groups of bandits are robbing, pillaging and looting around White Orchard. Townsfolk are advised to travel in large groups for their own safety. Talk to the magistrate at the Nilfgaardian outpost.")
    (BOUNTY-REWARD 500)
    (BOUNTY-MONSTER BANDITS)
    (VALUE 100)>

<BOUNTY BOUNTY-WHITE-ORCHARD
    (IN WHITE-ORCHARD-BOUNTY-BOARD)
    (DESC "Bounty: Beast of White Orchard")
    (ADJECTIVE BEAST)
    (TEXT "A vicious beast is terrorizing the White Orchard area. Travelling in and out of town is forbidden. Merchants should comply. Look for the alderman at White Orchard for further information.")
    (BOUNTY-REWARD 1500)
    (BOUNTY-LOC CROSSROADS)
    (BOUNTY-MONSTER GRIFFIN)
    (VALUE 500)>

<BOUNTY BOUNTY-WHITE-ORCHARD-INFESTATION
    (IN WHITE-ORCHARD-BOUNTY-BOARD)
    (DESC "Bounty: Farm infestation")
    (ADJECTIVE FARM INFESTATION)
    (TEXT "A farmer near White Orchard is having an infestation problem. He cannot plant his crops nor harvest them until this is resolved. Look for the farmer north west of the town.")
    (BOUNTY-REWARD 800)
    (BOUNTY-LOC WHITE-ORCHARD-FARM)
    (BOUNTY-MONSTER ALGHOUL)
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
    (VALUE 50)>