
-- Creacion de la entidad Producto

CREATE TABLE Producto(
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    valorUnitario REAL NOT NULL,
    valorVenta REAL NOT NULL,
    cantidadTotal INT
);

-- Creacion de la entidad Pedido

CREATE TABLE Pedido(
    id_pedido SERIAL PRIMARY KEY,
    cantidad INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE

);


-- Creacion de la entidad intermedia PedidoProducto

CREATE TABLE PedidoProducto(
    pedido_id INT NOT NULL,
    Producto_id INT NOT NULL,
    PRIMARY KEY (pedido_id,Producto_id),

    CONSTRAINT fk_pedido_id FOREIGN KEY (pedido_id) REFERENCES Inventario.Pedido(id_pedido),
    CONSTRAINT fk_producto_id FOREIGN KEY (producto_id) REFERENCES Inventario.Producto(id_producto) 

);

-- Creacion de la entidad Merma

CREATE TABLE Merma(
    id_merma SERIAL PRIMARY KEY,
    cantidad INT NOT NULL,
    descripcion VARCHAR(255),
    fecha DATE DEFAULT CURRENT_DATE
);


-- Creacion de la entidad intermedio ProductoMerma

CREATE TABLE ProductoMerma(
    producto_id INT,
    merma_id INT,
    PRIMARY KEY(producto_id,merma_id),

    CONSTRAINT fk_producto_id FOREIGN KEY (producto_id) REFERENCES Inventario.Producto(id_producto),
    CONSTRAINT fk_merma_id FOREIGN KEY (merma_id) REFERENCES Inventario.Merma(id_merma)
);