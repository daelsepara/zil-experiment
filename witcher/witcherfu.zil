"Bounty: Beast of White Orchard"

<OBJECT WHITE-ORCHARD-BROKEN-WAGON 
    (DESC "merchant's wagon")
    (FDESC "[A merchant's wagon lies broken beside the road]")
    (SYNONYM WAGON)
    (TEXT "The wagon is overturned and badly broken. The wheels on its axles have come apart. There are claw and hoof marks everywhere. They do not appear to have been made by lions. These hoof marks were not of those made by the dead horse.")
    (ACTION WHITE-ORCHARD-INVESTIGATION)>

<OBJECT WHITE-ORCHARD-CARCASS
    (DESC "animal carcasses")
    (FDESC "[There are several animal carcasses here]")
    (SYNONYM CORPSE CORPSES HORSE ANIMAL CARCASS CARCASSES)
    (TEXT "Several carcasses appear to have been mutilated. The attacker must have been exceptionally strong and had large claws to have caused such brutality. You look for teeth marks but there are none. However, the bite marks resemble those made by a beak... a large beak.")
    (FLAGS PLURALBIT)
    (ACTION WHITE-ORCHARD-INVESTIGATION)>

<OBJECT WHITE-ORCHARD-WARES
    (DESC "merchant's wares")
    (FDESC "[Various merchant wares and goods are scattered about]")
    (SYNONYM WARES GOODS)
    (TEXT "Some were crushed beneath the wagon, others were damaged by the fall. There is little to no blood splattered on these things. They do not appear to have suffered a similar degree of savagery. Whatever did this was more interested in the food that was being transported.")
    (FLAGS PLURALBIT)
    (ACTION WHITE-ORCHARD-INVESTIGATION)>

<OBJECT WHITE-ORCHARD-FEATHERS
    (DESC "feathers on the ground")
    (FDESC "[There are a few feathers on the ground]")
    (SYNONYM FEATHER FEATHERS)
    (TEXT "Feathers... a curious thing to be found amongst the carnage. The size of these feathers hint at a large, bird-like beast of some kind.")
    (FLAGS PLURALBIT)
    (ACTION WHITE-ORCHARD-INVESTIGATION)>

;---------------------------------
"Bounty: Farm infestation"

<OBJECT FARM-NEST
    (DESC "hole on the ground")
    (FDESC "[On the far edge of the farm, there is a hole on the ground]")
    (SYNONYM HOLE NEST)
    (TEXT "This seems to be the source of the infestation. Ghouls tend to emerge from such nests. I should destroy it and wait for the alghoul.")
    (ACTION FARM-INVESTIGATION)
    (FLAGS DESTRUCTIBLE NOTDESTROYED VOWELBIT)>

<ROUTINE WHITE-ORCHARD-INVESTIGATION ("AUX" TEXT)
    <COND (,RIDING-VEHICLE
        <NEED-TO-DISMOUNT>
        <RTRUE>
    )>
    <COND (<MONSTER-HERE>
        <TELL CR "The quarry is here! Now is not the time for that!" CR>
        <RTRUE>
    )>
    <COND (<VERB? EXAMINE>
        <TELL "You took a look at " T ,PRSO CR>
        <RTRUE>
    )(<VERB? LOOK-CLOSELY>
        <SET TEXT <GETP ,PRSO ,P?TEXT>>
        <COND (.TEXT
            <TELL CR T ,PRSO ": [" .TEXT "]" CR>
            <INVESTIGATE-CLUE ,WHITE-ORCHARD-BROKEN-WAGON WHITE-ORCHARD-INVESTIGATIONS 1 T>
            <INVESTIGATE-CLUE ,WHITE-ORCHARD-CARCASS WHITE-ORCHARD-INVESTIGATIONS 2 T>
            <INVESTIGATE-CLUE ,WHITE-ORCHARD-WARES WHITE-ORCHARD-INVESTIGATIONS 3 T>
            <INVESTIGATE-CLUE ,WHITE-ORCHARD-FEATHERS WHITE-ORCHARD-INVESTIGATIONS 4 T>
            <CHECK-INVESTIGATION ,BOUNTY-WHITE-ORCHARD WHITE-ORCHARD-INVESTIGATIONS WHITE-ORCHARD-CONCLUSION ,WHITE-ORCHARD-ALDERMAN>
            <RTRUE>
        )>
    )>
    <RFALSE>>

