Conectividad y Transformación de Datos en Power BI
Descripción

El objetivo de esta práctica fue preparar una base de ventas para su posterior análisis en Power BI. Para ello trabajé principalmente en Power Query, realizando la limpieza y transformación de los datos y organizándolos finalmente en un modelo compuesto por una tabla de hechos y dos dimensiones.

Transformaciones realizadas

Primero conecté Power BI con el archivo de origen y revisé la estructura general de los datos. A partir de allí realicé las siguientes transformaciones:

Renombré las columnas para reemplazar los nombres técnicos originales por nombres más claros, por ejemplo COD_CLI por ID_Cliente, F_VTA por Fecha_Venta, PU_VTA por Precio_Unitario y DTO_PCT por Porcentaje_Descuento.
Corregí los tipos de datos según el contenido de cada campo:
Los identificadores se mantuvieron como texto cuando contenían códigos alfanuméricos.
Fecha_Venta y Fecha_Alta_Cliente se configuraron como fecha.
Cantidad_Venta se configuró como número entero.
Precio_Unitario y Total_Venta se configuraron como números decimales.
Porcentaje_Descuento se configuró como porcentaje.
Los teléfonos se mantuvieron como texto, ya que no representan valores sobre los que se deban realizar cálculos.
Eliminé filas completamente vacías y registros duplicados. En las dimensiones también eliminé duplicados utilizando su identificador como criterio, para garantizar una única fila por cliente y por producto.
Revisé los valores nulos. No todos fueron eliminados automáticamente, ya que un valor nulo no necesariamente representa un error. Por ejemplo, se conservaron campos opcionales de contacto cuando no existía información disponible. Los nulos fueron analizados según el significado de cada columna para evitar eliminar registros válidos.
Creé una consulta denominada Datos_Base, que conserva los datos limpios y funciona como origen para las tablas del modelo. A partir de ella generé consultas por referencia para evitar repetir el proceso de transformación.
Estructura del modelo

Aunque la consigna requería diferenciar los datos del cliente de los datos de las transacciones, decidí separar también la información de productos para reducir la redundancia y obtener una estructura más adecuada para el análisis.

El modelo quedó compuesto por:

F_Ventas – Tabla de hechos

Contiene la información propia de cada operación: identificador de venta y cliente, código de producto, fecha, cantidad, precio unitario, porcentaje de descuento, total de venta, moneda y canal de venta.

D_Clientes – Dimensión clientes

Contiene una única fila por cliente con sus datos descriptivos, como nombre, mail, teléfono, ciudad, provincia, segmento, estado y fecha de alta.

D_Producto – Dimensión productos

Contiene una única fila por producto con su código, nombre y rubro.

Las relaciones se configuraron como uno a varios (1:*), desde cada dimensión hacia F_Ventas, utilizando ID_Cliente y Codigo_Producto como claves de relación y dirección de filtro única.

De esta manera, el resultado final es un modelo estrella, con F_Ventas como tabla central y D_Clientes y D_Producto como dimensiones, evitando información redundante y dejando los datos preparados para la posterior construcción de métricas y visualizaciones en Power BI.
