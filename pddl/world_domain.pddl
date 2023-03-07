(define (domain world)
(:requirements :strips :equality :typing :fluents :durative-actions)

(:types
  person
  robot
  item
  door
  gripper
  location
)

(:predicates
  (connected ?l1 ?l2 - location)
  (connected_door ?l1 ?l2 - location ?d - door)
  (door_opened ?d - door)
  (door_closed ?d - door)
  (door_at ?d - door ?l - location)
  (object_at ?i - item ?l - location)
  (robot_at ?r - robot ?l - location)
  (gripper_at ?g - gripper ?r - robot)
  (gripper_free ?g - gripper)
  (gripper_busy ?g - gripper)
  (robot_carry ?r - robot ?i - item ?g - gripper)
)

(:action open_door
  :parameters (?r - robot ?d - door ?l - location)
  :precondition
    (and
      (robot_at ?r ?l) 
      (door_closed ?d)
    )
  :effect 
    (and
      (door_opened ?d)
      (not (door_closed ?d))
    )
)

(:action move_robot
  :parameters (?r - robot ?l1 ?l2 - location)
  :precondition 
    (and
      (robot_at ?r ?l1)
      (connected ?l1 ?l2)
    )
  :effect 
    (and 
      (robot_at ?r ?l2)
      (not (robot_at ?r ?l1))
    )
) 

(:action move_object
  :parameters (?r - robot ?l1 ?l2 - location ?i - item ?g - gripper)
  :precondition 
    (and
      (robot_at ?r ?l1)
      (connected ?l1 ?l2)
      (gripper_busy ?g)
      (object_at ?i ?l1)
      (robot_carry ?r ?i ?g)
    )
  :effect 
    (and 
      (robot_at ?r ?l2)
      (not (robot_at ?r ?l1))
      (not (object_at ?i ?l1))
      (object_at ?i ?l2)
    )
) 

(:action cross
  :parameters (?r - robot ?l1 ?l2 - location ?d - door)
  :precondition
    (and
      (door_at ?d ?l1)
      (door_at ?d ?l2)
      (connected_door ?l1 ?l2 ?d)
      (robot_at ?r ?l1)
      (door_opened ?d)
    )
  :effect 
    (and
      (not (robot_at ?r ?l1))
      (robot_at ?r ?l2)
    )
)

(:action pick_object
  :parameters (?i - item ?l - location ?r - robot ?g - gripper)
  :precondition 
    (and
      (object_at ?i ?l)
      (robot_at ?r ?l)
      (gripper_at ?g ?r)
      (gripper_free ?g)
    )
  :effect 
    (and 
      (robot_carry ?r ?i ?g)
      (not (gripper_free ?g))
      (gripper_busy ?g)
    )
)

(:action arrange_object
  :parameters (?i - item ?l - location ?r - robot ?g - gripper)
  :precondition 
    (and 
      (gripper_at ?g ?r)
      (robot_at ?r ?l)
      (robot_carry ?r ?i ?g)
      (gripper_busy ?g)
    )
  :effect 
    (and 
      (object_at ?i ?l)
      (gripper_free ?g)
      (not (robot_carry ?r ?i ?g))
      (not (gripper_busy ?g))
    )
)

)

