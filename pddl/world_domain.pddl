(define (domain world)
(:requirements :strips :equality :typing :fluents :durative-actions)

(:types
  person
  robot
  item
  door
  gripper
  room corridor door_nearby - location
)

(:predicates
  (connected ?l1 ?l2 - location)
  (connected_door ?l1 ?l2 - location ?d - door)
  (door_opened ?d - door)
  (door_closed ?d - door)
  (door_at ?d - door ?l - location)
  (object_at ?i - item ?r - room)
  (robot_at ?b - robot ?l - location)
  (gripper_at ?g - gripper ?b - robot)
  (gripper_free ?g - gripper)
  (robot_carry ?b - robot ?i - item ?g - gripper)
)

(:action open_door
  :parameters (?b - robot ?d - door ?l - location)
  :precondition
    (and
      (robot_at ?b ?l) 
      (door_closed ?d)
    )
  :effect 
    (and
      (door_opened ?d)
    )
)

(:action move_robot
  :parameters (?b - robot ?l1 ?l2 - location)
  :precondition 
    (and
      (robot_at ?b ?l1)
      (connected ?l1 ?l2)
    )
  :effect 
    (and 
      (robot_at ?b ?l2)
      (not (robot_at ?b ?l1))
    )
) 

(:action cross
  :parameters (?b - robot ?l1 ?l2 - location ?d - door)
  :precondition
    (and
      (door_at ?d ?l1)
      (door_at ?d ?l2)
      (connected_door ?l1 ?l2 ?d)
      (robot_at ?b ?l1)
      (door_opened ?d)
    )
  :effect 
    (and
      (not (robot_at ?b ?l1))
      (robot_at ?b ?l2)
    )
)

(:action pick_object
  :parameters (?i - item ?r - room ?b - robot ?g - gripper)
  :precondition 
    (and
      (object_at ?i ?r)
      (robot_at ?b ?r)
      (gripper_at ?g ?b)
      (gripper_free ?g)
    )
  :effect 
    (and 
      (robot_carry ?b ?i ?g)
      (not (object_at ?i ?r))
      (not (gripper_free ?g))
    )
)

(:action arrange_object
  :parameters (?i - item ?r - room ?b - robot ?g - gripper)
  :precondition 
    (and 
      (gripper_at ?g ?b)
      (robot_at ?b ?r)
      (robot_carry ?b ?i ?g)
    )
  :effect 
    (and 
      (object_at ?i ?r)
      (gripper_free ?g)
      (not (robot_carry ?b ?i ?g))
    )
)

)

