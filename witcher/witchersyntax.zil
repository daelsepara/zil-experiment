<SYNTAX ACCEPT OBJECT (FIND BOUNTYBIT) (IN-ROOM) FROM OBJECT (FIND PERSONBIT) (IN-ROOM ON-GROUND) = V-ACCEPT-BOUNTY>
<SYNTAX ADD OBJECT (HAVE HELD CARRIED) TO OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-APPLY-OIL>
<SYNTAX APPLY OBJECT (HAVE HELD CARRIED) ON OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-APPLY-OIL>
<SYNTAX APPLY OBJECT (HAVE HELD CARRIED) TO OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-APPLY-OIL>
<SYNTAX APPLY OBJECT (HAVE HELD CARRIED) ONTO OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-APPLY-OIL>
<SYNTAX ASK OBJECT (IN-ROOM) (FIND PERSONBIT) ABOUT OBJECT (ON-GROUND IN-ROOM) (FIND BOUNTYBIT) = V-TALK>
<SYNTAX ATTACK OBJECT (IN-ROOM) (FIND MONSTERBIT) WITH OBJECT (HAVE HELD CARRIED) (FIND WEAPONBIT) =  V-ATTACK-CHECK>
<SYNTAX ATTACK OBJECT (IN-ROOM) (FIND MONSTERBIT) USING OBJECT (HAVE HELD CARRIED) (FIND WEAPONBIT) =  V-ATTACK-CHECK>
<SYNTAX CLEAN OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-CLEAN-SWORD>
<SYNTAX BOMB OBJECT (IN-ROOM ON-GROUND) = V-DESTROY>
<SYNTAX COMBAT OBJECT (FIND MONSTERBIT) (IN-ROOM) USING OBJECT (FIND WEAPONBIT) (HAVE HELD CARRIED)  = V-RELENTLESS-ASSAULT>
<SYNTAX COMBAT = V-COMBAT-MODE>
<SYNTAX CONSULT OBJECT (FIND CODEXBIT) (IN-ROOM ON-GROUND) ABOUT OBJECT (FIND TOPICBIT) (IN-ROOM ON-GROUND) = V-READ-CODEX>
<SYNTAX CONSULT OBJECT (FIND CODEXBIT) (IN-ROOM ON-GROUND) ON OBJECT (FIND TOPICBIT) (IN-ROOM ON-GROUND) = V-READ-CODEX>
<SYNTAX DESTROY OBJECT (IN-ROOM ON-GROUND) = V-DESTROY>
<SYNTAX USE OBJECT (HAVE HELD CARRIED) = V-DRINK>
<SYNTAX EAT = V-WITCHER-EAT>
<SYNTAX EXAMINE OBJECT (FIND TOPICBIT) = V-EXAMINE-TOPIC>
<SYNTAX EXAMINE OBJECT (IN-ROOM ON-GROUND) = V-LOOK-CLOSELY>
<SYNTAX EXITS = V-EXITS>
<SYNTAX JOURNAL = V-WITCHER-JOURNAL>
<SYNTAX LOOK AT OBJECT (FIND TOPICBIT) = V-LOOK-TOPIC>
<SYNTAX MEDITATE = V-MEDITATE>
<SYNTAX PUT OBJECT (HAVE HELD CARRIED) ON OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-APPLY-OIL>
<SYNTAX READ OBJECT (FIND CODEXBIT) (IN-ROOM ON-GROUND) ABOUT OBJECT (FIND READBIT) (IN-ROOM ON-GROUND) = V-READ-CODEX>
<SYNTAX READ OBJECT (FIND CODEXBIT) (IN-ROOM ON-GROUND) ON OBJECT (FIND READBIT) (IN-ROOM ON-GROUND) =  V-READ-CODEX>
<SYNTAX READ OBJECT (FIND READBIT) = V-READ PRE-REQUIRES-LIGHT>
<SYNTAX READ JOURNAL OBJECT (FIND KLUDGEBIT)= V-WITCHER-JOURNAL>
<SYNTAX RIDE OBJECT (IN-ROOM ON-GROUND) (FIND VEHBIT) = V-RIDE>
<SYNTAX REMOVE OBJECT (HELD CARRIED HAVE) FROM OBJECT (FIND SURFACEBIT) (HELD CARRIED HAVE) = V-REMOVE-OIL>
<SYNTAX REPORT TO OBJECT (IN-ROOM) (FIND PERSONBIT) = V-REPORT-QUEST>
<SYNTAX REPORT TO OBJECT (IN-ROOM) (FIND PERSONBIT) ABOUT OBJECT (ON-GROUND IN-ROOM) (FIND BOUNTYBIT) = V-REPORT-QUEST>
<SYNTAX REPORT OBJECT (ON-GROUND IN-ROOM) (FIND BOUNTYBIT) TO OBJECT (IN-ROOM) (FIND PERSONBIT) = V-REPORT-QUEST>
<SYNTAX ROACH = V-SUMMON>
<SYNTAX SUMMON OBJECT (FIND VEHBIT)= V-SUMMON>
<SYNTAX SPEAK WITH OBJECT (IN-ROOM) (FIND PERSONBIT) ABOUT OBJECT (ON-GROUND IN-ROOM) (FIND BOUNTYBIT) = V-TALK>
<SYNTAX SPEAK WITH OBJECT (IN-ROOM) (FIND PERSONBIT) = V-TALK>
<SYNTAX SCORE = V-WITCHER-SCORE>
<SYNTAX STATUS = V-WITCHER-STATUS>
<SYNTAX TALK TO OBJECT (IN-ROOM) (FIND PERSONBIT) ABOUT OBJECT (ON-GROUND IN-ROOM) (FIND BOUNTYBIT) = V-TALK>
<SYNTAX TALK TO OBJECT (IN-ROOM) (FIND PERSONBIT) = V-TALK>
<SYNTAX UNMOUNT = V-UNMOUNT>
<SYNTAX WAIT = V-WAIT-CHECK>
<SYNTAX WAIT UNTIL OBJECT = V-WAIT-UNTIL>

