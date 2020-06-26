<OBJECT-TEMPLATE OIL =
    OBJECT
		(SYNONYM VIAL OIL)
		(BONUS-DAMAGE 50)
		(TEXT "a type of oil for dealing with a specific kinds of monster")
		(FLAGS TAKEBIT)>

<OBJECT-TEMPLATE POTION =
	OBJECT
		(SYNONYM VIAL POTION)
		(FLAGS TAKEBIT)>

;----------------------
"Witcher weapons"

<OBJECT BARE-HANDS
	(DESC "bare hands")
	(SYNONYM FISTS HANDS)
	(IN PLAYER)
	(TEXT "a weapon of last resort")
	(ADJECTIVE UNARMED BARE)
	(HIT-DAMAGE 1)
	(LOW-DAMAGE 1)
	(ACTION BODY-PART-F)
	(FLAGS WEAPONBIT)>

<OBJECT SILVER-SWORD
	(IN PLAYER)
	(DESC "silver sword")
	(SYNONYM SWORD SWORDS)
	(ADJECTIVE SILVER)
	(HIT-DAMAGE 50)
	(LOW-DAMAGE 20)
	(TEXT "a weapon for killing creatures of magic")
	(FLAGS TAKEBIT CONTBIT SURFACEBIT WEAPONBIT)>

<OBJECT STEEL-SWORD
	(IN PLAYER)
	(DESC "steel sword")
	(SYNONYM SWORD SWORDS)
	(ADJECTIVE STEEL)
	(HIT-DAMAGE 50)
	(LOW-DAMAGE 20)
	(TEXT "a weapon for killing humans or humanoid creatures, and beasts")
	(FLAGS TAKEBIT CONTBIT SURFACEBIT WEAPONBIT)>

;----------------------
"Witcher accessories"

<OBJECT WOLF-MEDALLION
	(IN PLAYER)
	(DESC "wolf medallion")
	(SYNONYM MEDALLION MEDAL)
	(ADJECTIVE WOLF)
	(TEXT "an amulet that can detect the presence of magic")
	(FLAGS TAKEBIT WEARBIT WORNBIT)>

;----------------------
"Oils"

<OIL BEAST-OIL
	(DESC "vial of beast oil")
	(ADJECTIVE BEAST)>

<OIL CURSED-OIL
	(DESC "vial of cursed oil")
	(ADJECTIVE CURSED)>

<OIL DRACONID-OIL
	(DESC "vial of draconid oil")
	(ADJECTIVE DRACONID)>

<OIL ELEMENTA-OIL
	(DESC "vial of elementa oil")
	(ADJECTIVE ELEMENTA)>

<OIL HANGEDMANS-VENOM
	(DESC "vial of hanged man's venom")
	(SYNONYM VIAL VENOM HANGED-MAN'S-VENOM)
	(ADJECTIVE HANGED HANGED-MAN'S)>

<OIL HYBRID-OIL
	(IN PLAYER)
	(DESC "vial of hybrid oil")
	(ADJECTIVE HYBRID)>

<OIL INSECTOID-OIL
	(DESC "vial of insectoid oil")
	(ADJECTIVE INSECTOID)>

<OIL NECROPHAGE-OIL
	(IN PLAYER)
	(DESC "vial of necrophage oil")
	(ADJECTIVE NECROPHAGE)>

<OIL OGROID-OIL
	(DESC "vial of ogroid oil")
	(ADJECTIVE OGROID)>

<OIL RELICT-OIL
	(DESC "vial of relict oil")
	(ADJECTIVE RELICT)>

<OIL SPECTER-OIL
	(DESC "vial of specter oil")
	(ADJECTIVE SPECTER)>

<OIL VAMPIRE-OIL
	(DESC "vial of vampire oil")
	(ADJECTIVE VAMPIRE)>

<POTION CAT-EYES-POTION
	(IN PLAYER)
	(SYNONYM POTION)
	(DESC "cat's eye potion")
	(TEXT "potion that allows you to see in the dark for a limited time")
	(ADJECTIVE CAT EYE EYES)
	(ACTION POTION-ACTION-F)>

<ROUTINE BODY-PART-F ()
	<COND (<VERB? DROP>
		<TELL "You can't do that!" CR>
	)(<VERB? TAKE>
		<WHAT-NOW>
	)>>

<ROUTINE DRINK-POTION (POTION "AUX" WAS-DARK)
	<COND (<EQUAL? .POTION ,CAT-EYES-POTION>
		<COND (,WITCHER-CATS-EYE
			<TELL "You already drank " T ,PRSO "!" CR>
		)(T
			<SET WAS-DARK <IS-DARK ,HERE ,PLAYER>>
			<TELL "You drink " T .POTION ".">
			<SETG WITCHER-CATS-EYE T>
			<WITCHER-CAT-EYES-EFFECT>
			<QUEUE I-CAT-EYES CATS-EYE-DURATION>
			<COND (.WAS-DARK
				<HLIGHT ,H-BOLD><TELL " You can now see in the dark for a limited time." CR><HLIGHT 0>
			)>
			<FLUSH>
		)>
		<RTRUE>
	)>>

<ROUTINE POTION-ACTION-F ()
	<COND (<VERB? DRINK>
		<RETURN <DRINK-POTION ,PRSO>>
	)>
	<RFALSE>>
