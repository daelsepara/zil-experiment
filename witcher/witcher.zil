"ZIL Witcher"

<CONSTANT GAME-BANNER
"ZIL Witcher|
Experiments with ZIL|
By SD Separa (2020)|
|
Inspired by the Witcher Games by CD Projekt Red|">

<INSERT-FILE "parser">

<INSERT-FILE "witchergear">
<INSERT-FILE "continent">
<INSERT-FILE "objects">

<ROUTINE GO ()
	<INIT>
	<MAIN-LOOP>>

<ROUTINE INIT ()
	<CRLF><CRLF>
	<TELL "Once you were many. Now you are few. Hunters. Killers of the world's filth. Witchers. The ultimate killing machines. Among you, a legend, the one they call Geralt of Rivia, the White Wolf." CR CR "That legend is you." CR CR>
	<V-VERSION> <CRLF>
	<SETG HERE ,CAMP-SITE>
	<MOVE ,PLAYER ,HERE>
	<V-LOOK>>
