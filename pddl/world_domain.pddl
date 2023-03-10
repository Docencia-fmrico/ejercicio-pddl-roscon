(define (domain world_domain)
(:requirements :strips :equality :typing :durative-actions :fluents :duration-inequalities)

(:types
  person
  robot
  item
  door
  gripper
  location
)

(:predicates
  (robot_at ?r - robot ?l - location)
  (object_at ?i - item ?l - location)
  (object_place ?i - item ?l - location)
  
  (gripper_free ?g - gripper)
  
  (connected ?l1 ?l2 - location)
  (connected_door ?l1 ?l2 - location ?d - door)
  (door_opened ?d - door)
  (door_closed ?d - door)

  (no_human_request ?p - person)
  (open_door_req ?d - door ?p - person)
  (close_door_req ?d - door ?p - person)
  (arr_obj_req ?i - item ?p - person)

  (object_at_granny ?i - item)
  (granny_at ?l - location ?p - person)
)

(:constants On_gripper - location Granny - person)

(:durative-action open_door
  :parameters (?r - robot ?d - door ?l1 ?l2 - location)
  :duration (= ?duration 5)
  :condition
    (and
      (at start(connected_door ?l1 ?l2 ?d))
      (over all(robot_at ?r ?l1))
      (at start(door_closed ?d))
    )
  :effect 
    (and
      (at end(door_opened ?d))
      (at start(not(door_closed ?d)))
    )
)

(:durative-action close_door
  :parameters (?r - robot ?d - door ?l1 ?l2 - location)
  :duration (= ?duration 5)
  :condition
    (and
      (at start(connected_door ?l1 ?l2 ?d))
      (over all(robot_at ?r ?l1))
      (at start(door_opened ?d))
    )
  :effect 
    (and
      (at end(door_closed ?d))
      (at start(not(door_opened ?d)))
    )
)

(:durative-action move_robot ; Locations connected without door
  :parameters (?r - robot ?l1 ?l2 - location)
  :duration (= ?duration 5)
  :condition 
    (and
      (at start(robot_at ?r ?l1))
      (at start(connected ?l1 ?l2))
    )
  :effect 
    (and 
      (at end(robot_at ?r ?l2)) 
      (at start(not (robot_at ?r ?l1)))
    )
) 

(:durative-action cross ; Locations connected by door
  :parameters (?r - robot ?l1 ?l2 - location ?d - door)
  :duration (= ?duration 5)
  :condition
    (and
      (at start(robot_at ?r ?l1))
      (at start(connected_door ?l1 ?l2 ?d))
      (at start(door_opened ?d))
    )
  :effect 
    (and
      (at end(robot_at ?r ?l2)) 
      (at start(not (robot_at ?r ?l1)))
    )
)

(:durative-action pick_object
  :parameters (?i - item ?l - location ?r - robot ?g - gripper)
  :duration (= ?duration 5)
  :condition 
    (and
      (over all(robot_at ?r ?l))
      (at start(object_at ?i ?l))
      (at start(gripper_free ?g))
    )
  :effect 
    (and
      (at end(not (object_at ?i ?l)))
      (at end(object_at ?i On_gripper))
      (at start(not (gripper_free ?g)))
    )
)

(:durative-action arrange_object ; Leave object only on its place
  :parameters (?r - robot ?i - item ?l - location ?g - gripper)
  :duration (= ?duration 5)
  :condition 
    (and 
      (over all(no_human_request Granny))
      (at start(object_at ?i On_gripper))
      (over all(robot_at ?r ?l))
      (at start(object_place ?i ?l))
    )
  :effect 
    (and
      (at start(not(object_at ?i On_gripper)))
      (at end(object_at ?i ?l))
      (at end(gripper_free ?g))
    )
)

(:durative-action give_object ; Leave object on any location
    :parameters (?r - robot ?i - item ?l - location ?g - gripper)
    :duration (= ?duration 5)
    :condition (and
        (at start (arr_obj_req ?i Granny))
        (at start(granny_at ?l Granny))
        (at start(object_at ?i On_gripper))
        (over all(robot_at ?r ?l))
    )
    :effect (and 
        (at start(not(object_at ?i On_gripper)))
        (at end(object_at ?i ?l))
        (at end(gripper_free ?g))
        (at end(object_at_granny ?i))
    )
)

;########## REQUESTS ##########
(:durative-action request_open_door
    :parameters (?d - door ?p - person)
    :duration (= ?duration 5)
    :condition (and 
        (at start (door_opened ?d))
        (at start (open_door_req ?d ?p))
    )
    :effect (and
        (at end (no_human_request ?p))
        (at start (not (open_door_req ?d ?p)))
    )
)

(:durative-action request_close_door
    :parameters (?d - door ?p - person)
    :duration (= ?duration 5)
    :condition (and 
        (at start (door_closed ?d))
        (at start (close_door_req ?d ?p))
    )
    :effect (and 
        (at end (no_human_request ?p))
        (at start (not (close_door_req ?d ?p)))
    )
)

(:durative-action request_arrange_obj
    :parameters (?i - item ?p - person)
    :duration (= ?duration 5)
    :condition (and 
        (at start (object_at_granny ?i))
        (at start (arr_obj_req ?i ?p))
    )
    :effect (and 
        (at end (no_human_request ?p))
        (at start (not (arr_obj_req ?i ?p)))
    )
)

)