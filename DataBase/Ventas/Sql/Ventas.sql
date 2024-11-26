-- Crear usuario

CREATE USER "Gilgamesh06" WITH PASSWORD 'coplandos';

--  Crear Rol

CREATE ROLE admin;

-- Asignar Permiso a un Rol

ALTER ROLE admin CREATEDB;

-- Asignar rol a Usuario

GRANT admin TO "Gilgamesh06";

-- Crear database

CREATE DATABASE "ventas" OWNER "Gilgamesh06";

-- Creacion de la entidad Factura

CREATE TABLE Factura(
    id SERIAL PRIMARY KEY,
    cliente_documento VARCHAR(15) NOT NULL,
    cliente_nit VARCHAR(50) NOT NULL,
    empleado VARCHAR(100),
    fecha DATE DEFAULT CURRENT_DATE,
    valor_total REAL NOT NULL,
);

CREATE TABLE DetalleFactura(
    id SERIAL PRIMARY KEY
    producto VARCHAR(255) NOT NULL,
    cantidad INT NOT NULL,
    precio REAL NOT NULL,
    valor REAL NOT NULL,
    id_factura INT,
    
    CONSTRAINT fk_factura_id FOREIGN KEY (id_factura) REFERENCES Factura(id)
);

CREATE TABLE Devolucion(
    id SERIAL PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE
    empleado VARCHAR(100) NOT NULL,
    id_factura INT,

    CONSTRAINT fk_factura_id FOREIGN KEY (id_factura) REFERENCES Factura(id)
);
