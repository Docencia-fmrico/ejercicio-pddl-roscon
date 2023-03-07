(define (problem objects)
(:domain world)

(:objects 
  Bathroom kitchen Garage Bedroom Livingroom - location
  Towels Plates Tools Clothing Blanket - object
)

(:init
  (object_at Towels kitchen)
  (object_at Clothing Bathroom)
  (object_at Plates Livingroom)
  (object_at Tools Bedroom)
  (object_at Blanket Bathroom)
)

(:goal (and
    (object_at Towels Bathroom)
    (object_at Plates kitchen)
    (object_at Tools Garage)
    (object_at Clothing Bedroom)
  )
)

)