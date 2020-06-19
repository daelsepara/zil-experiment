<OBJECT WHITE-ORCHARD-BROKEN-WAGON 
    (DESC "merchant's wagon")
    (FDESC "[A merchant's wagon lies beside the road]")
    (SYNONYM WAGON)
    (TEXT "The wagon is overturned and badly broken. The wheels on its axles have come apart. There claw marks everywhere, too large to be made by lions.")
    (ACTION WHITE-ORCHARD-INVESTIGATION)>

<OBJECT WHITE-ORCHARD-CARCASS
    (DESC "animal carcasses")
    (FDESC "[There are several animal carcasses here]")
    (SYNONYM CORPSE ANIMAL CARCASS)
    (TEXT "Several corpses also appear to have been mutilated by something with large claws. You look for signs of teeth marks but there are none. They look more like those made by aninmals with beaks... large beaks.")
    (ACTION WHITE-ORCHARD-INVESTIGATION)>

<OBJECT WHITE-ORCHARD-WARES
    (DESC "merchant's wares")
    (FDESC "[Various merchant wares and goods are scattered nearby]")
    (SYNONYM WARES GOODS)
    (TEXT "Some were crushed beneath the wagon. Some were damaged from the fall. There is little or no blood splattered across these things. They do not appear to have suffered any kind of mutilation, suggesting that, whatever did this, it was more interested in food.")
    (ACTION WHITE-ORCHARD-INVESTIGATION)>

<OBJECT WHITE-ORCHARD-FEATHERS
    (DESC "feathers on the ground")
    (FDESC "[There are a few feathers on the ground]")
    (SYNONYM FEATHER FEATHERS)
    (TEXT "Feathers... a curious thing to be found amongst the carnage. They are large, as in they are from a large bird-like beast of some kind.")
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