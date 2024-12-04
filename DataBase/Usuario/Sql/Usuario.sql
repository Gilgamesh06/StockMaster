-- Crear usuario si no existe
DO
$$
BEGIN
   IF NOT EXISTS (
      SELECT FROM pg_catalog.pg_roles
      WHERE rolname = 'Gilgamesh06') THEN

      CREATE USER "Gilgamesh06" WITH PASSWORD 'coplandos';
   END IF;
END
$$;

-- Crear base de datos si no existe
DO
$$
BEGIN
   IF NOT EXISTS (
      SELECT FROM pg_catalog.pg_database
      WHERE datname = 'usuario') THEN

      CREATE DATABASE "usuario" OWNER "Gilgamesh06";
   END IF;
END
$$;

-- Creación de la entidad persona si no existe
CREATE TABLE IF NOT EXISTS persona (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    documento VARCHAR(15) NOT NULL UNIQUE,
    fechanacimiento DATE NOT NULL,
    genero VARCHAR(10) NOT NULL  -- Cambio de genero de tipo bool a tipo String por culpa de las nuevas perspectivas de género.
);

-- Creación de la entidad empleado si no existe
CREATE TABLE IF NOT EXISTS empleado (
    id SERIAL PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    clave VARCHAR(255) NOT NULL,  -- Almacena el hash de la password
    salario REAL NOT NULL,
    rol VARCHAR(30) NOT NULL,
    persona_id INT NOT NULL UNIQUE, -- Asegura que cada persona solo puede ser un empleado
    
    CONSTRAINT fk_persona_id FOREIGN KEY (persona_id) REFERENCES persona(id)
);

-- Creación de la entidad cliente si no existe
CREATE TABLE IF NOT EXISTS cliente (
    id SERIAL PRIMARY KEY,
    nit VARCHAR(50) NOT NULL UNIQUE,
    correo VARCHAR(80) NOT NULL UNIQUE,
    persona_id INT NOT NULL UNIQUE, -- Asegura que cada persona solo puede ser un cliente

    CONSTRAINT fk_persona_id FOREIGN KEY (persona_id) REFERENCES persona(id)
);