<SYNONYM PUT ADD APPLY POUR>
<SYNONYM RIDE MOUNT>
<SYNONYM SPEAK CHAT>
<SYNONYM STATUS DIAGNOSE INFO>
<SYNONYM TAKE GATHER>
<SYNONYM UNMOUNT DISMOUNT>

; Fight to death
<SYNTAX CONTINOUSLY ATTACK OBJECT (FIND MONSTERBIT) (IN-ROOM) WITH OBJECT (FIND WEAPONBIT) (IN-ROOM)  = V-RELENTLESS-ASSAULT>
<SYNTAX CONTINOUSLY ATTACK OBJECT (FIND MONSTERBIT) (IN-ROOM) USING OBJECT (FIND WEAPONBIT) (IN-ROOM)  = V-RELENTLESS-ASSAULT>
<SYNTAX KEEP ATTACKING OBJECT (FIND MONSTERBIT) (IN-ROOM) USING OBJECT (FIND WEAPONBIT) (IN-ROOM)  = V-RELENTLESS-ASSAULT>
<SYNTAX KEEP ATTACKING OBJECT (FIND MONSTERBIT) (IN-ROOM) WITH OBJECT (FIND WEAPONBIT) (IN-ROOM)  = V-RELENTLESS-ASSAULT>
<SYNONYM CONTINOUSLY CONSTANTLY DOGGEDLY ENDLESSLY FURIOUSLY TENACIOUSLY REPEATEDLY RELENTLESSLY TIRELESSLY UNCEASINGLY UNRELENGTINGLY>
<SYNONYM ATTACK ASSAULT CUT FIGHT HIT SLASH STRIKE SLICE>
<SYNONYM ATTACKING ASSAULTING CUTTING FIGHTING HITTING SLASHING STRIKING SLICING>