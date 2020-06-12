"ZIL Witcher"

<CONSTANT GAME-BANNER "ZIL Witcher|Experiments with ZIL|By SD Separa (2020)||Inspired by the Witcher Games by CD Projekt Red|">

<INSERT-FILE "parser">

<INSERT-FILE "witchergear">
<INSERT-FILE "continent">
<INSERT-FILE "objects">

<ROUTINE GO ()
	<INIT>
	<MAIN-LOOP>>

<ROUTINE DRAW-LINE ()
	<TELL "------------------------------------------------------" CR>>

<ROUTINE NOTHING-HAPPENS ()
	<TELL "Nothing happens." CR>>

<ROUTINE DESCRIBE-LOCATION ()
	<TELL <GETP ,HERE ,P?LDESC> CR>>

<ROUTINE INIT ()
	<V-VERSION>
	<CRLF>
	<DRAW-LINE>
	<TELL "Once you were many. Now you are few. Hunters. Killers of the world's filth. Witchers. The ultimate killing machines. Among you, a legend, the one they call Geralt of Rivia, the White Wolf." CR CR "That legend is you." CR CR>
	<DRAW-LINE>
	<CRLF>
	<SETG HERE ,CAMP-SITE>
	<MOVE ,PLAYER ,HERE>
	<V-LOOK>>
