"ZIL Witcher"

<CONSTANT GAME-BANNER "Geralt, the Professional|By SD Separa (2020)||Inspired by the Witcher Games by CD Projekt Red|">
<CONSTANT RELEASEID 1>
<VERSION XZIP>

<INSERT-FILE "parser">

<USE "template">

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
<INSERT-FILE "witcherfu">

<ROUTINE GO ()
	<INIT>
	<MAIN-LOOP>>

<ROUTINE DRAW-LINE ()
	<TELL "------------------------------------------------------" CR>>

<ROUTINE INIT ()
	<CRLF><CRLF><CRLF>
	<INIT-STATUS-LINE>
	<V-VERSION>
	<CRLF>
	<DRAW-LINE>
	<TELL "Once you were many. Now you are few. Hunters. Killers of the world's filth. Witchers. The ultimate killing machines. Among you, a legend, the one they call Geralt of Rivia, the White Wolf.||That legend is you. This world does not need a hero. It needs a professional." CR CR>
	<DRAW-LINE>
	<CRLF>
	<SETG HERE ,CAMP-SITE>
	<SETG LAST-LOC ,HERE>
	<MOVE ,PLAYER ,HERE>
	<MOVE ,ROACH ,HERE>
	<FSET ,HERE ,TOUCHBIT>
	<V-LOOK>
	<START-DAY-NIGHT-CYCLE>
	<SETG WITCHER-HEALTH ,WITCHER-MAX-HEALTH>>
