# Levantamiento de Requerimientos

<!--Para la realizacion de la API empezaremos por definir los requerimientos-->


* **RF1:** El sistema debe permitri registrar los empleados donde se registraran los siguientes datos: 
    * Nombre
    * Apellido
    * Fecha Nacimiento
    * Genero
    * Documento
    * Salario
    * Rol
    * Usuario
    * password

* **RF2:** El sistema debe permitir registrar los clientes dodne se registran los siguientes datos:

    * Nombre
    * Apellido
    * Fecha Nacimiento
    * Genero
    * Documento
    * nit
    * correo

<!--Con base en estos requerimientos debemos realizar la base de datos-->

## Modelado de la base de datos

<!-- Para el modelado de la base de datos comenzaremos definiendo las entidades y los atributos-->

1. **Entidad Empleado**

    | Atributo | Tipo de dato| Longitud |
    |--|--|--|
    | id_empleado | Numerico | 6 |
    | nombre | String | 50 |
    | apellido | String | 50 |
    | fechaNacimiento | Date | --/--/--/ |
    | documento | String | 15 |
    | genero | boolean | true or false | 
    | usuario | String | 30 |
    | password | String | 30 |
    | salario | Numerico | 15 |
    | rol | String | 20 |

2. **Entidad Cliente**

    | Atributo | Tipo de dato| Longitud |
    |--|--|--|
    | id_cliente | Numerico | 6 |
    | nombre | String | 50 |
    | apellido | String | 50 |
    | fechaNacimiento | Date | --/--/--/ |
    | documento | String | 15 |
    | genero | boolean | true or false | 
    | nit | String | 15 |
    | correo | String | 80 |



### Normalizacion

* Para la normalizacion eliminaremos valores multivaluados definiremos las claves primarias y claves foraneas

1. **Entidad Persona**

    | Atributo | Tipo de dato | Longitud |
    |--|--|--|
    | id_persona (PK) | Numerico | 6 |
    | nombre | String | 50 |
    | apellido | String | 50 | 
    | fechaNacimiento  | Date | --/--/--|
    | genero | boolean | true or false |
    | documento | String | 15 |


2. **Entidad Cliente**

    | Atributo | Tipo de dato | Longitud |
    |--|--|--|
    | id_cliente (PK)| Numerico | 6 |
    | nit | String | 15 |
    | correo | String | 80 |
    | persona_id (FK)| Numerico | 6 |

3. **Entidad Empleado**

    | Atributo | Tipo de dato | Longitud |
    |--|--|--|
    | id_empleado (PK)| Numerico | 6 |
    | salario | Numerico | 15 |
    | usuario | String | 30 |
    | password | String | 30 |
    | rol | String | 20 |
    | persona_id (FK) | Numerico | 6|



