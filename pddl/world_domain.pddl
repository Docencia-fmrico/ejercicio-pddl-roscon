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


(:durative-action open_door
  :parameters (?r - robot ?d - door ?l - location)
  :duration (= ?duration 5)
  :condition
    (and
      (at start(robot_at ?r ?l)) 
      (at start(door_at ?d ?l))
      (at start(door_closed ?d))
    )
  :effect 
    (and
      (at start(door_opened ?d))
      (at start(not(door_closed ?d)))
    )
)

(:durative-action move_robot
  :parameters (?r - robot ?l1 ?l2 - location)
  :duration (= ?duration 5)
  :condition 
    (and
      (at start(robot_at ?r ?l1))
      (at start(connected ?l1 ?l2))
    )
  :effect 
    (and 
      (at start(robot_at ?r ?l2))
      (at start(not (robot_at ?r ?l1)))
    )
) 

(:durative-action move_object
  :parameters (?r - robot ?l1 ?l2 - location ?i - item ?g - gripper)
  :duration (= ?duration 5)
  :condition 
    (and
      (at start (robot_at ?r ?l1))
      (at start (connected ?l1 ?l2))
      (at start (gripper_busy ?g))
      (at start (object_at ?i ?l1))
      (at start (robot_carry ?r ?i ?g))
    )
  :effect 
    (and 
      (at start(robot_at ?r ?l2))
      (at start(not (robot_at ?r ?l1)))
      (at start(not (object_at ?i ?l1)))
      (at start(object_at ?i ?l2))
    )
) 

(:durative-action cross
  :parameters (?r - robot ?l1 ?l2 - location ?d - door)
  :duration (= ?duration 5)
  :condition
    (and
      (at start(door_at ?d ?l1))
      (at start(door_at ?d ?l2))
      (at start(connected_door ?l1 ?l2 ?d))
      (at start(robot_at ?r ?l1))
      (at start(door_opened ?d))
    )
  :effect 
    (and
      (at start(not (robot_at ?r ?l1)))
      (at start(robot_at ?r ?l2))
    )
)

(:durative-action pick_object
  :parameters (?i - item ?l - location ?r - robot ?g - gripper)
  :duration (= ?duration 5)
  :condition 
    (and
      (at start(object_at ?i ?l))
      (at start(robot_at ?r ?l))
      (at start(gripper_at ?g ?r))
      (at start(gripper_free ?g))
    )
  :effect 
    (and 
      (at start(robot_carry ?r ?i ?g))
      (at start(not (gripper_free ?g)))
      (at start(gripper_busy ?g))
    )
)

(:durative-action arrange_object
  :parameters (?i - item ?l - location ?r - robot ?g - gripper)
  :duration (= ?duration 5)
  :condition 
    (and 
      (at start(gripper_at ?g ?r))
      (at start(robot_at ?r ?l))
      (at start(robot_carry ?r ?i ?g))
      (at start(gripper_busy ?g))
    )
  :effect 
    (and 
      (at start(object_at ?i ?l))
      (at start(gripper_free ?g))
      (at start(not (robot_carry ?r ?i ?g)))
      (at start(not (gripper_busy ?g)))
    )
)

)

