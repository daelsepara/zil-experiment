<SYNTAX PUT OBJECT (HAVE HELD CARRIED) ON OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-APPLY-OIL>
<SYNTAX APPLY OBJECT (HAVE HELD CARRIED) ON OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-APPLY-OIL>
<SYNTAX APPLY OBJECT (HAVE HELD CARRIED) TO OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-APPLY-OIL>
<SYNONYM PUT APPLY POUR>

<SYNTAX CLEAN OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-REMOVE-OIL>

<ROUTINE APPLY-OIL (ARGOIL ARGSWORD)
	<TELL "You pour the " D .ARGOIL " onto the " D .ARGSWORD CR>>

<ROUTINE CANNOT-APPLY-OIL (ARGOIL ARGSWORD)
	<TELL "You cannot apply the " D .ARGOIL " to the " D .ARGSWORD ", or if you can, it will not be effective." CR>>

<ROUTINE V-APPLY-OIL ()
	<COND (<EQUAL? ,PRSI ,SILVER-SWORD ,STEEL-SWORD>
		<COND (<EQUAL? ,PRSI ,SILVER-SWORD>
			<COND (<EQUAL? ,PRSO ,VAMPIRE-OIL ,SPECTER-OIL ,OGROID-OIL ,NECROPHAGE-OIL ,ELEMENTA-OIL ,HYBRID-OIL ,RELICT-OIL ,DRACONID-OIL ,CURSED-OIL>
				<COND (<FIRST? SILVER-SWORD>
					<MOVE <FIRST? SILVER-SWORD> ,PLAYER>
				)>
				<MOVE ,PRSO ,SILVER-SWORD>
				<APPLY-OIL ,PRSO ,PRSI>
			)(ELSE
				<CANNOT-APPLY-OIL ,PRSO ,PRSI>
			)>
		)(ELSE
			<COND (<EQUAL? ,PRSO  ,HANGEDMANS-VENOM ,INSECTOID-OIL ,BEAST-OIL>
				<COND (<FIRST? STEEL-SWORD>
					<MOVE <FIRST? STEEL-SWORD> ,PLAYER>
				)>
				<MOVE ,PRSO ,STEEL-SWORD>
				<APPLY-OIL ,PRSO ,PRSI>
			)(ELSE
				<CANNOT-APPLY-OIL ,PRSO ,PRSI>
			)>
		)>
	)(ELSE
		<NOTHING-HAPPENS>
	)>>

<ROUTINE V-REMOVE-OIL ()
	<COND (<EQUAL? ,PRSO ,SILVER-SWORD ,STEEL-SWORD>
		<COND (<FIRST? ,PRSO>
			<TELL "You remove the " D <FIRST? ,PRSO> " from the " D ,PRSO CR>
			<MOVE <FIRST? ,PRSO> ,PLAYER>
		)(ELSE
			<TELL "The " D ,PRSO " is quite clean." CR>
		)>
	)(ELSE
		<NOTHING-HAPPENS>
	)>>

<OBJECT SILVER-SWORD
	(IN PLAYER)
	(DESC "silver sword")
	(SYNONYM SWORD)
	(ADJECTIVE SILVER)
	(FLAGS TAKEBIT CONTBIT SURFACEBIT OPENBIT WEAPONBIT)>

<OBJECT STEEL-SWORD
	(IN PLAYER)
	(DESC "steel sword")
	(SYNONYM SWORD)
	(ADJECTIVE STEEL)
	(FLAGS TAKEBIT CONTBIT SURFACEBIT OPENBIT WEAPONBIT)>

<OBJECT WOLF-MEDALLION
	(IN PLAYER)
	(DESC "wolf medallion")
	(SYNONYM MEDALLION MEDAL)
	(ADJECTIVE WOLF)
	(FLAGS TAKEBIT WEARBIT WORNBIT)>

<OBJECT VAMPIRE-OIL
	(IN PLAYER)
	(DESC "vial of vampire oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE VAMPIRE)
	(FLAGS TAKEBIT)>

<OBJECT RELICT-OIL
	(IN PLAYER)
	(DESC "vial of relict oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE RELICT)
	(FLAGS TAKEBIT)>

<OBJECT HYBRID-OIL
	(IN PLAYER)
	(DESC "vial of hybrid oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE HYBRID)
	(FLAGS TAKEBIT)>

<OBJECT BEAST-OIL
	(IN PLAYER)
	(DESC "vial of beast oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE BEAST)
	(FLAGS TAKEBIT)>

<OBJECT INSECTOID-OIL
	(IN PLAYER)
	(DESC "vial of insectoid oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE INSECTOID)
	(FLAGS TAKEBIT)>

<OBJECT DRACONID-OIL
	(IN PLAYER)
	(DESC "vial of draconid oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE DRACONID)
	(FLAGS TAKEBIT)>

<OBJECT CURSED-OIL
	(IN PLAYER)
	(DESC "vial of cursed oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE CURSED)
	(FLAGS TAKEBIT)>

<OBJECT ELEMENTA-OIL
	(IN PLAYER)
	(DESC "vial of elementa oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE ELEMENTA)
	(FLAGS TAKEBIT)>

<OBJECT HANGEDMANS-VENOM
	(IN PLAYER)
	(DESC "vial of hanged man's venom")
	(SYNONYM VIAL VENOM)
	(ADJECTIVE HANGED)
	(FLAGS TAKEBIT)>

<OBJECT OGROID-OIL
	(IN PLAYER)
	(DESC "vial of ogroid oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE OGROID)
	(FLAGS TAKEBIT)>

<OBJECT NECROPHAGE-OIL
	(IN PLAYER)
	(DESC "vial of necrophage oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE NECROPHAGE)
	(FLAGS TAKEBIT)>

<OBJECT SPECTER-OIL
	(IN PLAYER)
	(DESC "vial of specter oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE SPECTER)
	(FLAGS TAKEBIT)>
