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
The Gazebo world chosen has been the  **hospital**. In order to solve the problem of the project we focus the :
![Hospital](https://github.com/Docencia-fmrico/ejercicio-pddl-roscon/blob/main/resources/aws_hospital.jpg)
| Object | Elements |
| :---:  | :---: |
| Robot | Tiago  |
| Person | Granny |
| Locations | Bedroom, Bathroom, Surgery Room, UCI, Living Room, Corridor |
| Doors | 1: bedroom-bathroom, 2: bedroom-corridor, 3: surgery-corridor |
| gripper | gripper |
| Items | Pijama, Towel, Scalpel, Blanket, Magazines  |

## Domain

## Problems
---- ----
To execute the problems, you should be in the pddl directory:
```
cd pddl
ros2 run popf popf world_domain.pddl problemX.pddl
```
### Tidy Up Problem
### Granny Problem
This is a basic problem to try the preferences of atending a Granny request before the other actions. The robot should be at the end in the surgery room.
```
ros2 run popf popf world_domain.pddl granny_problem.pddl
```
## Execution
```
ros2 run popf popf world_domain.pddl housekeeping_problemX.pddl
```
