
-- Creacion de la entidad Producto

CREATE TABLE Producto(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    valorUnitario REAL NOT NULL,
    valorVenta REAL NOT NULL,
    cantidadTotal INT
);

-- Creacion de la entidad Pedido

CREATE TABLE Pedido(
    id SERIAL PRIMARY KEY,
    cantidad INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE

);


-- Creacion de la entidad intermedia PedidoProducto

CREATE TABLE PedidoProducto(
    id_pedido INT NOT NULL,
    id_Producto INT NOT NULL,
    PRIMARY KEY (pedido_id,Producto_id),

    CONSTRAINT fk_pedido_id FOREIGN KEY (id_pedido) REFERENCES Pedido(id),
    CONSTRAINT fk_producto_id FOREIGN KEY (id_producto) REFERENCES Producto(id) 

);

-- Creacion de la entidad Merma

CREATE TABLE Merma(
    id SERIAL PRIMARY KEY,
    cantidad INT NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE
);


-- Creacion de la entidad intermedio ProductoMerma

CREATE TABLE ProductoMerma(
    id_producto INT NOT NULL,
    id_merma INT NOT NULL,
    PRIMARY KEY(id_producto,id_merma),

    CONSTRAINT fk_producto_id FOREIGN KEY (id_producto) REFERENCES Producto(id),
    CONSTRAINT fk_merma_id FOREIGN KEY (id_merma) REFERENCES Merma(id)
);
