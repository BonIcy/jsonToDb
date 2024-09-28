CREATE DATABASE nike;

USE nike;

CREATE TABLE categoria (
    id int NOT NULL AUTO_INCREMENT,
    nombre varchar(50) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE genero (
    id int NOT NULL AUTO_INCREMENT,
    nombre varchar(50) NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE tipo_producto (
    id int NOT NULL AUTO_INCREMENT,
    nombre varchar(50) NOT NULL,
    generoId INT NOT NULL,
    categoriaId INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(generoId) REFERENCES genero(id),
    FOREIGN KEY(categoriaId) REFERENCES categoria(id)
);
CREATE TABLE tipo_documento(
    id int NOT NULL AUTO_INCREMENT,
    nombre varchar(50) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE rol(
    id int NOT NULL AUTO_INCREMENT,
    nombre varchar(50) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE metodo_pago(
    id int NOT NULL AUTO_INCREMENT,
    nombre varchar(50) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE estado_transaccion(
    id int NOT NULL AUTO_INCREMENT,
    nombre varchar(50) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE producto(
    id int NOT NULL AUTO_INCREMENT,
    nombre varchar(50) NOT NULL,
    descripcion varchar(255) NOT NULL,
    precio INT NOT NULL,
    stock INT NOT NULL,
    imgUrl varchar(255),
    tipo_productoId INT NOT NULL,   
    PRIMARY KEY(id),
    FOREIGN KEY(tipo_productoId) REFERENCES tipo_producto(id)
);
CREATE TABLE usuario(
    id int NOT NULL AUTO_INCREMENT,
    nombre varchar(50) NOT NULL,
    correo varchar(50) NOT NULL,
    contrasena varchar(50) NOT NULL,
    tipo_documentoId INT NOT NULL,
    dni VARCHAR(50) NOT NULL,
    estado BOOLEAN DEFAULT 1,
    rolId INT NOT NULL DEFAULT 1,
    PRIMARY KEY(id),
    FOREIGN KEY(tipo_documentoId) REFERENCES tipo_documento(id),
    FOREIGN KEY (rolId) REFERENCES rol(id)
);

CREATE TABLE transaccion(
    id int NOT NULL AUTO_INCREMENT,
    fecha DATE,
    cantidad_producto INT,
    precioTotal INT,
    usuarioId INT NOT NULL,
    productoId INT NOT NULL,
    metodo_pagoId INT NOT NULL,
    estado_transaccionId INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(usuarioId) REFERENCES usuario(id),
    FOREIGN KEY(productoId) REFERENCES producto(id),
    FOREIGN KEY(metodo_pagoId) REFERENCES metodo_pago(id),
    FOREIGN KEY(estado_transaccionId) REFERENCES estado_transaccion(id)
);

/* Insert data */

INSERT INTO categoria(nombre) VALUES ('Deportivo'), ('Formal');

INSERT INTO tipo_documento(nombre) VALUES ('CC'), ('TI'), ('CE');

INSERT INTO rol (nombre) VALUES ('usuario'), ('administrador'), ('owner');
INSERT INTO genero (nombre) VALUES ('masculino'), ('femenino'), ('otro');

INSERT INTO usuario (nombre, correo, contrasena, tipo_documentoId, dni, rolId) VALUES
('Jesus Martinez', 'jrey22k@gmail.com', '12345', 2, 1098643865, 2);

INSERT INTO metodo_pago (nombre) VALUES
('Tarjeta de crédito'),
('Tarjeta de débito'),
('Transferencia bancaria'),
('PayPal');

INSERT INTO estado_transaccion (nombre) VALUES
('Pendiente'),
('Aprobada'),
('Rechazada');

INSERT INTO tipo_producto (nombre, generoId, categoriaId) VALUES
('Calzado', 1, 1),
('Ropa', 1, 1),
('Accesorios', 1, 1),
('Calzado', 2, 1),
('Ropa', 2, 1),
('Accesorios', 2, 1);

INSERT INTO producto (nombre, descripcion, precio, stock, imgUrl, tipo_productoId) VALUES
('Air Jordan 1', 'Una zapatilla de baloncesto icónica.', 100, 50, 'https://example.com/air-jordan-1.jpg', 1),
('Nike Air Max 270', 'Una zapatilla cómoda y estilosa.', 80, 30, 'https://example.com/nike-air-max-270.jpg', 1),
('Nike Blazer Mid', 'Una zapatilla clásica y versátil.', 70, 20, 'https://example.com/nike-blazer-mid-77.jpg', 1),
('Nike Blazer Low', 'Una zapatilla clásica y versátil.', 60, 10, 'https://example.com/nike-blazer-low-77.jpg', 1);

INSERT INTO transaccion (fecha, cantidad_producto, precioTotal, usuarioId, productoId, metodo_pagoId, estado_transaccionId) VALUES
('2023-11-09', 1, 100, 1, 7, 1, 1),
('2023-11-09', 2, 160, 1, 6, 2, 1);