<CONSTANT WHITE-ORCHARD-CLUES <LTABLE WHITE-ORCHARD-BROKEN-WAGON WHITE-ORCHARD-CARCASS WHITE-ORCHARD-WARES>>
<CONSTANT WHITE-ORCHARD-INVESTIGATIONS <LTABLE FALSE FALSE FALSE>>

<OBJECT WHITE-ORCHARD-BROKEN-WAGON 
    (DESC "merchant's wagon")
    (FDESC "[A merchant's wagon lies beside the road]")
    (SYNONYM WAGON)
    (TEXT "The wagon is overturned and badly broken. The wheels on its axles have come apart. There are a large number of claw marks, too large to be made by a lion.")
    (ACTION WHITE-ORCHARD-INVESTIGATION)>

<OBJECT WHITE-ORCHARD-CARCASS
    (DESC "animal carcasses")
    (FDESC "[There are several animal carcasses here]")
    (SYNONYM CORPSE ANIMAL CARCASS)
    (TEXT "Several corpses also appear to have been mutilated by something with large claws. You look for signs of teeth marks but there are none. They look more like those made by aninmals with beaks... large beaks.")
    (ACTION WHITE-ORCHARD-INVESTIGATION)>

<OBJECT WHITE-ORCHARD-WARES
    (DESC "merchant's wares")
    (FDESC "[Various wares and merchant goods are scattered across the ground]")
    (SYNONYM WARES GOODS)
    (TEXT "They do not appear to have suffered any kind of mutilation. Some of these have crushed by under the wagon -- some, appear damaged from the fall. There is little or no blood splattered across these, suggesting that the assailaint is more interested in the other load carried by the wagon.")
    (ACTION WHITE-ORCHARD-INVESTIGATION)>

<ROUTINE WHITE-ORCHARD-INVESTIGATION ()
    <COND (,RIDING-VEHICLE
        <NEED-TO-DISMOUNT>
        <RTRUE>
    )>
    <COND (,PRSI
        <RFALSE>
    )>
    <COND (<VERB? EXAMINE>
        <TELL "You took a look at " T ,PRSO CR>
        <RTRUE>
    )(<VERB? LOOK-CLOSELY>
        <TELL CR T ,PRSO ": [" <GETP ,PRSO ,P?TEXT> "]" CR>
        <COND (<EQUAL? ,PRSO ,WHITE-ORCHARD-BROKEN-WAGON> <PUT WHITE-ORCHARD-INVESTIGATIONS 1 T>)>
        <COND (<EQUAL? ,PRSO ,WHITE-ORCHARD-CARCASS> <PUT WHITE-ORCHARD-INVESTIGATIONS 2 T>)>
        <COND (<EQUAL? ,PRSO ,WHITE-ORCHARD-WARES> <PUT WHITE-ORCHARD-INVESTIGATIONS 3 T>)>
        <COND (<CHECK-IF-BOUNTY-INVESTIGATED ,WHITE-ORCHARD-INVESTIGATIONS>
            <TELL CR "You have completed your investigations. You should report back to " D ,WHITE-ORCHARD-ALDERMAN "." CR>
            <PUTP ,BOUNTY-WHITE-ORCHARD ,P?BOUNTY-INVESTIGATED T>
        )>
        <RTRUE>
    )>
    <RFALSE>>