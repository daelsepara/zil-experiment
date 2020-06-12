<SYNTAX EXAMINE OBJECT (MANY) = V-CODEX>

<ROUTINE V-CODEX ()
	
	<TELL "You looked at the " D ,PRSO " closely and see that it is ">
	
	<COND (<EQUAL? ,PRSO ,ROACH>
		<TELL "a loyal and dependable horse that sometimes ends up in odd places." CR>
		<RTRUE>)
		
		(<EQUAL? ,PRSO ,SILVER-SWORD>
			<TELL "a weapon for killing creatures of magic." CR>
			<RTRUE>)
			
		(<EQUAL? ,PRSO ,STEEL-SWORD>
			<TELL "a weapon for killing non-magic creatures." CR>
			<RTRUE>)
		
		(<EQUAL? ,PRSO ,VAMPIRE-OIL ,SPECTER-OIL ,OGROID-OIL ,NECROPHAGE-OIL ,ELEMENTA-OIL ,HYBRID-OIL ,RELICT-OIL ,DRACONID-OIL ,CURSED-OIL ,HANGEDMANS-VENOM ,INSECTOID-OIL ,BEAST-OIL>
			<TELL "a type of oil for dealing with specific kinds of monsters." CR>
			<RTRUE>)
		
		(<EQUAL? ,PRSO ,WOLF-MEDALLION>
			<TELL "an amulet that can detect the presence of magic." CR>
			<RTRUE>)>
	<TELL "nothing special." CR>
	<RTRUE>>
