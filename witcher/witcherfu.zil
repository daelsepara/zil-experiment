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

<OBJECT WHITE-ORCHARD-FARM-NEST
    (DESC "hole on the ground")
    (FDESC "[On the far edge of the farm, there is a hole on the ground]")
    (SYNONYM HOLE NEST)
    (TEXT "This seems to be the source of the infestation. Ghouls tend to emerge from such nests. I should destroy it then wait for the alghoul.")
    (ACTION WHITE-ORCHARD-FARM-INVESTIGATION)
    (FLAGS DESTRUCTIBLE NOTDESTROYED VOWELBIT)>

<ROUTINE WHITE-ORCHARD-INVESTIGATION ("AUX" TEXT)
    <COND (,RIDING-VEHICLE
        <NEED-TO-DISMOUNT>
        <RTRUE>
    )>
    <COND (<FIND-IN ,HERE ,MONSTERBIT>
        <TELL CR "The quarry is here! Now is not the time for that!" CR>
        <RTRUE>
    )(<VERB? EXAMINE>
        <TELL "You took a look at " T ,PRSO CR>
        <RTRUE>
    )(<VERB? LOOK-CLOSELY>
        <SET TEXT <GETP ,PRSO ,P?TEXT>>
        <COND (.TEXT
            <TELL CR T ,PRSO ": [" .TEXT "]" CR>
            <INVESTIGATE-CLUE ,WHITE-ORCHARD-BROKEN-WAGON WHITE-ORCHARD-INVESTIGATIONS 1>
            <INVESTIGATE-CLUE ,WHITE-ORCHARD-CARCASS WHITE-ORCHARD-INVESTIGATIONS 2>
            <INVESTIGATE-CLUE ,WHITE-ORCHARD-WARES WHITE-ORCHARD-INVESTIGATIONS 3>
            <INVESTIGATE-CLUE ,WHITE-ORCHARD-FEATHERS WHITE-ORCHARD-INVESTIGATIONS 4>
            <CHECK-INVESTIGATION ,BOUNTY-WHITE-ORCHARD WHITE-ORCHARD-INVESTIGATIONS WHITE-ORCHARD-CONCLUSION ,WHITE-ORCHARD-ALDERMAN>
            <RTRUE>
        )>
    )>
    <RFALSE>>

<ROUTINE WHITE-ORCHARD-FARM-INVESTIGATION ("AUX" TEXT)
    <COND (,RIDING-VEHICLE
        <NEED-TO-DISMOUNT>
        <RTRUE>
    )>
    <COND (<FIND-IN ,HERE ,MONSTERBIT>
        <TELL CR "The quarry is here! Now is not the time for that!" CR>
        <RTRUE>
    )(<VERB? EXAMINE>
        <TELL "You took a look at " T ,PRSO CR>
        <RTRUE>
    )(<VERB? LOOK-CLOSELY>
        <SET TEXT <GETP ,PRSO ,P?TEXT>>
        <COND (.TEXT
            <TELL CR T ,PRSO ": [" .TEXT "]" CR>
            <RTRUE>
        )>
    )(<VERB? DESTROY>
        <V-DESTROY>
        <INVESTIGATE-CLUE ,WHITE-ORCHARD-FARM-NEST WHITE-ORCHARD-FARM-INVESTIGATIONS 1>
        <CHECK-INVESTIGATION ,BOUNTY-WHITE-ORCHARD-INFESTATION WHITE-ORCHARD-FARM-INVESTIGATIONS WHITE-ORCHARD-FARM-CONCLUSION ,WHITE-ORCHARD-FARMER>
        <COND (<GETP ,BOUNTY-WHITE-ORCHARD-INFESTATION ,P?BOUNTY-INVESTIGATED> <PUTP ,WHITE-ORCHARD-FARM-NEST ,P?FDESC NEST-REMAINS>)>
        <RTRUE>
    )>
    <RTRUE>>