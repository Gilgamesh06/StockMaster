-- Crear usuario

CREATE USER "Gilgamesh06" WITH PASSWORD 'coplandos';

--  Crear Rol

CREATE ROLE admin;

-- Asignar Permiso a un Rol

ALTER ROLE admin CREATEDB;

-- Asignar rol a Usuario

GRANT admin TO "Gilgamesh06";

-- Crear database

CREATE DATABASE "inventario" OWNER "Gilgamesh06";

-- Creacion de la entidad Producto

CREATE TABLE Producto(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    valor_unitario REAL NOT NULL,
    valor_venta REAL NOT NULL,
    cantidad INT,
    referencia VARCHAR(15) NOT NULL UNIQUE
);

-- Creacion de la entidad Pedido

CREATE TABLE Pedido(
    id SERIAL PRIMARY KEY,
    proveedor VARCHAR(100) NOT NULL, 
    fecha DATE DEFAULT CURRENT_DATE

);


-- Creacion de la entidad intermedia PedidoProducto

CREATE TABLE PedidoProducto(
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_producto INT NOT NULL,
    PRIMARY KEY (id_pedido,id_producto),

    CONSTRAINT fk_pedido_id FOREIGN KEY (id_pedido) REFERENCES Pedido(id),
    CONSTRAINT fk_producto_id FOREIGN KEY (id_producto) REFERENCES Producto(id) 

);

-- Creacion de la entidad Merma

CREATE TABLE Merma(
    id SERIAL PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE
);


-- Creacion de la entidad intermedio ProductoMerma

CREATE TABLE ProductoMerma(
    id_producto INT NOT NULL,
    id_merma INT NOT NULL,
    cantidad_producto INT NOT NULL,
    PRIMARY KEY(id_producto,id_merma),

    CONSTRAINT fk_producto_id FOREIGN KEY (id_producto) REFERENCES Producto(id),
    CONSTRAINT fk_merma_id FOREIGN KEY (id_merma) REFERENCES Merma(id)
);
