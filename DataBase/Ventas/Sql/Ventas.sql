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
      WHERE datname = 'ventas') THEN

      CREATE DATABASE "ventas" OWNER "Gilgamesh06";
   END IF;
END
$$;

-- Creación de la entidad factura si no existe
CREATE TABLE IF NOT EXISTS factura (
    id SERIAL PRIMARY KEY,
    cliente_documento VARCHAR(15) NOT NULL,
    cliente_nit VARCHAR(50) NOT NULL,
    empleado_documento VARCHAR(100),
    fecha DATE DEFAULT CURRENT_DATE,
    valor_total REAL NOT NULL
);

-- Creación de la entidad detallefactura si no existe
CREATE TABLE IF NOT EXISTS detallefactura (
    id SERIAL PRIMARY KEY,
    producto VARCHAR(255) NOT NULL,
    cantidad INT NOT NULL,
    precio REAL NOT NULL,
    valor REAL NOT NULL,
    id_factura INT,
    
    CONSTRAINT fk_factura_id FOREIGN KEY (id_factura) REFERENCES factura(id)
);

-- Creación de la entidad devolucion si no existe
CREATE TABLE IF NOT EXISTS devolucion (
    id SERIAL PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE,
    empleado_documento VARCHAR(100) NOT NULL,
    id_factura INT,

    CONSTRAINT fk_factura_id FOREIGN KEY (id_factura) REFERENCES factura(id)
);

