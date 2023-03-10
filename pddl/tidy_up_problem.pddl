(define (problem tidy_up_problem)
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

        (granny_at bedroom Granny)

        (object_at towel uci)
        (object_at scalpel living_room)
        (object_at magazine bedroom)
        (object_at pijama surgery_room)
        (object_at blanket bathroom)

        (no_human_request Granny)

        (object_place towel bathroom)
        (object_place pijama bedroom)
        (object_place magazine living_room)
        (object_place blanket uci)
        (object_place scalpel surgery_room)

    )
    
    ; We want the robot to tidy up all the objects and put them in their correct place.
    ; After that, the robot should go to the bedroom.
    ; In this case, the Granny doesn't interfere in the planification. Granny does no requests.

    (:goal (and  
        (object_at towel bathroom)
        (object_at pijama bedroom)
        (object_at magazine living_room)
        (object_at blanket uci)
        (object_at scalpel surgery_room)
        (robot_at tiago bedroom)
        )
    )
)