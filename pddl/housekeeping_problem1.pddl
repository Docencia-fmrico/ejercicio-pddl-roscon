; añadir door_at en predicates
; cuando sepamos como es la casa habra que cambiar algun connect
(define (problem housekeeping_1))
    (:domain housekeeping)

    (:objects
        tiago - robot
        towel plate tool shoes blanket - items
        bedroom bathroom living_room kitchen garage - room    
        main_corridor - corridor
        door1 door2 door3 - door
    )
    
    (:init
        (connected kitchen living_room)
        (connected living_room kitchen)
        (connected_door bedroom main_corridor door1)
        (connected_door main_corridor bedroom door1)
        (connected_door bedroom bathroom door2)
        (connected_door bathroom bedroom door2)
        (connected_door garage living_room door3)
        (connected_door living_room garage door3)

        (door_at door1 bedroom)
        (door_at door1 main_corridor)
        (door_at door2 bedroom)
        (door_at door2 bathroom)
        (door_at door3 garage)
        (door_at door3 living_room)

        (door_opened door1)
        (door_opened door2)
        (door_opened door3)

        (robot_at tiago bedroom)
        (robot_free tiago)

        (object_at towel bathroom)
        (object_at plate kitchen)
        (object_at tool garage)
        (object_at shoes bedroom)
        (object_at blanket living_room)
    )