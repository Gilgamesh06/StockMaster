# Docker 

* Docker es una plataforma de software que permite a los desarrolladores crear, probar y desplegar aplicaciones en contenedores. Un contenedor es una unidad estándar de software que empaqueta el código de una aplicación y todas sus dependencias, de modo que la aplicación se ejecute de manera rápida y confiable en diferentes entornos informáticos.

* **Características**

    * **Aislamiento:** Los contenedores permiten que las aplicaciones se ejecuten de manera aislada, lo que significa que los problemas en un contenedor no afectan a otros.
    * **Portabilidad:** Las aplicaciones en contenedores pueden ejecutarse en cualquier lugar donde Docker esté instalado, ya sea en una máquina local, en un servidor en la nube o en un entorno de producción.
    * **Eficiencia:** Los contenedores son más ligeros que las máquinas virtuales, ya que comparten el mismo núcleo del sistema operativo, lo que permite un uso más eficiente de los recursos.
    * **Facilidad de uso:** Docker proporciona herramientas y comandos que facilitan la creación, gestión y despliegue de contenedores.


<hr>

# Docker aplicado a nuestro Proyecto

* Ya que nuestro backend esta compuesto por modulos:
    * Ventas
    * Inventario
    * Usuario

* Es una buena idea desplegarlo por medio de docker ya que nos permite tener una facil portabilidad y poder realizar pruebas de integracion entre los modulos.

## Estructura del Proyecto 

* La estructura de nuestro proyecto es la siguiente:

    ```bash
    # Directorio Backend
    ├── bin
    ├── docker-compose.yml
    ├── include
    ├── Inventario
    ├── lib
    ├── lib64 -> lib
    ├── pyvenv.cfg
    ├── requirements.txt
    ├── Usuario
    └── Ventas
    ```

* En el directorio backend es necesario colocar el fichero `docker-compose.yml` el cual tiene la configuracion para desplegar varios contenedores a la vez.

    ```yml
    version: '3.8'

    services:
    usuario:
        build:
        context: ./Usuario
        ports:
        - "8001:8000"
        volumes:
        - usuario_data:/app/data
        - ./Usuario/.env:/app/.env
        networks:
        - app-network
        environment:
        - DATABASE_URL=postgresql://Gilgamesh06:coplandos@db_usuario:5432/usuario
        depends_on:
        - db_usuario

    ventas:
        build:
        context: ./Ventas
        ports:
        - "8002:8000"
        volumes:
        - ventas_data:/app/data
        - ./Ventas/.env:/app/.env
        networks:
        - app-network
        environment:
        - DATABASE_URL=postgresql://Gilgamesh06:coplandos@db_ventas:5432/ventas
        depends_on:
        - db_ventas

    inventario:
        build:
        context: ./Inventario
        ports:
        - "8003:8000"
        volumes:
        - inventario_data:/app/data
        - ./Inventario/.env:/app/.env
        networks:
        - app-network
        environment:
        - DATABASE_URL=postgresql://Gilgamesh06:coplandos@db_inventario:5432/inventario
        depends_on:
        - db_inventario

    db_usuario:
        image: postgres:latest
        volumes:
        - db_usuario_data:/var/lib/postgresql/data
        - ./Usuario/initdb:/docker-entrypoint-initdb.d  # Montar el script SQL
        networks:
        - app-network
        environment:
        - POSTGRES_DB=usuario
        - POSTGRES_USER=Gilgamesh06
        - POSTGRES_PASSWORD=coplandos

    db_ventas:
        image: postgres:latest
        volumes:
        - db_ventas_data:/var/lib/postgresql/data
        - ./Ventas/initdb:/docker-entrypoint-initdb.d  # Montar el script SQL
        networks:
        - app-network
        environment:
        - POSTGRES_DB=ventas
        - POSTGRES_USER=Gilgamesh06
        - POSTGRES_PASSWORD=coplandos

    db_inventario:
        image: postgres:latest
        volumes:
        - db_inventario_data:/var/lib/postgresql/data
        - ./Inventario/initdb:/docker-entrypoint-initdb.d  # Montar el script SQL
        networks:
        - app-network
        environment:
        - POSTGRES_DB=inventario
        - POSTGRES_USER=Gilgamesh06
        - POSTGRES_PASSWORD=coplandos

    networks:
    app-network:
        driver: bridge

    volumes:
    usuario_data:
    ventas_data:
    inventario_data:
    db_usuario_data:
    db_ventas_data:
    db_inventario_data:
    ```

