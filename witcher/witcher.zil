"ZIL Witcher"

<CONSTANT GAME-BANNER "ZIL Witcher|Experiments with ZIL|By SD Separa (2020)||Inspired by the Witcher Games by CD Projekt Red|">
<CONSTANT RELEASEID 1>
<VERSION 8>

<INSERT-FILE "parser">

<INSERT-FILE "witcherglobals">
<INSERT-FILE "witchersyntax">
<INSERT-FILE "witcherverbs">
<INSERT-FILE "geralt.zil">
<INSERT-FILE "witchergear">
<INSERT-FILE "continent">
<INSERT-FILE "objects">
<INSERT-FILE "roach">
<INSERT-FILE "witcherevents">
<INSERT-FILE "monsters">
<INSERT-FILE "bounties">
<INSERT-FILE "npc">
<INSERT-FILE "codex">

<ROUTINE GO ()
	<INIT>
	<MAIN-LOOP>>

<ROUTINE DRAW-LINE ()
	<TELL "------------------------------------------------------" CR>>

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
	<START-DAY-NIGHT-CYCLE>
	<START-EATING-CYCLE>
	<SETG WITCHER-HEALTH WITCHER-MAX-HEALTH>>
