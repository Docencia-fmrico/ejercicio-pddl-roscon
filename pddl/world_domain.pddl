(define (domain world)
(:requirements :strips :equality :typing :fluents :durative-actions)

(:types
  Towels Plates Tools Clothing Blanket - object
  granny - person
  Bathroom kitchen Garage Bedroom Livingroom - location
  tiago - robot
  door
)
(:predicates
  (on ?x ?y)
  (clear ?x)
  (block ?b)

  (robot_at ?r - robot ?l - location)
  (object_at ?b - ball ?l - location)
  (gripper_free ?g - gripper)
  (gripper_at ?g - gripper ?r - robot)
  (robot_carry ?r - robot ?g - gripper ?o - ball)
  (connected ?l1 ?l2 - location ?d - door)

  (room ?r)
  (ball ?b)
  (gripper ?g)
  (at-robby ?r)
  (at ?b ?r)
  (free ?g)
  (carry ?o ?g)
)

(:constants Table)

(:action move_robot
  :parameters (?r - robot ?from ?to - location ?d - door)
  :precondition 
    (and 
      (robot_at ?r ?from)
      (connected ?from ?to ?d)
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

(:action move_object
  :parameters (?b ?from ?to)
  :precondition 
    (and 
      (block ?b) 
      (block ?to) 
      (clear ?b)
      (clear ?to)
      (on ?b ?from)
      (not (= ?b ?from))
      (not (= ?b ?to))
      (not (= ?from ?to))
    )
  :effect 
    (and 
      (on ?b ?to)
      (clear ?from)
      (not (on ?b ?from))
      (not (clear ?to))
    )
)

(:action move_to_table
  :parameters (?b ?x)
  :precondition 
    (and 
      (block ?b)
      (block ?x)
      (on ?b ?x)
      (clear ?b)
      (not (= ?b ?x))
    )
:effect 
  (and 
    (on ?b Table)
    (clear ?x)
    (not (on ?b ?x))
  )
)

)

