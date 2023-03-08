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
El mundo de Gazebo elegido es el **hospital**. Para el ejericio se ha seleccionado la siguiente zona:
![Hospital](https://github.com/Docencia-fmrico/ejercicio-pddl-roscon/blob/main/resources/aws_hospital.jpg)
| Object | Elements |
| :---:  | :---: |
| Robot | Tiago  |
| Person | Granny |
| Locations | Bedroom, Bathroom, Surgery Room, UCI, Living Room, Corridor |
| Doors | 1: bedroom-bathroom, 2: bedroom-corridor, 3: surgery-corridor |
| Items | Pijama, Towel, Scalpel, Blanket, Magazines  |

## Domain

## Problems

## Execution
```
ros2 run popf popf world_domain.pddl housekeeping_problemX.pddl
```
