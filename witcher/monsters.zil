<OBJECT NEKKER
    (DESC "Nekker")
    (IN DEEP-FOREST)
    (SYNONYM NEKKER GHOUL MONSTER)
    (ADJECTIVE UGLY GROTESQUE)
    (HIT-POINTS 100)
    (HIT-DAMAGE 20)
    (ACTION NEKKER-F)
    (FLAGS MONSTERBIT)>

<ROUTINE NEKKER-F ()
    <COND (<VERB? ATTACK>
        <COMBAT-SILVER ,PRSO ,PRSI ,OGROID-OIL>
    )(ELSE
        <MONSTER-RESPONSE ,PRSO> 
    )>>