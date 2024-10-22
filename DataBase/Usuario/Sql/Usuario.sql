
-- Creación de la entidad Persona

CREATE TABLE Persona(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    documento VARCHAR(15) NOT NULL UNIQUE,
    fechaNacimiento DATE NOT NULL,
    genero VARCHAR(10) NOT NULL  -- Cambio de genero de tipo bool a tipo String por culpa de las nuevas perpectivas de genero.
);

-- Creacion de la entidad Empleado

CREATE TABLE Empleado(
    id SERIAL PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    clave VARCHAR(255) NOT NULL,  -- Almacena el hash de la password
    salario REAL NOT NULL,
    rol VARCHAR(30) NOT NULL,
    persona_id INT NOT NULL,
    
    CONSTRAINT fk_persona_id FOREIGN KEY (persona_id) REFERENCES Persona(id)
);

-- Creacion de la entidad Cliente

CREATE TABLE Cliente(
    id SERIAL PRIMARY KEY,
    nit VARCHAR(50) NOT NULL UNIQUE,
    correo VARCHAR(80) NOT NULL UNIQUE,
    persona_id INT NOT NULL,

    CONSTRAINT fk_persona_id FOREIGN KEY (persona_id) REFERENCES Persona(id)
);
