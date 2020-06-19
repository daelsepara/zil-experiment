<OBJECT WHITE-ORCHARD-BROKEN-WAGON 
    (DESC "merchant's wagon")
    (FDESC "[A merchant's wagon lies beside the road]")
    (SYNONYM WAGON)
    (TEXT "The wagon is overturned and badly broken. The wheels on its axles have come apart. There are claw and hoof marks everywhere. They do not appear be made by lions. The hoof marks do not appear to have made by horses, either.")
    (ACTION WHITE-ORCHARD-INVESTIGATION)>

<OBJECT WHITE-ORCHARD-CARCASS
    (DESC "animal carcasses")
    (FDESC "[There are several animal carcasses here]")
    (SYNONYM CORPSE ANIMAL CARCASS CARCASSES)
    (TEXT "Several carcasses appear to have been mutilated. The attacker must have been exceptionally strong and had large claws to have caused such brutality. You look for teeth marks but there are none. However, the bite marks resemble those made by beaks... large beaks.")
    (ACTION WHITE-ORCHARD-INVESTIGATION)>

<OBJECT WHITE-ORCHARD-WARES
    (DESC "merchant's wares")
    (FDESC "[Various merchant wares and goods are scattered nearby]")
    (SYNONYM WARES GOODS)
    (TEXT "Some were crushed beneath the wagon, others were damaged by the fall. There is little to no blood splashed on these things. They do not appear to have suffered any kind of butchery. Whatever did this was more interested in the food that was being transported.")
    (ACTION WHITE-ORCHARD-INVESTIGATION)>

<OBJECT WHITE-ORCHARD-FEATHERS
    (DESC "feathers on the ground")
    (FDESC "[There are a few feathers on the ground]")
    (SYNONYM FEATHER FEATHERS)
    (TEXT "Feathers... a curious thing to be found amongst the carnage. The size of these feathers hint at a large, bird-like beast of some kind.")
    (ACTION WHITE-ORCHARD-INVESTIGATION)>

<ROUTINE WHITE-ORCHARD-INVESTIGATION ("AUX" TEXT)
    <COND (,RIDING-VEHICLE
        <NEED-TO-DISMOUNT>
        <RTRUE>
    )>
    <COND (<IN? ,GRIFFIN ,HERE>
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