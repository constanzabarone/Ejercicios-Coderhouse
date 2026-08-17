# Lenguaje M en el Editor Avanzado de Power Query

## Descripción

En esta práctica trabajé directamente con lenguaje M desde el Editor Avanzado de Power Query, sin utilizar los botones de la interfaz para realizar las transformaciones.

El objetivo fue limpiar una tabla de ventas de TechStore que presentaba problemas de calidad en los datos: espacios innecesarios en los nombres de productos, categorías escritas con distintos formatos, registros de prueba y tipos de datos que debían ser definidos correctamente.

La consulta utilizada se denominó `ventas_raw`.

---

## Transformaciones realizadas

El proceso ETL se organizó en distintos pasos dentro del bloque `let ... in`.

### 1. Origen

Se conservó el paso `Origen` generado automáticamente por Power BI al ingresar manualmente los datos de prueba.

Este paso representa la fuente sobre la cual se realizan todas las transformaciones posteriores.

### 2. Limpieza de espacios

Utilicé `Table.TransformColumns` junto con `Text.Trim` sobre la columna `nombre_producto`.

El objetivo fue eliminar los espacios innecesarios ubicados al inicio o al final de los nombres sin modificar el contenido interno.

Por ejemplo:

`" Laptop Pro 15 "` → `"Laptop Pro 15"`

### 3. Estandarización de categorías

Utilicé `Text.Proper` para estandarizar la columna `categoria`.

De esta manera, valores escritos con diferentes combinaciones de mayúsculas y minúsculas pasan a tener un mismo formato:

`computación` → `Computación`

`accesorios` → `Accesorios`

`PRUEBA` → `Prueba`

### 4. Eliminación de registros de prueba

Luego de estandarizar las categorías, utilicé `Table.SelectRows` para conservar solamente los registros cuya categoría fuera distinta de `"Prueba"`.

La condición utilizada fue:

`each [categoria] <> "Prueba"`

Los registros correspondientes a las ventas 3 y 6 fueron eliminados y la tabla final quedó con **5 filas**.

### 5. Tipado de columnas

Finalmente, utilicé `Table.TransformColumnTypes` para definir los tipos de datos:

- `id_venta`: `Int64.Type`
- `nombre_producto`: `type text`
- `categoria`: `type text`
- `precio`: `type number`
- `fecha_venta`: `type date`

Esto permite que cada campo sea interpretado correctamente por Power BI y pueda utilizarse posteriormente en filtros, cálculos y visualizaciones.

---

## Código M

El script completo y funcional se encuentra en el archivo:

`script_limpieza.md`

Todos los pasos fueron escritos directamente en el Editor Avanzado y comentados utilizando `//` para documentar la lógica aplicada.

---

## ¿Qué hace exactamente el bloque `let ... in` en lenguaje M? ¿Por qué cada paso puede referenciar al anterior?

La estructura `let ... in` organiza la secuencia de transformaciones de una consulta.

Dentro de `let` se definen los diferentes pasos. Cada paso tiene un nombre y genera un resultado que puede ser utilizado como entrada por el paso siguiente. En esta práctica, por ejemplo, `EstandarizarCategoria` utiliza el resultado de `LimpiarEspacios`, y `EliminarPruebas` utiliza el resultado de `EstandarizarCategoria`.

El `in` indica cuál de todos los pasos definidos será devuelto como resultado final. En este caso:

`in TiparColumnas`

Comprender esta estructura es útil no solamente para escribir código, sino también para mantener y escalar procesos ETL. Al estar las transformaciones divididas en pasos, es posible identificar dónde se produce un error, modificar una parte específica del proceso o reutilizar una lógica similar en otras consultas sin tener que rehacer todo desde cero.

---

## ¿Por qué M es Case Sensitive y qué consecuencia práctica tiene?

M es un lenguaje **Case Sensitive**, lo que significa que distingue entre mayúsculas y minúsculas.

Por ejemplo:

`Table.SelectRows`

no es lo mismo que:

`table.selectrows`

La segunda expresión generaría un error porque la función no existe escrita de esa manera.

Lo mismo ocurre con los nombres de los pasos y las referencias. Si un paso se llama `LimpiarEspacios` y posteriormente escribo `limpiarEspacios`, Power Query no lo reconoce como el mismo identificador.

Por eso, al trabajar directamente con M es importante respetar exactamente la escritura de funciones, variables y pasos.

---

## ¿Cuál es la diferencia entre `Text.Trim` y `Text.Clean` en M?

Aunque ambas funciones se utilizan para limpiar texto, resuelven problemas diferentes.

`Text.Trim` elimina los espacios o caracteres especificados que se encuentran **al principio y al final** de un texto. Por eso fue la función utilizada en `nombre_producto`.

Por ejemplo:

`" Laptop Pro 15 "` → `"Laptop Pro 15"`

`Text.Clean`, en cambio, se utiliza para eliminar **caracteres de control o no imprimibles** que pueden existir dentro de un texto, algo frecuente cuando los datos provienen de determinados sistemas o archivos externos.

Por lo tanto, en esta práctica correspondía utilizar `Text.Trim`, ya que el problema identificado eran específicamente los espacios sobrantes al inicio y al final de los nombres.

---

## ¿Por qué filtré los registros "PRUEBA" después de estandarizar la categoría y no antes?

El orden de las transformaciones es importante.

El lenguaje M distingue entre mayúsculas y minúsculas. Si hubiera aplicado directamente:

`each [categoria] <> "Prueba"`

sobre los datos originales, un valor escrito como `"PRUEBA"` podría no coincidir con `"Prueba"` y, por lo tanto, permanecer en la tabla.

Primero utilicé `Text.Proper` para llevar las diferentes formas de escritura a un mismo formato:

`PRUEBA` → `Prueba`

Luego apliqué el filtro sobre `"Prueba"`.

De esta manera, el filtro trabaja sobre datos previamente estandarizados y se reduce el riesgo de conservar registros que deberían ser eliminados.

---

## Resultado final

Luego de ejecutar el script:

- La tabla quedó con **5 registros**.
- Se eliminaron los espacios al inicio y al final de `nombre_producto`.
- Las categorías quedaron estandarizadas.
- Se eliminaron los registros correspondientes a la categoría `Prueba`.
- Todas las columnas quedaron con el tipo de dato correspondiente.
- El código se ejecutó correctamente desde el Editor Avanzado.

---

## Conclusión

Esta práctica me permitió avanzar un paso más en el uso de Power Query, ya que las transformaciones fueron escritas directamente en lenguaje M en lugar de ser generadas desde la interfaz.

Lo que más me permitió comprender fue la lógica secuencial del bloque `let ... in`: cada transformación genera un resultado que se convierte en la entrada de la siguiente. Esto hace que el proceso sea más fácil de seguir, mantener y modificar.

También pude comprobar la importancia de estandarizar los datos antes de aplicar determinadas reglas. En este caso, normalizar primero las categorías permitió realizar después un filtro más consistente sobre los registros de prueba.

Entender esta lógica resulta útil para construir procesos ETL más mantenibles y reutilizables, especialmente cuando aumenta la cantidad de transformaciones o cuando una misma lógica debe aplicarse en distintas consultas.
