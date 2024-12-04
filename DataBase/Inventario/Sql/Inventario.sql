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
      WHERE datname = 'inventario') THEN

      CREATE DATABASE "inventario" OWNER "Gilgamesh06";
   END IF;
END
$$;

-- Crear tabla producto si no existe
CREATE TABLE IF NOT EXISTS producto(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    valor_unitario REAL NOT NULL,
    valor_venta REAL NOT NULL,
    cantidad INT,
    referencia VARCHAR(15) NOT NULL UNIQUE
);

-- Crear tabla pedido si no existe
CREATE TABLE IF NOT EXISTS pedido(
    id SERIAL PRIMARY KEY,
    proveedor VARCHAR(100) NOT NULL, 
    fecha DATE DEFAULT CURRENT_DATE
);

-- Crear tabla pedidoproducto si no existe
CREATE TABLE IF NOT EXISTS pedidoproducto(
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_producto INT NOT NULL,
    PRIMARY KEY (id_pedido, id_producto),
    CONSTRAINT fk_pedido_id FOREIGN KEY (id_pedido) REFERENCES pedido(id),
    CONSTRAINT fk_producto_id FOREIGN KEY (id_producto) REFERENCES producto(id)
);

-- Crear tabla merma si no existe
CREATE TABLE IF NOT EXISTS merma(
    id SERIAL PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE
);

-- Crear tabla productomerma si no existe
CREATE TABLE IF NOT EXISTS productomerma(
    id_producto INT NOT NULL,
    id_merma INT NOT NULL,
    cantidad_producto INT NOT NULL,
    PRIMARY KEY(id_producto, id_merma),
    CONSTRAINT fk_producto_id FOREIGN KEY (id_producto) REFERENCES producto(id),
    CONSTRAINT fk_merma_id FOREIGN KEY (id_merma) REFERENCES merma(id)
);

