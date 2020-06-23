<OBJECT-TEMPLATE NPC =
    OBJECT
        (UNLOCKED-BY NONE)
        (FLAGS PERSONBIT NARTICLEBIT)>

<NPC WHITE-ORCHARD-ALDERMAN
    (IN WHITE-ORCHARD-TOWN)
    (DESC "The Alderman")
    (SYNONYM ALDERMAN)
    (ACTION WHITE-ORCHARD-ALDERMAN-F)>

<NPC WHITE-ORCHARD-FARMER
    (IN WHITE-ORCHARD-HUT)
    (DESC "Berthold (farmer)")
    (SYNONYM FARMER BERTHOLD)
    (ACTION WHITE-ORCHARD-FARMER-F)>

<NPC WHITE-ORCHARD-MERCHANT
    (IN WHITE-ORCHARD-TOWN)
    (DESC "Bram (merchant)")
    (SYNONYM MERCHANT BRAM)
    (ACTION WHITE-ORCHARD-MERCHANT-F)>

<NPC WHITE-ORCHARD-SMITH
    (IN WHITE-ORCHARD-TOWN)
    (DESC "Caesar (smith)")
    (SYNONYM SMITH BLACKSMITH CAESAR CESAR TEMYONG)
    (ACTION WHITE-ORCHARD-SMITH-F)>

<NPC WHITE-ORCHARD-ALCHEMIST
    (IN NORTH-OF-WHITE-ORCHARD)
    (DESC "Miguel (alchemist)")
    (SYNONYM ALCHEMIST MIGUEL MIGS)
    (ACTION WHITE-ORCHARD-ALCHEMIST-F)>

<NPC HUNTERS-WIFE
    (IN WEST-OF-WHITE-ORCHARD)
    (DESC "Lara")
    (SYNONYM LARA WIFE)
    (ADJECTIVE HUNTERS HUNTER)
    (ACTION HUNTERS-WIFE-F)>

<NPC ABANDONED-VILLAGE-ALDERMAN
    (IN ABANDONED-VILLAGE)
    (DESC "The Alderman")
    (SYNONYM ALDERMAN)
    (ADJECTIVE VILLAGE)
    (ACTION ABANDONED-VILLAGE-ALDERMAN-F)>

<NPC ODOLAN
    (IN ABANDONED-VILLAGE)
    (DESC "Odolan")
    (SYNONYM ODOLAN)
    (UNLOCKED-BY CONTRACT-GHOST-IN-THE-WELL)>

<ROUTINE WHITE-ORCHARD-ALDERMAN-F ()
    <QUEST-TALK ,BOUNTY-WHITE-ORCHARD ,WHITE-ORCHARD-ALDERMAN WHITE-ORCHARD-ALDERMAN-NEWS DEFAULT-GREETINGS WHITE-ORCHARD-ALDERMAN-REPORT QUEST-MONSTER>>

<ROUTINE WHITE-ORCHARD-FARMER-F ()
    <QUEST-TALK ,BOUNTY-WHITE-ORCHARD-INFESTATION ,WHITE-ORCHARD-FARMER FARMER-NEWS DEFAULT-GREETINGS FARMER-REPORT QUEST-MONSTER>>

<ROUTINE WHITE-ORCHARD-MERCHANT-F ()
    <MERCHANT ,WHITE-ORCHARD-MERCHANT <LTABLE DUMMY-FOOD DUMMY-BOMB> <LTABLE 10 50>>>

<ROUTINE WHITE-ORCHARD-SMITH-F ()
    <SMITH ,WHITE-ORCHARD-SMITH <LTABLE 50 50> <LTABLE 500 300>>>

<ROUTINE WHITE-ORCHARD-ALCHEMIST-F ()
    <MERCHANT ,WHITE-ORCHARD-ALCHEMIST
        <LTABLE CURSED-OIL HYBRID-OIL NECROPHAGE-OIL OGROID-OIL>
        <LTABLE 200 200 100 100>>>

<ROUTINE HUNTERS-WIFE-F ()
    <QUEST-TALK ,QUEST-MISSING-HUSBAND ,HUNTERS-WIFE MISSING-HUSBAND-NEWS MISSING-HUSBAND-GREETINGS MISSING-HUSBAND-REPORT QUEST-SEARCH>>

<ROUTINE ABANDONED-VILLAGE-ALDERMAN-F ()
    <QUEST-TALK ,CONTRACT-GHOST-IN-THE-WELL ,ABANDONED-VILLAGE-ALDERMAN ABANDONED-VILLAGE-NEWS DEFAULT-GREETINGS ABANDONED-VILLAGE-REPORT QUEST-MONSTER>>
