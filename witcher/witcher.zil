"ZIL Witcher"

<CONSTANT GAME-BANNER "ZIL Witcher|Experiments with ZIL|By SD Separa (2020)||Inspired by the Witcher Games by CD Projekt Red|">
<CONSTANT RELEASEID 1>
<VERSION 8>

<INSERT-FILE "parser">

<INSERT-FILE "witchergear">
<INSERT-FILE "continent">
<INSERT-FILE "objects">
<INSERT-FILE "roach">
<INSERT-FILE "codex">
<INSERT-FILE "witcherevents">

<GLOBAL WITCHER-FOOD 20>
<GLOBAL WITCHER-MAX-HEALTH 1000>
<GLOBAL WITCHER-HEALTH 0>
<GLOBAL WITCHER-EAT-TURNS 11>
<GLOBAL WITCHER-FATIGUE-RATE 100>
<GLOBAL WITCHER-HEALING-RATE 50>
<GLOBAL WITCHER-CONSUMPTION 1>
<GLOBAL HAS-FOOD <>>

<ROUTINE GO ()
	<INIT>
	<MAIN-LOOP>>

<ROUTINE DRAW-LINE ()
	<TELL "------------------------------------------------------" CR>>

<ROUTINE NOTHING-HAPPENS ()
	<TELL "Nothing happens." CR>>

<ROUTINE CANNOT-GO ()
	<TELL "Even with Roach, you can't go that way." CR>>
	
<ROUTINE DESCRIBE-LOCATION (LOC)
	<TELL <GETP .LOC ,P?LDESC> CR>>
	
<ROUTINE DESCRIBE-LOCATION-WHILE-RIDING (LOC)
	<TELL "... at the ">
	<HLIGHT ,H-BOLD>
	<TELL D .LOC>
	<HLIGHT 0>
	<CRLF>
	<CRLF>
	<DESCRIBE-LOCATION .LOC>>
	
<ROUTINE INIT ()
	<INIT-STATUS-LINE>
	<V-VERSION>
	<CRLF>
	<DRAW-LINE>
	<TELL "Once you were many. Now you are few. Hunters. Killers of the world's filth. Witchers. The ultimate killing machines. Among you, a legend, the one they call Geralt of Rivia, the White Wolf." CR CR "That legend is you." CR CR>
	<DRAW-LINE>
	<CRLF>
	<SETG HERE ,CAMP-SITE>
	<MOVE ,PLAYER ,HERE>
	<MOVE ,ROACH ,HERE>
	<V-LOOK>
	<QUEUE I-WITCHER-EAT ,WITCHER-EAT-TURNS>
	<SETG WITCHER-HEALTH ,WITCHER-MAX-HEALTH>>
