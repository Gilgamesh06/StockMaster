
# Levantamiento de Requerimientos

<!--Para la realizacion de la API empezaremos por definir los requerimiento-->

* **RF1:** El sistema debe permitir registrar los productos que ingresan al almacen. Se registrara en el sistema:
    * Nombres de los productos.
    * Cantidad de los productos.
    * Fecha de ingreso.

* **RF2:** El sistema debe permitir editar la cantidad de los productos registrados en el inventario en los siguientes casos:
    * El producto esta vencido o dañado (merma).
    * La cantidad del producto fue mal digitada.
        1. EL sistema debe llevar registro de modificacion.

<!--Con base en esto requerimientos debemos realizar la base de datos-->

## Modelado de la base de datos

<!--Para el modelado de la base de datos comenzaremos definiendo las entidades y los atributos -->

1. **Entidad Producto**

    | Atributo | Tipo de dato | Longitud |
    |--|--|--|
    | id_producto | Numerico |  6 |
    | nombre | String | 50 |
    | marca | String | 30 |


2. **Entidad Merma**

    | Atributo | Tipo de dato | Longitud |
    |--|--|--|
    | id_merma | Numerico | 6 |
    | id_producto | Numerico | 6 |
    | cantidad | Numerico | 5 |
    | descripcion | String | 50 | 
    | Fecha | Date | --/--/-- |


3. **Entidad Pedido**

    | Atributo | Tipo de dato | Longitud |
    |--|--|--|
    | id_pedido | Numerico | 6 |
    | id_producto | Numerico | 6 |
    | cantidad | Numerico  | 5 | 
    | Fecha | Date | --/--/-- |


* **Normalizacion**

    * Para la normalizacion eliminaremos valores multivaluados definiremos las claves primarias y claves foraneas

        1. **Entidad Producto**

            | Atributo | Tipo de dato | Longitud |
            |--|--|--|
            | id_producto (PK) | Numerico | 6 |
            | nombre | String | 50 | 
            | tipo |String | 40 |
            | valorUnitario | Numerico | 10 |
            | valorVenta | Numerico | 10 |
            | cantidadTotal | Numerico | 6 |
        
        2. **Entidad Pedido**

            | Atributo | Tipo de dato | Longitud |
            |--|--|--|
            | id_pedido (PK) | Numerico | 6 |
            | cantidad | Numerico | 6 |
            | fecha | Date | --/--/-- |
        
        3. **Entidad PedidoProducto**

            | Atributo | Tipo de dato | Longitud |
            |--|--|--|
            | pedido_id (PK)(FK)| Numerico | 6 |
            | producto_id (PK)(FK) | Numerico | 6 |
            
        4. **Entidad Merma**

            | Atributo | Tipo de dato | Longitud |
            |--|--|--|
            | id_merma (PK) | Numerico | 6 |
            | cantidad | Numerico | 6 |
            | descripcion | String | 255 |
            | fecha | Date | --/--/-- |

        5. **Entidad ProductoMerma**

            | Atributo | Tipo de dato | Longitud |
            |--|--|--|
            | producto_id (PK)(FK) | Numerico | 6 |
            | merma_id (PK)(FK) | Numerico | 6 |

