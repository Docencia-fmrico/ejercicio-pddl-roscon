(define (problem move)
(:domain world)

(:objects 
    tiago - robot
    Bathroom kitchen Garage Bedroom Livingroom - location
  )

(:init
  (robot_at tiago Garage)
  (connected kitchen Livingroom )
  (connected Livingroom kitchen )
  (connected kitchen Bedroom )
  (connected Bedroom kitchen )
  (connected Bedroom Garage )
  (connected Garage Bedroom )
  (connected Garage Livingroom )
  (connected Livingroom Garage )
  (connected Garage Bathroom )
  (connected Bathroom Garage )
)

)