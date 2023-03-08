; añadir door_at en predicates
; cuando sepamos como es la casa habra que cambiar algun connect
(define (problem housekeeping_1)
    (:domain world_domain)

    (:objects
        gripper - gripper
        tiago - robot
        towel scalpel magazine pijama blanket - item
        bedroom bathroom living_room surgery_room uci corridor - location    
        bedroom_d1 bathroom_d1 bedroom_d2 corridor_d2 corridor_d3 surgery_room_d3 - location
        door1 door2 door3 - door
    )
    
    (:init
        (connected_door bathroom_d1 bedroom_d1 door1)
        (connected_door bedroom_d1 bathroom_d1 door1)
        (connected_door bedroom_d2 corridor_d2 door2)
        (connected_door corridor_d2 bedroom_d2 door2)
        (connected_door surgery_room_d3 corridor_d3 door3)
        (connected_door corridor_d3 surgery_room_d3 door3)

        (connected bathroom bathroom_d1)
        (connected bathroom_d1 bathroom)
        (connected bedroom bedroom_d1)
        (connected bedroom_d1 bedroom)
        (connected bedroom_d2 bedroom)
        (connected bedroom bedroom_d2)
        (connected corridor corridor_d2)
        (connected corridor_d2 corridor)
        (connected corridor_d3 corridor)
        (connected corridor corridor_d3)
        (connected surgery_room surgery_room_d3)
        (connected surgery_room_d3 surgery_room)

        (connected uci corridor)
        (connected corridor uci)
        (connected living_room corridor)
        (connected corridor living_room)

        (door_at door1 bathroom_d1)
        (door_at door1 bedroom_d1)
        (door_at door2 bedroom_d2)
        (door_at door2 corridor_d2)
        (door_at door3 corridor_d3)
        (door_at door3 surgery_room_d3)

        (door_closed door1)
        (door_closed door2)
        (door_closed door3)

        (robot_at tiago bedroom)
        (gripper_at gripper tiago)
        (gripper_free gripper)

        (object_at towel bathroom)
        (object_at scalpel surgery_room)
        (object_at magazine living_room)
        (object_at pijama bedroom)
        (object_at blanket uci)
    )

    (:goal
        (and (object_at towel living_room) (robot_at tiago surgery_room))
    )
)
