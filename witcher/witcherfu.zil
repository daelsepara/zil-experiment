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

<ROUTINE WHITE-ORCHARD-INVESTIGATION ("AUX" TEXT)
    <COND (,RIDING-VEHICLE
        <NEED-TO-DISMOUNT>
        <RTRUE>
    )>
    <COND (<MONSTER-HERE>
        <CRLF>
        <NOT-THE-TIME>
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

;---------------------------------
"Bounty: Farm infestation"

<OBJECT FARM-NEST
    (DESC "hole on the ground")
    (FDESC "[On the far edge of the farm, there is a hole on the ground]")
    (SYNONYM HOLE NEST)
    (TEXT "This seems to be the source of the infestation. Ghouls tend to emerge from such nests. I should destroy it and wait for the alghoul.")
    (ACTION FARM-INVESTIGATION)
    (FLAGS DESTRUCTIBLE NOTDESTROYED VOWELBIT)>

<ROUTINE FARM-INVESTIGATION ("AUX" TEXT)
    <COND (,RIDING-VEHICLE
        <NEED-TO-DISMOUNT>
        <RTRUE>
    )>
    <COND (<MONSTER-HERE>
        <CRLF>
        <NOT-THE-TIME>
        <RTRUE>
    )(<VERB? EXAMINE>
        <COND (<GETP ,BOUNTY-WHITE-ORCHARD-INFESTATION ,P?QUEST-INVESTIGATED>
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
        <COND (<GETP ,BOUNTY-WHITE-ORCHARD-INFESTATION ,P?QUEST-INVESTIGATED> <PUTP ,FARM-NEST ,P?FDESC NEST-REMAINS> <PUTP ,FARM-NEST ,P?TEXT RUBBLE>)>
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
    (TEXT "Human. Male. Most of the flesh and bones were picked clean by the bear. Nothing much left to identify him apart from his clothes and what little he had left on him.")
    (ACTION MISSING-HUSBAND-INVESTIGATION)>

<ROUTINE MISSING-HUSBAND-INVESTIGATION ("AUX" TEXT)
    <COND (,RIDING-VEHICLE
        <NEED-TO-DISMOUNT>
        <RTRUE>
    )>
    <COND (<VERB? EXAMINE>
        <COND (<GETP ,QUEST-MISSING-HUSBAND ,P?QUEST-INVESTIGATED>
            <SET TEXT <GETP ,PRSO ,P?TEXT>>
            <TELL .TEXT  CR>            
        )(T
            <TELL "You took a look at " T ,PRSO CR>
        )>
        <RTRUE>
    )(<VERB? LOOK-CLOSELY>
        <COND (<GETP ,QUEST-MISSING-HUSBAND ,P?QUEST-ACCEPTED>
            <SET TEXT <GETP ,PRSO ,P?TEXT>>
            <COND (.TEXT
                <TELL CR T ,PRSO ": [" .TEXT "]" CR>
                <INVESTIGATE-CLUE ,CORPSE-MISSING-HUSBAND MISSING-HUSBAND-INVESTIGATIONS 1 T>
                <CHECK-INVESTIGATION ,QUEST-MISSING-HUSBAND MISSING-HUSBAND-INVESTIGATIONS MISSING-HUSBAND-CONCLUSION ,HUNTERS-WIFE>
                <COND (<GETP ,QUEST-MISSING-HUSBAND ,P?QUEST-INVESTIGATED>
                    <PUTP ,QUEST-MISSING-HUSBAND ,P?QUEST-REPORTED T>
                )>
            )>
            <RTRUE>
        )(
            <HMMM>
            <RTRUE>
        )>
    )>
    <RFALSE>>

;---------------------------------
"CONTRACT: Ghost in the Well"

<OBJECT JAENY-DIARY
    (DESC "yellowed diary")
    (SYNONYM DIARY)
    (ADJECTIVE YELLOW YELLOWED)
    (TEXT "||You a read the diary.||.............. first page||I am so happy! Odolan and I will be married in a month. Today, he gave me a beatiful braclet from Novigrad.||.............. second page||Odolan went back to Novigrad for some business.||I am counting the days until his return so we can be married!||.............. fifth page (almost torn off)||Marek proposed to me again. He thinks, he is much better Odolan||.............. ninth page (blood stains)||Marek is still angry after I rejected his suit||Odolan is arriving tomorrow. Everything's going to be wonderful again.|")
    (ACTION ABANDONED-WELL-INVESTIGATION)
    (FLAGS NDESCBIT MAGICBIT READBIT)>

<OBJECT PENTAGRAM-RITUAL
    (DESC "pentagram drawn in blood")
    (SYNONYM PENTAGRAM RITUAL BLOOD)
    (TEXT "A pentagram drawn from blood is on the ground. Looks like a ritual was performed to curse someone.")
    (ACTION ABANDONED-WELL-INVESTIGATION)
    (FLAGS NDESCBIT MAGICBIT READBIT)>

<OBJECT WELL
	(IN ABANDONED-VILLAGE-WELL)
	(DESC "well")
	(TEXT "There are traces of blood on the well. A foul odor also emanates from it. Perhaps someone or something thrown down there.")
	(SYNONYM WELL)
	(ACTION ABANDONED-WELL-INVESTIGATION)>

<OBJECT DRAG-MARKS
	(DESC "drag marks on the ground")
    (FDESC "[There are drag marks on the ground]")
    (TEXT "Someone was dragged towards the well. No signs of struggle. The victim must have been dead already.")
    (SYNONYM MARKS)
    (ADJECTIVE DRAG)
    (ACTION ABANDONED-WELL-INVESTIGATION)
    (THINGS <> (GROUND) THINGS-F)
    (FLAGS PLURALBIT)>

<ROUTINE ABANDONED-WELL-INVESTIGATION ("AUX" TEXT)
    <COND (,RIDING-VEHICLE
        <NEED-TO-DISMOUNT>
        <RTRUE>
    )>
    <COND (<MONSTER-HERE>
        <CRLF>
        <NOT-THE-TIME>
        <RTRUE>
    )>
    <COND (<VERB? EXAMINE>
        <COND (<AND <EQUAL? ,PRSO ,WELL> <NOT <GETP ,CONTRACT-GHOST-IN-THE-WELL ,P?QUEST-ACCEPTED>>> <THINGS-F> <RTRUE>)>
        <TELL "You took a look at " T ,PRSO CR>
        <RTRUE>
    )(<VERB? LOOK-CLOSELY>
        <COND (<AND <EQUAL? ,PRSO ,WELL> <NOT <GETP ,CONTRACT-GHOST-IN-THE-WELL ,P?QUEST-ACCEPTED>>> <THINGS-F> <RTRUE>)>
        <SET TEXT <GETP ,PRSO ,P?TEXT>>
        <COND (.TEXT
            <TELL CR T ,PRSO ": [" .TEXT "]" CR>
            <INVESTIGATE-CLUE ,JAENY-DIARY ABANDONED-VILLAGE-INVESTIGATIONS 1 T>
            <INVESTIGATE-CLUE ,PENTAGRAM-RITUAL ABANDONED-VILLAGE-INVESTIGATIONS 2 T>
            <INVESTIGATE-CLUE ,WELL ABANDONED-VILLAGE-INVESTIGATIONS 3 T>
            <INVESTIGATE-CLUE ,DRAG-MARKS ABANDONED-VILLAGE-INVESTIGATIONS 4 T>
            <CHECK-INVESTIGATION ,CONTRACT-GHOST-IN-THE-WELL ABANDONED-VILLAGE-INVESTIGATIONS ABANDONED-VILLAGE-CONCLUSION ,ABANDONED-VILLAGE-ALDERMAN>
            <COND (<GETP ,CONTRACT-GHOST-IN-THE-WELL ,P?QUEST-INVESTIGATED> <ADD-TOPIC ,TOPIC-JAENY>)>
            <RTRUE>
        )>
    )>
    <RFALSE>>

;---------------------------------
"QUEST: Missing bracelet"

<OBJECT MISSING-BRACELET
    (IN ABANDONED-VILLAGE-WELL-BOTTOM)
    (DESC "shiny trinket")
    (SYNONYM TRINKET BRACELET)
    (ADJECTIVE SHINY)
    (TEXT "A woman's bracelet. Still shiny, albeit with some scratches")
    (ACTION MISSING-BRACELET-INVESTIGATION)
    (FLAGS NDESCBIT MAGICBIT)>

<OBJECT JAENY-CORPSE
    (IN ABANDONED-VILLAGE-WELL-BOTTOM)
    (DESC "dead woman's body")
    (TEXT "A dead woman. Must have been Jaeny.")
    (SYNONYM CORPSE REMAINS WOMAN BODY JAENY)
    (ACTION MISSING-BRACELET-INVESTIGATION)
    (ADJECTIVE DEAD)>

<ROUTINE MISSING-BRACELET-INVESTIGATION ("AUX" TEXT)
    <COND (,RIDING-VEHICLE
        <NEED-TO-DISMOUNT>
        <RTRUE>
    )>
    <COND (<VERB? EXAMINE>
        <COND (<AND <EQUAL? ,PRSO ,MISSING-BRACELET> <NOT <GETP ,CONTRACT-MISSING-BRACELET ,P?QUEST-ACCEPTED>>> <HMMM> <RTRUE>)>
        <COND (<AND <EQUAL? ,PRSO ,JAENY-CORPSE> <NOT <GETP ,CONTRACT-GHOST-IN-THE-WELL ,P?QUEST-COMPLETED>>> <HMMM> <RTRUE>)>
        <TELL "You took a look at " T ,PRSO CR>
        <RTRUE>
    )(<VERB? LOOK-CLOSELY>
        <COND (<AND <EQUAL? ,PRSO ,MISSING-BRACELET> <NOT <GETP ,CONTRACT-MISSING-BRACELET ,P?QUEST-ACCEPTED>>> <HMMM> <RTRUE>)>
        <COND (<AND <EQUAL? ,PRSO ,JAENY-CORPSE> <NOT <GETP ,CONTRACT-GHOST-IN-THE-WELL ,P?QUEST-COMPLETED>>> <HMMM> <RTRUE>)>
        <SET TEXT <GETP ,PRSO ,P?TEXT>>
        <COND (.TEXT
            <TELL CR T ,PRSO ": [" .TEXT "]" CR>
            <INVESTIGATE-CLUE ,MISSING-BRACELET MISSING-BRACELET-INVESTIGATIONS 1 T>
            <CHECK-INVESTIGATION ,CONTRACT-MISSING-BRACELET MISSING-BRACELET-INVESTIGATIONS MISSING-BRACELET-CONCLUSIONS ,ODOLAN>
            <FSET ,MISSING-BRACELET ,TAKEBIT>
            <RTRUE>
        )>
    )(<VERB? TAKE>
        <COND (<AND <EQUAL? ,PRSO ,MISSING-BRACELET> <NOT <GETP ,CONTRACT-MISSING-BRACELET ,P?QUEST-ACCEPTED>>> <HMMM> <RTRUE>)>
        <V-TAKE>
        <RTRUE>
    )>
    <RFALSE>>