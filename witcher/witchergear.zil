<SYNTAX PUT OBJECT (HAVE HELD CARRIED) ON OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-APPLY-OIL>
<SYNTAX APPLY OBJECT (HAVE HELD CARRIED) ON OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-APPLY-OIL>
<SYNTAX APPLY OBJECT (HAVE HELD CARRIED) TO OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-APPLY-OIL>
<SYNTAX ADD OBJECT (HAVE HELD CARRIED) TO OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-APPLY-OIL>

<SYNONYM PUT APPLY POUR ADD>

<SYNTAX CLEAN OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-CLEAN-SWORD>
<SYNTAX REMOVE OBJECT (HELD CARRIED HAVE) FROM OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-REMOVE-OIL>

<ROUTINE APPLY-OIL (OIL SWORD)
	<TELL "You apply " T .OIL " onto " T .SWORD CR>>

<ROUTINE CANNOT-APPLY-OIL (OIL SWORD)
	<TELL "You cannot apply " T .OIL " to " T .SWORD ", or if you can, it will not be effective." CR>>

<ROUTINE REMOVE-AND-APPLY (OIL SWORD)
	<COND (<FIRST? .SWORD>
		<MOVE <FIRST? .SWORD> ,PLAYER>
	)>
	<MOVE .OIL .SWORD>
	<APPLY-OIL .OIL .SWORD>>

<ROUTINE V-APPLY-OIL ()
	<COND (<EQUAL? ,PRSI ,SILVER-SWORD ,STEEL-SWORD>
		<COND (<EQUAL? ,PRSI ,SILVER-SWORD>
			<COND (<EQUAL? ,PRSO ,VAMPIRE-OIL ,SPECTER-OIL ,OGROID-OIL ,NECROPHAGE-OIL ,ELEMENTA-OIL ,HYBRID-OIL ,RELICT-OIL ,DRACONID-OIL ,CURSED-OIL>
				<REMOVE-AND-APPLY ,PRSO ,PRSI>
			)(ELSE
				<CANNOT-APPLY-OIL ,PRSO ,PRSI>
			)>
		)(ELSE
			<COND (<EQUAL? ,PRSO ,HANGEDMANS-VENOM ,INSECTOID-OIL ,BEAST-OIL>
				<REMOVE-AND-APPLY ,PRSO ,PRSI>
			)(ELSE
				<CANNOT-APPLY-OIL ,PRSO ,PRSI>
			)>
		)>
	)(ELSE
		<NOTHING-HAPPENS>
	)>>

<ROUTINE V-CLEAN-SWORD ()
	<COND (<EQUAL? ,PRSO ,SILVER-SWORD ,STEEL-SWORD>
		<COND (<FIRST? ,PRSO>
			<TELL "You remove " T <FIRST? ,PRSO> " from the " T ,PRSO CR>
			<MOVE <FIRST? ,PRSO> ,PLAYER>
		)(ELSE
			<TELL CT ,PRSO " is quite clean." CR>
		)>
	)(ELSE
		<NOTHING-HAPPENS>
	)>>

<ROUTINE V-REMOVE-OIL ()
	<COND (<EQUAL? ,PRSI ,SILVER-SWORD ,STEEL-SWORD>
		<COND (<FIRST? ,PRSI>
			<COND (<EQUAL? ,PRSO <FIRST? ,PRSI>>
				<TELL "You remove " T <FIRST? ,PRSI> " from " T ,PRSI CR>
				<MOVE <FIRST? ,PRSI> ,PLAYER>
			)(ELSE
				<TELL CT ,PRSO " has not been applied to " T ,PRSI CR>
			)>
		)(ELSE
			<TELL CT ,PRSI " is quite clean." CR>
		)>
	)(ELSE
		<NOTHING-HAPPENS>
	)>>

<ROUTINE GEAR-META-F ()
	<COND (<VERB? EXAMINE>
		<V-LOOK-CLOSELY>
	)>>

<OBJECT SILVER-SWORD
	(IN PLAYER)
	(DESC "silver sword")
	(SYNONYM SWORD)
	(ADJECTIVE SILVER)
	(HIT-DAMAGE 50)
	(LOW-DAMAGE 10)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT CONTBIT SURFACEBIT OPENBIT WEAPONBIT)>

<OBJECT STEEL-SWORD
	(IN PLAYER)
	(DESC "steel sword")
	(SYNONYM SWORD)
	(ADJECTIVE STEEL)
	(HIT-DAMAGE 50)
	(LOW-DAMAGE 10)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT CONTBIT SURFACEBIT OPENBIT WEAPONBIT)>

<OBJECT WOLF-MEDALLION
	(IN PLAYER)
	(DESC "wolf medallion")
	(SYNONYM MEDALLION MEDAL)
	(ADJECTIVE WOLF)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT WEARBIT WORNBIT)>

<OBJECT VAMPIRE-OIL
	(IN PLAYER)
	(DESC "vial of vampire oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE VAMPIRE)
	(BONUS-DAMAGE 50)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT)>

<OBJECT RELICT-OIL
	(IN PLAYER)
	(DESC "vial of relict oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE RELICT)
	(BONUS-DAMAGE 50)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT)>

<OBJECT HYBRID-OIL
	(IN PLAYER)
	(DESC "vial of hybrid oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE HYBRID)
	(BONUS-DAMAGE 50)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT)>

<OBJECT BEAST-OIL
	(IN PLAYER)
	(DESC "vial of beast oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE BEAST)
	(BONUS-DAMAGE 50)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT)>

<OBJECT INSECTOID-OIL
	(IN PLAYER)
	(DESC "vial of insectoid oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE INSECTOID)
	(BONUS-DAMAGE 50)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT)>

<OBJECT DRACONID-OIL
	(IN PLAYER)
	(DESC "vial of draconid oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE DRACONID)
	(BONUS-DAMAGE 50)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT)>

<OBJECT CURSED-OIL
	(IN PLAYER)
	(DESC "vial of cursed oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE CURSED)
	(BONUS-DAMAGE 50)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT)>

<OBJECT ELEMENTA-OIL
	(IN PLAYER)
	(DESC "vial of elementa oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE ELEMENTA)
	(BONUS-DAMAGE 50)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT)>

<OBJECT HANGEDMANS-VENOM
	(IN PLAYER)
	(DESC "vial of hanged man's venom")
	(SYNONYM VIAL VENOM HANGED-MAN'S-VENOM)
	(ADJECTIVE HANGED HANGED-MAN'S)
	(BONUS-DAMAGE 50)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT)>

<OBJECT OGROID-OIL
	(IN PLAYER)
	(DESC "vial of ogroid oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE OGROID)
	(BONUS-DAMAGE 50)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT)>

<OBJECT NECROPHAGE-OIL
	(IN PLAYER)
	(DESC "vial of necrophage oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE NECROPHAGE)
	(BONUS-DAMAGE 50)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT)>

<OBJECT SPECTER-OIL
	(IN PLAYER)
	(DESC "vial of specter oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE SPECTER)
	(BONUS-DAMAGE 50)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT)>
