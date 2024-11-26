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

# Seguridad 

## Autenticacion `JWT`

* Un **JWT** es un token en formto JSON que contiene informacion estrucutrada (Como el usuario y su rol). Es seguro porque esta firmado digitalmente y, si esta correctamente configurado, solo el servidor que tiene la clave secreta puede validarlo.

    * **Porque usar JWT**
        
        1. **Distribucion sin consultas constantes a la base de datos** En sistemas distribuidos (COmo tus microservicios), una vez generado, el JWT puede validarse sin necesidad de consultar la base de datos.

        2. **Autocontenido** El token lleva consigo toda la informacion necesarioa, como el rol del usuario.

        3. **Escalabilidad** No necesitas mantener sesiones en un servidor centralizado.

    * **Que informacion contiene**

        1. **Header (Encabezado)** Describe el tipo de token (JWT) y el algoritmos de firma usado (Como HS256).

        2. **Pyload (Carga Util)** Contiene los datos de usuario, como su ID. nombre o rol.

        3. **Signature (Firma)** Garantiza que el token no ha sido manipulado

    ```python
        {
        "sub": "username",    // Identificador del usuario
        "rol": "admin",       // Rol del usuario
        "exp": 1693094576     // Fecha de expiración (en Unix timestamp)
        }
    ```   
## Genaracion del Token JWT

* Cuando un usuario inicia sesion correctamente (Es decir, proporciona un nombre de usuario y contraseña validos), necesitas autenticarlo y darle un token que demuestre que esta autenticado.

    * **Generacion del token**
        
        1. Toma la informacion relevante del usuario (Como su nombre de usuariu y rol).

        2. Agrega una fecha de expiracion para evitar que el token sea valido indefinidamente.

        3. Firma el token con una clave secreta que solo tu conoces.

    ```python
        def create_access_token(data: dict, expires_delta: timedelta | None = None):
            to_encode = data.copy()
            expire = datetime.utcnow() + (expires_delta if expires_delta else timedelta(minutes=30))
            to_encode.update({"exp": expire})
            encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
            return encoded_jwt
    ```
    
    * Esto aegura que

        * **Solo tu puedes generar tokens validos** Porque solo tu conoces `SECRET_KEY`

        * Los tockesn **Expiran automaticamente**

## Verificacion del token 

* Es el proceso de comprobar si el token recibido:
    
    1. **No ha sido manipulado** gracias a la firma.
    2. **Sigue siendo valido** No ha expirado.
    2. **Tiene la informacion necesaria** como el usuario y rol.

* Se verifica el token para proteger las rutas y APIs, por ejemplo, su un usuario intenta acceder al modulo de inventario, el sistema necesita asegurase de que:

    * Esta autenticado.
    * Tiene un rol que permita el acceso al inventario.

* Cuando un cliente envia un token (En el encabezado de la solicitud), tu servidor lo decodifica con la misma clave secreta (`SECRET_KEY`) que uso para generarlo.

```python
def get_current_user(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        role: str = payload.get("rol")
        if username is None or role is None:
            raise HTTPException(status_code=401, detail="Token inválido")
        return {"username": username, "role": role}
    except jwt.PyJWTError:
        raise HTTPException(status_code=401, detail="Token inválido o expirado")
```

## Control de Acceso por ROl

* Es el proceso de decidir quien puede acceder a que, basado en su `rol` o `permisos`


<hr>

# Diseño Genaral

1. **Centralizar la Autenticacion en los Microservicio `Usuario`**

    * El mocroservicios de **Usuario** Sera el encargado de gestionar la creacion de tokens JWT.

    * Los demas microservicios (Ventas , Inventario) No generan tokens, solo validaran,

2. **Validacion de Tokens JWT en Cada Microservicio**

    * Todos los microservicios compartiran la misma clave secreta (`SECRET_KEY`) o un sistema basado en calves publicas/privadas para validar los tokens-

    * Cada microservicio validara los tokens de las solicitudes que reciba antes de procesarlas.


3. **Flujo de Trabajo**

    * El cliente (Frotend) Se autentica contra el microservicio de **Usuario** y obtiene un token JWT.

    * Este token se incluye en las solicitudes a los otros microservicios (**Ventas**, **Inventario**) para acceder a sus Apis.

    * Cada microservicio valida el token y utiliza la informacion contenida en el (Como el rol) para decidir si permite la accion.



## Implemantaicon y Organizacion

1. **Microservicio Usuario: Generar Tokens JWT**

    ```python

        # routes/Auth.py

        from fastapi import APIRouter, Depends, HTTPException, status
        from pydantic import BaseModel
        from datetime import timedelta
        from sqlalchemy.orm import Session
        from config.db import get_db
        from models.models import Usuario
        from auth.jwt_handler import create_access_token
        import bcrypt

        router = APIRouter()

        # Esquema para recibir datos de login
        class LoginRequest(BaseModel):
            username: str
            password: str

        @router.post("/login")
        def login(request: LoginRequest, db: Session = Depends(get_db)):
            # Buscar al usuario en la base de datos
            user = db.query(Usuario).filter(Usuario.usuario == request.username).first()
            if not user or not bcrypt.checkpw(request.password.encode('utf-8'), user.clave.encode('utf-8')):
                raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Credenciales inválidas")
            
            # Generar token JWT
            access_token = create_access_token(data={"sub": user.usuario, "rol": user.rol})
            return {"access_token": access_token, "token_type": "bearer"}
    ```
    * `routes/Auth.py` ruta dentro del microservicio **Usuario**.


    
