<!-- Proyecto de Ingenieria de Software -->

# StockMaster

* StockMaster es un software para la gestion de inventario y ventas de empresas pequeñas, el cual permite la gestion de productos, la venta de productos, seguimiento de las actividades realizadas por los empleados y la administracion de la informacion generado por estos.

<!-- Creacion de una app web para la gestion de una tienda con microserivcios -->


<!-- Para la creacion de los microservicios analizaremos las funciones principales de una tienda-->

* **Microservicios**
    1. Usuario
    2. Inventario
    3. Ventas

<!-- Para su implementacion lo manejaresmos como apis que se comunican entre ellas -->

* **API de Inventario**

* **API de Ventas** 

* **API de Usuarios**  

## Tecnologias a usar

1. **Base de datos:** La base de datos escogida es postgreSQL.
2. **ORM:** Se utilizara el ORM SQLAlchemy.
3. **Backend:** Se utilizara FastApi para la creacion del backend 


### Definicion del backend

* Para este microservicio nuestro backend funcinara como una api para ello la tecnologia que elegimos fue fastapi.

* **Api:** Es un conjunto de reglas y protocolos que permiten que diferentes aplicacione se comuniquen entre si. Las APIs definen los metodos y formatos que las aplicaciones puede usar para solicitar y enviar datos, lo que facilita la interaccion entre el software.

* **Fastapi:** Es un framework web moderno y de alto rendimiento para construir APis (Interfaces de Programacion de Aplicaciones) en Python.

#### Configuracion del entorno

* Para comenzar a realizar la API lo primero es Crear un entorno virtual: 

```bash
    # Verificar si esta instalado python y pip3
    python3 --version
    pip3    --version
```
* Instalar el entorno virtual:

```bash
    # Instalar el entorno virtual
    sudo apt install  python3-venv
```

* Crear un entorno virtual

```bash
    # Crear la carpeta que contendra el entorno virtaul
    mkdir ProyectAPI
    # Luego creamos el entorno virtual
    python3 -m venv ProyectAPI
    # Ingresamos a la carpeta
    cd ProyectAPI
```

* Activar entorno Virtual


```bash
    # Para activar el entorno virtual utilizamos el siguiente comando
    source bin/activate
```

* Instalacion de dependencias del proyecto

```bash
    # Instalamos las dependencias necesarias para la realizacion de la api
    # Instalacion de fastapi
    pip install fastapi
    # Instalacion del servidor
    pip install uvicorn
    # Instalacion de ORM SQLAlchemy
    pip install sqlalchemy
    # Instalacion de la dependecia de PostgreSQL
    pip install psycopg2-binary

```