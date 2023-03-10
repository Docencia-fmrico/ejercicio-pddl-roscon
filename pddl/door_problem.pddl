; añadir door_at en predicates
; cuando sepamos como es la casa habra que cambiar algun connect
(define (problem door_problem)
    (:domain world_domain)

    (:objects
        gripper - gripper
        tiago - robot
        pijama - item
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
        (connected corridor_d3 corridor)
        (connected corridor corridor_d3)
        (connected corridor corridor_d2)
        (connected corridor_d2 corridor)
        (connected surgery_room surgery_room_d3)
        (connected surgery_room_d3 surgery_room)

        (connected bedroom_d1 bedroom_d2)
        (connected bedroom_d2 bedroom_d1)
        
        (connected uci corridor)
        (connected corridor uci)
        (connected living_room corridor)
        (connected corridor living_room)

        (door_closed door1)
        (door_closed door2)
        (door_closed door3)

        (robot_at tiago uci)
        (gripper_free gripper)

        (object_at pijama bathroom)

        (granny_at bedroom Granny)
        (open_door_req door1 Granny)
        ;(no_human_request Granny)

        (object_place pijama bedroom)

    )

    (:goal
        (and  
          (object_at pijama bedroom) 
          (robot_at tiago surgery_room)
          (no_human_request Granny)
        )
    )
)