
-- Creacion de la entidad Persona

CREATE TABLE Persona(
    id_persona SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    documento VARCHAR(15) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    genero BOOLEAN NOT NULL
)

-- Creacion de la entidad Empleado

CREATE TABLE Empleado(
    id_empleado SERIAL PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL,
    contraseña VARCHAR(50) NOT NULL,
    salario REAL NOT NULL,
    rol VARCHAR(30) NOT NULL,
    persona_id INT NOT NULL,

    CONSTRAINT fk_persona_id FOREIGN KEY (persona_id) REFERENCES Persona(id_persona)
);


-- Creacion de la entidad Cliente

CREATE TABLE Cliente(
    id_cliente SERIAL PRIMARY KEY,
    nit VARCHAR(50) NOT NULL,
    correo VARCHAR(80) NOT NULL,
    persona_id INT NOT NULL,

    CONSTRAINT fk_persona_id FOREIGN KEY (persona_id) REFERENCES Persona(id_persona) 
);