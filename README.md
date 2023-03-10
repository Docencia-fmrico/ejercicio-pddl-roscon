# Planning Exercise

En este ejericio se pide un fichero PDDL con el dominio y varios (al menos 3) ficheros con el problema PDDL representativos.

El dominio debe permitir:
* Hacer que un robot navegue por una casa, formada por habitaciones, pasillos y puertas. Las puertas pueden estar abiertas o cerradas. El robot puede abrir (o pedir que le abran) puertas para poder moverse entre habitaciones.
* Puede haber objetos en diferentes puntos de la casa. Cada objeto tiene una habitación de la casa donde deberían estar, si la casa está ordenada. Desgraciadamente los objetos pueden estar en otros puntos de la casa, y el objetivo del robot es llevarlos a su sitio. Ejemplo de objetos:
  * Toallas: Baño
  * Platos y cubiertos: cocina
  * Herramientas: Garage
  * Ropa: Dormitorio
* Hay una persona en la casa (la abuelita), que generalmente está en su habitación. Podría estar en otro sitio.
* La abuelita podría pedir que hagas algo por ella, y esta tarea tendría prioridad sobre las tareas de recogida de objetos del robot. Ejemplo:
  * Abrir/cerrar la puerta de casa.
  * Traer un vaso de leche de la cocina.
  * Traer le medicina del salón.
  
 Al menos, tened en cuenta los ejemplos descritos.

## World
The Gazebo world chosen has been the  **hospital**. In order to solve it, we focus our attention and the tiago behaviour in this area, represented in the picture:

![Hospital](https://github.com/Docencia-fmrico/ejercicio-pddl-roscon/blob/main/resources/aws_hospital.jpg)

## Objects
To do these problems, we need to define all these objects:

| Object | Elements |
| :---:  | :---: |
| Robot | Tiago  |
| Person | Granny |
| Locations | Bedroom, Bathroom, Surgery Room, UCI, Living Room, Corridor |
| Locations (Door Locations) | Bedroom_d1, Bathroom_d1, Bedroom_d2, Corridor_d2, Corridor_d3, Surgery_room_d3 |
| Doors | 1: bedroom-bathroom, 2: bedroom-corridor, 3: surgery-corridor |
| gripper | gripper |
| Items | Pijama, Towel, Scalpel, Blanket, Magazines  |

## Domain
This robot is able to do the following actions:

- [ ] Open and close doors.
- [ ] Cross through a door and move it to another location. It could also move between locations connected without a door.
- [ ] Pick an object from a room and arrange it to another. To do this, it has a gripper that could only carry one item at a time.
- [ ] Give object to Granny where it is.

Granny could request the robot:
- [ ] request_open_door
- [ ] request_close_door
- [ ] request_arrange_obj

## Problems

Conditions to make a new problem.pddl:
- In order to meet the requests of the granny, we have to specify the aim that there is no-human-request. Since if we do not state it, it will remain indefinitely waiting for the human-requests to be completed and will not find a path solution.
- On the contrary, if the granny does not make any requests, we have to define in the initial state that there are no-human-request.

---- ----
To execute the problems, you must be in the pddl directory:
```
cd pddl
ros2 run popf popf world_domain.pddl problemX.pddl
```
### Tidy Up Problem

This is a standar problem. The robot must put all the items in their correct place. In this case it is not necessary the preferences, because the Granny doesn't interfere in the Tiago behavior.

You should run it as:

```
ros2 run popf popf world_domain.pddl tidy_up_problem.pddl
```

The execution result should be similar to this:

![Tidy](https://github.com/Docencia-fmrico/ejercicio-pddl-roscon/blob/main/resources/tidy_prob_exec.jpg)



### Granny Problem
This is a basic problem to try the preferences of atending a Granny request before the other actions. The robot should be at the end in the surgery room.

To execute this problem:

```
ros2 run popf popf world_domain.pddl granny_problem.pddl
```

Obtaining as result:

![Granny](https://github.com/Docencia-fmrico/ejercicio-pddl-roscon/blob/main/resources/granny_prob_exec.jpg)

### Door Problem
The robot will first open de requested door because it has priority.
After that, the robot will arrange the pijama and it will go to the bathroom.
To execute this problem:

```
ros2 run popf popf world_domain.pddl door_problem.pddl
```

![Door](https://github.com/Docencia-fmrico/ejercicio-pddl-roscon/blob/main/resources/door_prob_exec.jpg)

### Multiple Request Problem

In this last problem, the main issue was making the robot achieve more than one requests from Granny. It musts complete in the most efficient order. The plannifer decides the order.

To execute this problem:

```
ros2 run popf popf world_domain.pddl mult_requests_problem.pddl
```

![mult_request](https://github.com/Docencia-fmrico/ejercicio-pddl-roscon/blob/main/resources/mult_prob_exec.jpg)
