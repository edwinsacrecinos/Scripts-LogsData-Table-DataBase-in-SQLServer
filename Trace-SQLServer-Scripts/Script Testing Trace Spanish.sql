CREATE TABLE tblLlamadas (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    compania VARCHAR(100) NULL,
    fechaRegistro DATETIME NULL,
    minutosLlamadas DECIMAL(14,2),
    llamadaValida BIT
);


-- Insertar un registro
INSERT INTO tblLlamadas (compania, fechaRegistro, minutosLlamadas, llamadaValida)
VALUES ('CompaniaA', '2023-08-11 10:00:00', 15.75, 1);

-- Insertar otro registro
INSERT INTO tblLlamadas (compania, fechaRegistro, minutosLlamadas, llamadaValida)
VALUES ('CompaniaB', '2023-08-11 14:30:00', 7.50, 0);


-- Actualizar el campo 'compania' para un registro específico
UPDATE tblLlamadas
SET compania = 'NuevaCompania'
WHERE id = 1;

-- Eliminar un registro por su ID
DELETE FROM tblLlamadas
WHERE id = 2;

-- Eliminar registros no válidos
DELETE FROM tblLlamadas
WHERE llamadaValida = 0;


CREATE SCHEMA co;


CREATE TABLE co.Compras (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    fechaCompra DATE NOT NULL,
    producto VARCHAR(100) NOT NULL,
    cantidad INT NOT NULL,
    precioUnitario DECIMAL(10, 2) NOT NULL,
    totalCompra DECIMAL(10, 2) NOT NULL
);

-- Insertar una compra
INSERT INTO co.Compras (fechaCompra, producto, cantidad, precioUnitario, totalCompra)
VALUES ('2023-08-11', 'Leche', 2, 1.50, 3.00);

-- Insertar otra compra
INSERT INTO co.Compras (fechaCompra, producto, cantidad, precioUnitario, totalCompra)
VALUES ('2023-08-12', 'Pan', 3, 0.75, 2.25);

-- Modificar el precio unitario de un producto
UPDATE co.Compras
SET precioUnitario = 1.00
WHERE producto = 'Leche';

-- Modificar la cantidad y el total de una compra
UPDATE co.Compras
SET cantidad = 4,
    totalCompra = 4.00
WHERE id = 2;


-- Eliminar una compra por su ID
DELETE FROM co.Compras
WHERE id = 1;

-- Eliminar compras realizadas antes de cierta fecha
DELETE FROM co.Compras
WHERE fechaCompra < '2023-08-12';


