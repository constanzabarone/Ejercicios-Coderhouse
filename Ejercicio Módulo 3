
CREATE DATABASE modulo2_unidad1_diseno;
-- Se crea la base de datos para almacenar las tablas del ejercicio.

USE Modulo2_unidad1_diseno;
-- Se selecciona la base de datos creada para trabajar sobre ella.

-- Se crea la tabla clientes.
-- Cada columna utiliza un tipo de dato acorde a la información almacenada.

CREATE TABLE Clientes (
ID_Cliente INT,
Nombre VARCHAR(100),
Perfil_bio TEXT, 
fecha_registro DATE
);

-- Se crea la tabla productos.
-- DECIMAL(10,2) permite almacenar el precio con precisión.
-- BIT permite representar si el producto está activo (1) o inactivo (0).

CREATE TABLE Productos(
ID_Productos INT,
Descripciones VARCHAR(255),
Precio DECIMAL(10,2),
esta_activo BIT
);

-- Se verifica que las tablas hayan sido creadas correctamente.

SELECT * FROM Productos
SELECT * FROM Clientes
