(define (domain world)
(:requirements :strips :equality :typing :fluents :durative-actions)

(:types
  location person robot item door - object
  granny - person
  room corridor door_nearby - location
)

(:predicates
  (connected ?l1 ?l2 - location)
  (connected_door ?l1 ?l2 - location ?d - door)
  (door_opened ?d - door)
  
  (object_at ?i - item ?r - room)

  (robot_at ?b - robot ?l - location)
  (robot_free ?b - robot)
  (robot_carry ?b - robot ?i - item)
)

(:action open_door
  :parameters (?b - robot ?d - door ?l - location)
  :precondition
    (and
      (robot ?b)
      (door ?d)
      (location ?l)

      (robot_at ?b ?l)   
      (not (door_opened ?d))
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
      (robot ?b)
      (location ?l1)
      (location ?l2)

      (robot_at ?b ?l1)
      (connected ?l1 ?l2)
    )
  :effect 
    (and 
      (robot_at ?r ?l2)
      (not (robot_at ?r ?l1))
    )
) 

(:action cross
  :parameters (?b - robot ?l1 ?l2 - location ?d - door)
  :precondition
    (and
      (robot ?b)
      (door ?d)
      (location ?l1)
      (location ?l2)

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
  :parameters (?i - item ?r - room ?b - robot)
  :precondition 
    (and
      (robot ?b)
      (item ?i)
      (location ?l1)
      (location ?l2)

      (object_at ?i ?r)
      (robot_at ?b ?r)
      (robot_free ?b)
    )
  :effect 
    (and 
      (robot_carry ?b ?i)
      (not (object_at ?i ?r))
      (not (robot_free ?b))
    )
)

(:action arrange_object
  :parameters (?i - item ?r - room ?b - robot)
  :precondition 
    (and 
      (robot ?b)
      (item ?i)
      (room ?r)
      
      (robot_at ?b ?r)
      (robot_carry ?b ?i)
    )
  :effect 
    (and 
      (object_at ?i ?r)
      (robot_free ?b)
      (not (robot_carry ?b ?i))
    )
)

)

