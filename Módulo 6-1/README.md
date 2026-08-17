# Práctica – Lenguaje M en Power Query

## Descripción

En esta práctica trabajé con un dataset de ventas minoristas con el objetivo de aplicar transformaciones desde Power Query y luego analizar el código M generado automáticamente.

La idea principal fue entender qué sucede detrás de las transformaciones que normalmente realizamos desde la interfaz y comenzar a trabajar directamente con el Editor Avanzado.

## Dataset utilizado

Para realizar la práctica utilicé el dataset **Retail Store Sales**, obtenido de una fuente pública.

**Fuente:** https://www.kaggle.com/datasets/ahmedmohamed2003/retail-store-sales-dirty-for-data-cleaning?resource=download

Elegí este dataset porque contiene información de transacciones de ventas y combina distintos tipos de datos, como texto, valores numéricos y fechas. Además, presenta valores nulos en algunas columnas, por lo que me pareció adecuado para trabajar transformaciones en Power Query.

Entre sus campos se encuentran:

- Transaction ID
- Customer ID
- Category
- Item
- Price Per Unit
- Quantity
- Total Spent
- Payment Method
- Location
- Transaction Date
- Discount Applied

## Transformaciones realizadas

Primero cargué el archivo CSV en Power BI y accedí al Editor de Power Query para revisar su estructura.

Desde la interfaz realicé las siguientes transformaciones:

1. **Cambio de tipo de dato:** modifiqué `Price Per Unit` a número decimal, ya que representa el precio unitario de los productos y debe poder utilizarse en cálculos.

2. **Renombrado de columna:** cambié `Total Spent` por `Total_Venta`, para utilizar un nombre más descriptivo y fácil de interpretar.

3. **Filtrado de filas:** apliqué un filtro sobre `Quantity` para conservar únicamente los registros cuya cantidad fuera mayor a 0.

### Pasos aplicados en Power Query

<img width="307" height="214" alt="image" src="https://github.com/user-attachments/assets/8f62f071-38f4-4925-ab1e-2067ba47181b" />


## Modificación manual en lenguaje M

Después de realizar las transformaciones desde la interfaz, ingresé al **Editor Avanzado** para observar el código M generado por Power Query.

Dentro del código renombré manualmente el paso correspondiente al cambio de nombre de la columna:

`#"Columnas con nombre cambiado"`

por:

`#"RenombradoManual"`

También actualicé la referencia utilizada por el paso siguiente para mantener correctamente la secuencia de transformaciones.

Además, incorporé un comentario utilizando `//` para explicar el objetivo de esa transformación.

### Código M final

```powerquery
let
  Origen = Csv.Document(File.Contents("D:\Escritorio\retail_store_sales.csv..csv"), [Delimiter = ",", Columns = 11, QuoteStyle = QuoteStyle.None]),
  #"Encabezados promovidos" = Table.PromoteHeaders(Origen, [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"Transaction ID", type text}, {"Customer ID", type text}, {"Category", type text}, {"Item", type text}, {"Price Per Unit", Int64.Type}, {"Quantity", Int64.Type}, {"Total Spent", Int64.Type}, {"Payment Method", type text}, {"Location", type text}, {"Transaction Date", type date}, {"Discount Applied", type logical}}, "es"),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Tipo de columna cambiado",{{"Price Per Unit", type number}}),
   // Renombro la columna Total Spent para que el nombre sea más claro para el análisis
  #"RenombradoManual" = Table.RenameColumns(#"Tipo cambiado",{{"Total Spent", "Total_Venta"}}),
  #"Filas filtradas" = Table.SelectRows(#"RenombradoManual", each [Quantity] > 0)
in
  #"Filas filtradas"