* Como podemos ver en el **docker-compose.yml** es necesario tener la imagen `postgres:latest`

    ```bash
    sudo docker pull postgres:latest 
    ```

* Tambien es necesario tener el script de de Inicializacion de la base de datos el cual se encuentra en el directorio `initdb` que contiene el fichero `init.sql`


* Ademas es necesario que en cada Modulo exista el archivo `Dockerfile` y el archivo  `.env` que contiene variables

    ```bash
    ├── app.py
    ├── auth
    ├── config
    ├── Dockerfile
    ├── .env
    ├── .git
    ├── .gitignore
    ├── initdb
    ├── models
    ├── __pycache__
    ├── .pytest_cache
    ├── README.md
    ├── requirements.txt
    ├── routes
    ├── schemas
    └── test
    ```

    * **Dockerfile**

    ```bash
    # DockerFile
    FROM python:3.12.3-slim

    # Configurar el modo no interactivo
    ENV DEBIAN_FRONTEND=noninteractive
    ENV TZ=America/Bogota

    # Instalar dependencias
    RUN apt-get update && apt-get install -y \
        python3 python3-pip \
        && apt-get clean && rm -rf /var/lib/apt/lists/*

    # Establecer el directorio de trabajo
    WORKDIR /app

    # Copiar los archivos de requisitos y la aplicación
    COPY requirements.txt .
    RUN pip3 install --no-cache-dir -r requirements.txt
    COPY . .

    # Exponer el puerto que usa FastAPI
    EXPOSE 8000

    # Comando para ejecutar la aplicación
    CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]

    ```

    * **.env**

    ```bash
    DATABASE_URL=postgresql://Gilgamesh06:coplandos@db_ventas:5432/ventas
    USER_SERVICE_URL=http://usuario:8000
    INVENTORY_SERVICE_URL=http://inventario:8000
    ```

* Para que el **Dockerfile** inicie se debe tener previamente instalada la imagen `python:3.12.3-slim`

    ```bash
    sudo docker pull python:3.12.3-slim 
    ```
* Para que el docker istale los requerimientos (Dependencias) de FastAPI es necesario el fichero `requirements.txt`

    ```bash
    annotated-types==0.7.0
    anyio==4.6.2.post1
    bcrypt==4.2.0
    certifi==2024.8.30
    charset-normalizer==3.4.0
    click==8.1.7
    coverage==7.6.8
    fastapi==0.115.2
    greenlet==3.1.1
    h11==0.14.0
    httpcore==1.0.7
    httpx==0.28.0
    idna==3.10
    iniconfig==2.0.0
    packaging==24.2
    pluggy==1.5.0
    psycopg2-binary==2.9.10
    pydantic==2.9.2
    pydantic_core==2.23.4
    PyJWT==2.10.0
    pytest==8.3.4
    pytest-cov==6.0.0
    python-dotenv==1.0.1
    python-multipart==0.0.17
    requests==2.32.3
    sniffio==1.3.1
    SQLAlchemy==2.0.36
    starlette==0.40.0
    typing_extensions==4.12.2
    urllib3==2.2.3
    uvicorn==0.32.0
    ```

* Luego de Realizar esto podemos levantar el usadon el comando:

    ```bash
    sudo docker-compose up --rebuild
    ```