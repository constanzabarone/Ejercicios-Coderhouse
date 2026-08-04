# Módulo 5 – UNION y UNION ALL

## ¿Cuántas filas devuelve cada consulta y por qué son distintas? Explicá con ejemplos concretos de los datos qué filas se eliminaron con UNION.

La consulta con **UNION** devuelve **11 filas**, mientras que la consulta con **UNION ALL** devuelve **14 filas**.

La diferencia se debe a que **UNION elimina las filas completamente duplicadas**, mientras que **UNION ALL conserva todos los registros**, aunque se repitan.

En este ejercicio, los productos **103 (Monitor 4K 27")**, **104 (Teclado Mecánico)** y **106 (SSD Externo 1TB)** existen tanto en la sucursal Norte como en la sucursal Sur con el mismo **id_producto** y el mismo **nombre_producto**. Como esas filas son idénticas en las columnas seleccionadas, **UNION las muestra una sola vez**, mientras que **UNION ALL** conserva ambas.

Un caso interesante es el de la **Webcam HD 1080p**. Aunque el nombre del producto es el mismo en ambas sucursales, los identificadores son diferentes (**107** y **111**). Como las filas no son completamente iguales, **UNION no las elimina** y ambas aparecen en el resultado.

---

## ¿Por qué UNION ALL es más eficiente que UNION? ¿Qué operación adicional realiza UNION internamente que consume más recursos?

**UNION ALL** es más eficiente porque simplemente une los resultados de ambas consultas sin realizar ninguna comparación entre las filas.

En cambio, **UNION** debe revisar todos los registros obtenidos para identificar cuáles están repetidos y eliminar los duplicados antes de devolver el resultado final. Esa comparación adicional requiere más procesamiento y, cuando se trabaja con tablas muy grandes, consume más tiempo y recursos.

Por este motivo, si sé que no existen duplicados o necesito conservar todos los registros, utilizaría **UNION ALL** por su mejor rendimiento.

---

## ¿En qué casos de negocio usarías cada uno? Da al menos dos ejemplos reales distintos a los del ejercicio.

Utilizaría **UNION** cuando necesite obtener un listado único de información sin registros repetidos. Por ejemplo:

- Unificar la lista de clientes provenientes de dos sucursales para realizar una campaña de marketing sin enviar comunicaciones duplicadas.
- Consolidar un catálogo de proveedores registrados en distintas filiales de una empresa.

Utilizaría **UNION ALL** cuando sea importante conservar absolutamente todos los registros para realizar análisis o auditorías. Por ejemplo:

- Unificar las transacciones realizadas en distintos cajeros automáticos para analizar el volumen total de operaciones.
- Consolidar los movimientos diarios de varias sucursales bancarias para generar reportes operativos sin perder ningún registro.

---

## ¿Qué pasa si las columnas de ambas consultas no coinciden en número o tipo? ¿Qué error genera SQL?

Para utilizar **UNION** o **UNION ALL**, ambas consultas deben devolver la misma cantidad de columnas y estas deben tener tipos de datos compatibles.

Si una consulta devuelve más columnas que la otra, SQL genera un error indicando que todas las consultas combinadas deben tener el mismo número de expresiones en la lista de selección.

Si las columnas tienen tipos de datos incompatibles (por ejemplo, intentar unir un texto con una fecha o un dato numérico con un tipo no convertible), SQL también genera un error de conversión o incompatibilidad de tipos, ya que no puede combinar correctamente los resultados.
