<OBJECT NEKKER
	(DESC "Nekker")
    (IN FOREST)
	(SYNONYM NEKKER GHOUL MONSTER)
	(ADJECTIVE UGLY GROTESQUE)
    (HIT-POINTS 100)
    (HIT-DAMAGE 50)
    (ACTION NEKKER-F)
	(FLAGS MONSTERBIT)>

<ROUTINE NEKKER-F ()
    <COND (<VERB? ATTACK>
        <COND (<FSET? ,PRSI ,WEAPONBIT>
            <COND (<EQUAL? ,PRSI ,SILVER-SWORD>
                <WITCHER-ATTACK ,PRSO ,PRSI>
            )(ELSE
                <WEAPON-INEFFECTIVE ,PRSO ,PRSI>
            )>
        )(ELSE
            <NO-COMBAT-PLAN ,PRSO ,PRSI>
        )>
    )(ELSE
        <MONSTER-RESPONSE ,PRSO>
    )>>