-- Tabla clientes
-- id_cliente usa INT porque representa un identificador numérico entero.
-- nombre usa VARCHAR(100) porque almacena texto de longitud variable.
-- perfil_bio usa VARCHAR(MAX) porque puede contener una descripción extensa.
-- fecha_registro usa DATE porque solo necesitamos almacenar la fecha.

CREATE TABLE clientes (
    id_cliente INT,
    nombre VARCHAR(100),
    perfil_bio VARCHAR(MAX),
    fecha_registro DATE
);

-- Tabla productos
-- id_producto usa INT porque representa un identificador numérico entero.
-- descripcion usa VARCHAR(255) porque almacena texto de longitud variable.
-- precio usa DECIMAL(10,2) porque permite guardar valores monetarios con precisión.
-- esta_activo usa BIT porque representa un estado lógico:
-- 1 = activo y 0 = inactivo.

CREATE TABLE productos (
    id_producto INT,
    descripcion VARCHAR(255),
    precio DECIMAL(10,2),
    esta_activo BIT
);
-- Se verifica que las tablas hayan sido creadas correctamente.

SELECT * FROM Productos
SELECT * FROM Clientes
