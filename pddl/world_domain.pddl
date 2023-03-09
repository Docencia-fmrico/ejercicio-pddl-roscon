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

; las dos primeras de open y cross con end hace todos los pasos pero abriendo primero las puertas
; TIENE QUE HABER UN AT END EN OPEN DOOR O EN CROSS
; CAMBIAR LA DURATION DEL CROSS HACE COSAS
(:durative-action open_door
  :parameters (?r - robot ?d - door ?l1 ?l2 - location)
  :duration (= ?duration 5)
  :condition
    (and
      (at start(connected_door ?l1 ?l2 ?d))
      (over all(robot_at ?r ?l1)) ; es asi
      (at start(door_closed ?d))
    )
  :effect 
    (and
       ; tiene que ser end para no abrir d3 al ppio
      (at end(door_opened ?d))
      (at start(not(door_closed ?d))) ; da igual
    )
)

(:durative-action close_door
  :parameters (?r - robot ?d - door ?l1 ?l2 - location)
  :duration (= ?duration 5)
  :condition
    (and
      (at start(connected_door ?l1 ?l2 ?d))
      (over all(robot_at ?r ?l1)) ; es asi
      (at start(door_opened ?d))
    )
  :effect 
    (and
       ; tiene que ser end para no abrir d3 al ppio
      (at end(door_closed ?d))
      (at start(not(door_opened ?d))) ; da igual
    )
)

(:durative-action move_robot ; Without door
  :parameters (?r - robot ?l1 ?l2 - location)
  :duration (= ?duration 5)
  :condition 
    (and
      (at start(robot_at ?r ?l1))
      (at start(connected ?l1 ?l2))
    )
  :effect 
    (and 
      (at end(robot_at ?r ?l2)) ; no es end
      (at start(not (robot_at ?r ?l1))); no es end
    )
) 

(:durative-action cross ; With door
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
      (at end(robot_at ?r ?l2)) ; da igual start o end
      (at start(not (robot_at ?r ?l1))) ; tiene que ser start
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
    (and  ; dan igual todos
      (at end(not (object_at ?i ?l)))
      (at end(object_at ?i On_gripper))
      (at start(not (gripper_free ?g)))
    )
)

(:durative-action arrange_object
  :parameters (?r - robot ?i - item ?l - location ?g - gripper)
  :duration (= ?duration 5)
  :condition 
    (and 
      (over all(no_human_request Granny))
      (at start(object_at ?i On_gripper))
      (over all(robot_at ?r ?l)) ; over all hace lo mismo
      (at start(object_place ?i ?l))
    )
  :effect 
    (and ; dan igual todas
      (at start(not(object_at ?i On_gripper)))
      (at end(object_at ?i ?l))
      (at end(gripper_free ?g))
    )
)

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

(:durative-action give_object
    :parameters (?r - robot ?i - item ?l - location ?g - gripper)
    :duration (= ?duration 5)
    :condition (and
        (at start (arr_obj_req ?i Granny))
        (at start(granny_at ?l Granny))
        (at start(object_at ?i On_gripper))
        (over all(robot_at ?r ?l)) ; over all hace lo mismo
    )
    :effect (and 
        (at start(not(object_at ?i On_gripper)))
        (at end(object_at ?i ?l))
        (at end(gripper_free ?g))
        (at end(object_at_granny ?i))

    )
)
)