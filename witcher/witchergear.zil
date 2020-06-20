"Witcher swords"

<OBJECT SILVER-SWORD
	(IN PLAYER)
	(DESC "silver sword")
	(SYNONYM SWORD SWORDS)
	(ADJECTIVE SILVER)
	(HIT-DAMAGE 50)
	(LOW-DAMAGE 10)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT CONTBIT SURFACEBIT OPENBIT WEAPONBIT)>

<OBJECT STEEL-SWORD
	(IN PLAYER)
	(DESC "steel sword")
	(SYNONYM SWORD SWORDS)
	(ADJECTIVE STEEL)
	(HIT-DAMAGE 50)
	(LOW-DAMAGE 10)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT CONTBIT SURFACEBIT OPENBIT WEAPONBIT)>

;----------------------
"Witcher accessories"

<OBJECT WOLF-MEDALLION
	(IN PLAYER)
	(DESC "wolf medallion")
	(SYNONYM MEDALLION MEDAL)
	(ADJECTIVE WOLF)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT WEARBIT WORNBIT)>

;----------------------
"Oils"

<OBJECT BEAST-OIL
	(IN PLAYER)
	(DESC "vial of beast oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE BEAST)
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

<OBJECT DRACONID-OIL
	(IN PLAYER)
	(DESC "vial of draconid oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE DRACONID)
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

<OBJECT HYBRID-OIL
	(IN PLAYER)
	(DESC "vial of hybrid oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE HYBRID)
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

<OBJECT NECROPHAGE-OIL
	(IN PLAYER)
	(DESC "vial of necrophage oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE NECROPHAGE)
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

<OBJECT RELICT-OIL
	(IN PLAYER)
	(DESC "vial of relict oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE RELICT)
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

<OBJECT VAMPIRE-OIL
	(IN PLAYER)
	(DESC "vial of vampire oil")
	(SYNONYM VIAL OIL)
	(ADJECTIVE VAMPIRE)
	(BONUS-DAMAGE 50)
	(ACTION GEAR-META-F)
	(FLAGS TAKEBIT)>

<ROUTINE GEAR-META-F ()
	<COND (<VERB? EXAMINE>
		<V-LOOK-CLOSELY>
	)>>
