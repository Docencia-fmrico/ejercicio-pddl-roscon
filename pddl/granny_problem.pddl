; añadir door_at en predicates
; cuando sepamos como es la casa habra que cambiar algun connect
(define (problem housekeeping_1)
    (:domain world_domain)

    (:objects
        gripper - gripper
        tiago - robot
        towel scalpel magazine pyjama blanket - item
        bedroom bathroom living_room surgery_room uci corridor - location    
        main_corridor - corridor
        door1 door2 door3 - door
    )
    
    (:init
        (connected_door bathroom bedroom door1)
        (connected_door bedroom bathroom door1)
        (connected_door bedroom corridor door2)
        (connected_door corridor bedroom door2)
        (connected_door surgery_room corridor door3)
        (connected_door corridor surgery_room door3)
        (connected uci corridor)
        (connected corridor uci)
        (connected living_room uci)
        (connected uci living_room)

        (door_at door1 bathroom)
        (door_at door1 bedroom)
        (door_at door2 bedroom)
        (door_at door2 corridor)
        (door_at door3 corridor)
        (door_at door3 surgery_room)

        (door_opened door1)
        (door_closed door2)
        (door_opened door3)

        (robot_at tiago bedroom)
        (gripper_at gripper tiago)
        (gripper_free gripper)

        (object_at towel bathroom)
        (object_at scalpel surgery_room)
        (object_at magazine living_room)
        (object_at pyjama bedroom)
        (object_at blanket uci)
    )

    (:goal
        (and (object_at towel living_room) (robot_at tiago surgery_room))
    )
)
