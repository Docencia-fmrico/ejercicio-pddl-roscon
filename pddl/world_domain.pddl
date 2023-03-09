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
)

(:constants On_gripper - location)

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
      (at end(not (gripper_free ?g)))
    )
)

(:durative-action arrange_object
  :parameters (?r - robot ?i - item ?l - location ?g - gripper)
  :duration (= ?duration 5)
  :condition 
    (and 
      ;(over all(no_human_request granny()))
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

)