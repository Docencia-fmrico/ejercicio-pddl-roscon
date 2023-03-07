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

(:constants Table)

(:action open_door
  :parameters (?b - robot ?d - door ?l - location)
  :precondition
    (and
      (robot_at ?b ?l)   
      (not (door_opened ?d))
    )
  :effect 
    (and
      (door_opened ?d)
    )
)

(:action move_robot
  :parameters (?b - robot ?from ?to - location)
  :precondition 
    (and 
      (robot_at ?b ?from)
      (connected ?from ?to)
    )
  :effect 
    (and 
      (robot_at ?r ?to)
      (not (robot_at ?r ?from))
    )
)

(:action pick_object
  :parameters (?o - object ?l - location ?r - robot ?g - gripper)
  :precondition 
    (and
      (gripper_at ?g ?r)
      (object_at ?o ?l)
      (robot_at ?r ?l) 
      (gripper_free ?g)
    )
:effect 
  (and 
    (robot_carry ?r ?g ?o) 
    (not (object_at ?o ?l))
    (not (gripper_free ?g))
  )
)

(:action drop
:parameters (?o - object ?l - location ?r - robot ?g - gripper)
:precondition 
  (and 
    (gripper_at ?g ?r)
    (robot_at ?r ?l)
    (robot_carry ?r ?g ?o)
  )
:effect 
  (and 
    (object_at ?o ?l)
    (gripper_free ?g)
    (not (robot_carry ?r ?g ?o))
  )
)

)

