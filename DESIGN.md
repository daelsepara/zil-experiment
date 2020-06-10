# Design Goals

In ZIL, there are mostly two types of things that are often dealt with: *objects* and *rooms*. In this simple game, we wanted these features:

- A room that is dark unless the player carries some kind of light, e.g. lamp, lantern
- A room with a locked door. It must be unlocked with a key
- A room where the game ends upon the player's entry. This room is accessible **only** through the unlocked door
- objects that can be picked-up
- objects that can't be picked-up, i.e. the locked door

# Objects

There are 3 objects in the game
- small silver key
- small brass lamp
- large steel door

In the code, they are defined thus

```
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
	(FLAGS DOORBIT LOCKEDBIT OPENBIT)>
```

To specify whether the object can be carried, we add the **TAKEBIT**. Notice that the *DOOR* object cannot be carried and does not have the *TAKEBIT* flag defined. The *DOORBIT* flag indicates that the object is a door. *LOCKEDBIT* AND *OPENBIT* flags further add properties (locked or unlocked, open or closed) to the door. Objects should have at least one synonym (even if the same word is indicated as the synonym). The *ADJECTIVE* property allows the parser to indicate the correct object especially if several objects are present in the current location (or container). The *LOC* property sets the initial location of the objects.

*LIGHTBIT* and *ONBIT* are used to indicate that the object can provide light and that the object is turned on or switched on.

If we want the game to respond to various actions that can be performed with the object, we add an *ACTION* property and define the *ROUTINE* that handles it.

```
<ROUTINE KEY-F ()
	<COND (<AND <EQUAL? ,HERE ,PORTAL-ROOM> <EQUAL? ,PRSO ,DOOR> <EQUAL? ,PRSI ,KEY>>
		<COND (<VERB? OPEN>
			<TELL "The large steel door unlocks with a loud screeching sound.">
			<SETG DOOR-UNLOCKED T>
			<FCLEAR ,DOOR ,LOCKEDBIT>)
		(ELSE <VERB? LOCK>
			<TELL "The large steel door closes!">
			<SETG DOOR-UNLOCKED <>>
			<FSET ,DOOR ,LOCKEDBIT>)>
	)>>  
```

In this case, the silver key, can be used to unlock the steel door. Note that in the above code, the player must be in the Portal room and that the door must be unlocked or locked with the key. We set *LOCKEDBIT* property of the door depending on the action taken by the player (*OPEN*, *CLOSE*, *LOCK*, or *UNLOCK*). Also, we used a global variable *DOOR-UNLOCKED* that is set depending on whether or not the door is locked or unlocked with the key (see section on **ROOMS**).

# Rooms

Rooms are the other type of things that are frequently dealt with in ZIL.

In the game, there are 6 rooms:
- Main hallway
- Armory (initially dark)
- Storage room (room with the key)
- Living room (room with the lamp)
- Portal room (room with the door)
- Exit room (room beyond the door)

They are defined in the game as

```
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
	(EAST TO EXIT-ROOM IF DOOR-UNLOCKED ELSE "The exit portal is locked.")
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
```

Unlike objects, rooms are contained in a virtual object called *ROOMS*. In each room we can specify the exits towards the directions *NORTH*, *SOUTH*, *EAST*, *WEST*, *UP*, *DOWN*, *NE*, *NW*, *SE*, *SW*. In the Portal Room, we specify a conditional exit

```
(EAST TO EXIT-ROOM IF DOOR-UNLOCKED ELSE "The exit portal is locked.")
```

Exit to the east is only possible if *DOOR-UNLOCKED* is true (see previous section on **Objects**).

Like objects, if we want to handle specific actions or events in the room, we specify an *ACTION* routine

```
<ROUTINE ARMORY-ROOM-F (RARG)
	<COND (<==? .RARG ,M-ENTER>
		<COND (<FSET? ,LAMP ,ONBIT>
			<FSET ,ARMORY-ROOM ,ONBIT>)
	(ELSE <FCLEAR ,ARMORY-ROOM ,ONBIT>)>)>>

<ROUTINE EXIT-ROOM-F (RARG)
	<COND (<==? .RARG ,M-ENTER><V-LOOK>)>
	<TELL CRLF>
	<JIGS-UP "You wake up from the dream.">>
```

Here, we set the *ONBIT* property of the Armory room if he is carrying the lamp or leaves the lamp in the room. On the other hand, if the player manages to enter the exit room beyond the steel door, the game ends.

*JIGS-UP* is a special predicate that immediately ends the game with a message.

# Syntax

Although by default, the parser can handle player inputs, in the game, we need to explicitly handle the interaction between the door and the key
 
```
<SYNTAX OPEN OBJECT (FIND DOORBIT) (IN-ROOM) WITH
        OBJECT (FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CARRIED HAVE) = V-OPEN>

<SYNTAX UNLOCK OBJECT (FIND DOORBIT) (IN-ROOM) WITH
        OBJECT (FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CARRIED HAVE) = V-OPEN>

<SYNTAX LOCK OBJECT (FIND DOORBIT) (IN-ROOM) WITH
        OBJECT (FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CARRIED HAVE) = V-LOCK>

<SYNTAX CLOSE OBJECT (FIND DOORBIT) (IN-ROOM) WITH
        OBJECT (FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CARRIED HAVE) = V-LOCK>

<SYNONYM WITH USING>
```

The *SYNTAX* predicate allows you to define input patterns that guide the parser. For example, using *OPEN*, *UNLOCK*, *CLOSE*, *LOCK*, we tell the parser that the direct object (*PRSO*) needs to be a door and must be inside the *ROOM*. The indirect object (*PRSI*) must be a tool (*TOOLBIT*) and is inside the room or on the ground (*IN-ROOM*, *ON-GROUND*), carried or held by the player, or is in the player's inventory (*CARRIED*, *HELD*, *HAVE*). These allows the parser to handle the following inputs

```
open the door with the key
unlock the door with the key
close the door with the key
lock the door with the key
```

Finally, by defining *USING* to be a **SYNONYM** of *WITH*, we can also handle the following inputs

```
open the door using the key
unlock the door using the key
close the door using the key
lock the door using the key
```