<ROUTINE FARM-INVESTIGATION ("AUX" TEXT)
    <COND (,RIDING-VEHICLE
        <NEED-TO-DISMOUNT>
        <RTRUE>
    )>
    <COND (<MONSTER-HERE>
        <TELL CR "The quarry is here! Now is not the time for that!" CR>
        <RTRUE>
    )(<VERB? EXAMINE>
        <COND (<GETP ,BOUNTY-WHITE-ORCHARD-INFESTATION ,P?BOUNTY-INVESTIGATED>
            <SET TEXT <GETP ,PRSO ,P?TEXT>>
            <TELL .TEXT  CR>            
        )(T
            <TELL "You took a look at " D ,PRSO CR>
        )>
        <RTRUE>
    )(<VERB? LOOK-CLOSELY>
        <SET TEXT <GETP ,PRSO ,P?TEXT>>
        <COND (.TEXT
            <TELL CR T ,PRSO ": [" .TEXT "]" CR>
            <RTRUE>
        )>
    )(<VERB? DESTROY>
        <V-DESTROY>
        <INVESTIGATE-CLUE ,FARM-NEST FARM-INVESTIGATIONS 1>
        <CHECK-INVESTIGATION ,BOUNTY-WHITE-ORCHARD-INFESTATION FARM-INVESTIGATIONS FARM-CONCLUSION ,WHITE-ORCHARD-FARMER>
        <COND (<GETP ,BOUNTY-WHITE-ORCHARD-INFESTATION ,P?BOUNTY-INVESTIGATED> <PUTP ,FARM-NEST ,P?FDESC NEST-REMAINS> <PUTP ,FARM-NEST ,P?TEXT RUBBLE>)>
        <RTRUE>
    )>
    <RFALSE>>

;---------------------------------
"QUEST: Missing husband"

<OBJECT CORPSE-MISSING-HUSBAND
    (IN CAVE-III)
    (DESC "remains of a mangled body")
    (FDESC "[There is a mangled body here]")
    (SYNONYM CORPSE REMAINS BODY)
    (ADJECTIVE DEAD MANGLED)
    (TEXT "Human. Male. Flesh and bones picked clean by the bear. Nothing left to identify him apart from his clothes and what little he had left on him.")
    (ACTION MISSING-HUSBAND-INVESTIGATION)>

<ROUTINE MISSING-HUSBAND-INVESTIGATION ("AUX" TEXT)
    <COND (,RIDING-VEHICLE
        <NEED-TO-DISMOUNT>
        <RTRUE>
    )>
    <COND (<VERB? EXAMINE>
        <COND (<GETP ,QUEST-MISSING-HUSBAND ,P?BOUNTY-INVESTIGATED>
            <SET TEXT <GETP ,PRSO ,P?TEXT>>
            <TELL .TEXT  CR>            
        )(T
            <TELL "You took a look at " T ,PRSO CR>
        )>
        <RTRUE>
    )(<VERB? LOOK-CLOSELY>
        <COND (<GETP ,QUEST-MISSING-HUSBAND ,P?BOUNTY-ACCEPTED>
            <SET TEXT <GETP ,PRSO ,P?TEXT>>
            <COND (.TEXT
                <TELL CR T ,PRSO ": [" .TEXT "]" CR>
                <INVESTIGATE-CLUE ,CORPSE-MISSING-HUSBAND MISSING-HUSBAND-INVESTIGATIONS 1 T>
                <CHECK-INVESTIGATION ,QUEST-MISSING-HUSBAND MISSING-HUSBAND-INVESTIGATIONS MISSING-HUSBAND-CONCLUSION ,HUNTERS-WIFE>
                <COND (<GETP ,QUEST-MISSING-HUSBAND ,P?BOUNTY-INVESTIGATED>
                    <PUTP ,QUEST-MISSING-HUSBAND ,P?BOUNTY-REPORTED T>
                )>
            )>
            <RTRUE>
        )(
            <HMMM>
            <RTRUE>
        )>
    )>
    <RFALSE>>
