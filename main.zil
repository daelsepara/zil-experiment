"ZIL Experiment"

<CONSTANT GAME-BANNER
"ZIL Experiment |
Experiments with ZIL |
By SD Separa (2020)">

<INSERT-FILE "parser">

<SYNTAX OPEN OBJECT (FIND DOORBIT) (IN-ROOM) WITH
        OBJECT (FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CARRIED HAVE) = V-OPEN>

<SYNTAX UNLOCK OBJECT (FIND DOORBIT) (IN-ROOM) WITH
        OBJECT (FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CARRIED HAVE) = V-OPEN>

<SYNTAX LOCK OBJECT (FIND DOORBIT) (IN-ROOM) WITH
        OBJECT (FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CARRIED HAVE) = V-LOCK>

<SYNTAX CLOSE OBJECT (FIND DOORBIT) (IN-ROOM) WITH
        OBJECT (FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CARRIED HAVE) = V-LOCK>

<SYNONYM WITH USING>

<ROUTINE GO ()
	<INIT>
	<MAIN-LOOP>>

<ROUTINE INIT ()
	<CRLF><CRLF>
	<TELL "One night, you dream that you are transported to a video game." CR CR>
	<V-VERSION> <CRLF>
	<SETG HERE ,MAIN-ROOM>
	<MOVE ,PLAYER ,HERE>
	<V-LOOK>>
  
<ROOM MAIN-ROOM
	(LOC ROOMS)
	(DESC "Main Hallway")
	(LDESC "There are exits to the north, south, east, and west.")
	(EAST TO PORTAL-ROOM)
	(WEST TO STORAGE-ROOM)
	(SOUTH TO LIVING-ROOM)
	(NORTH TO ARMORY-ROOM)
	(FLAGS RLANDBIT LIGHTBIT)>

<ROOM STORAGE-ROOM
	(LOC ROOMS)
	(DESC "Storage Room")
	(LDESC "The exit to the east leads you back to the main hallway.")
	(EAST TO MAIN-ROOM)
	(FLAGS RLANDBIT LIGHTBIT)>

<ROOM ARMORY-ROOM
	(LOC ROOMS)
	(DESC "Armory")
	(LDESC "The exit to the south leads you back to the main hallway.")
	(SOUTH TO MAIN-ROOM)
	(ACTION ARMORY-ROOM-F)
	(FLAGS RLANDBIT)>

<ROOM PORTAL-ROOM
	(LOC ROOMS)
	(DESC "Portal Room")
	(LDESC "The exit to the west leads you back to the main hallway. You feel that there is something beyond the door to the east.")
	(WEST TO MAIN-ROOM)
	(EAST TO EXIT-ROOM IF DOOR IS OPEN ELSE "The exit portal is locked.")
	(FLAGS RLANDBIT LIGHTBIT)>

<ROOM LIVING-ROOM
	(LOC ROOMS)
	(DESC "Living Room")
	(LDESC "The exit to the north leads you back to the main hallway.")
	(NORTH TO MAIN-ROOM)
	(FLAGS RLANDBIT LIGHTBIT)>

<ROOM EXIT-ROOM
	(LOC ROOMS)
	(DESC "Place beyond time and space")
	(ACTION EXIT-ROOM-F)
	(FLAGS RLANDBIT LIGHTBIT)>

<OBJECT KEY
	(IN STORAGE-ROOM)
	(DESC "small silver key")
	(SYNONYM KEY)
	(ADJECTIVE SMALL SILVER)
	(ACTION KEY-F)
	(FLAGS TAKEBIT TOOLBIT)>

<OBJECT LAMP
	(IN LIVING-ROOM)
	(DESC "small brass lamp")
	(SYNONYM LAMP LANTERN LIGHT)
	(ADJECTIVE SMALL BRASS)
	(FLAGS TAKEBIT LIGHTBIT ONBIT)>

<OBJECT DOOR
	(IN PORTAL-ROOM)
	(DESC "large steel door")
	(SYNONYM DOOR)
	(ADJECTIVE LARGE STEEL)
	(FLAGS DOORBIT)>

<ROUTINE KEY-F ()
	<COND (<AND <EQUAL? ,HERE ,PORTAL-ROOM> <EQUAL? ,PRSO ,DOOR> <EQUAL? ,PRSI ,KEY>>
		<COND (<VERB? OPEN>
			<TELL "The large steel door unlocks with a loud screeching sound.">
			<FSET ,DOOR ,OPENBIT>)
		(ELSE <VERB? LOCK>
			<TELL "The large steel door closes!">
			<FCLEAR ,DOOR ,OPENBIT>)>
	)>>  

<ROUTINE ARMORY-ROOM-F (RARG)
	<COND (<==? .RARG ,M-ENTER>
		<COND (<FSET? ,LAMP ,ONBIT>
			<FSET ,ARMORY-ROOM ,ONBIT>)
	(ELSE <FCLEAR ,ARMORY-ROOM ,ONBIT>)>)>>

<ROUTINE EXIT-ROOM-F (RARG)
	<COND (<==? .RARG ,M-ENTER><V-LOOK>)>
	<TELL CRLF>
	<JIGS-UP "You wake up from the dream.">>
