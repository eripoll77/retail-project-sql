# Proyecto Retail – SQL (PostgreSQL)

Esquema base de un proyecto retail (tienda de mascotas PetStop) con las tablas `clientes`, `productos` y `ventas`, sus restricciones de integridad y una carga inicial de datos.

## Contenido

| Archivo | Descripción |
|---|---|
| `Esquema_inicial_project_retail.sql` | DDL de las tres tablas con PRIMARY KEY, FOREIGN KEY, UNIQUE y CHECK; carga inicial dentro de `BEGIN ... COMMIT`; un `UPDATE` masivo de precios y un `DELETE` de una venta de prueba, ambos con `WHERE`. |

## Cómo ejecutarlo

1. Crear la base de datos (ejecutar esta sentencia sola):
   ```sql
   CREATE DATABASE retail_project;
   ```
2. Conectarse a la base `retail_project` en pgAdmin o DBeaver.
3. Abrir `Esquema_inicial_project_retail.sql` y ejecutar el script completo.

El script se puede volver a ejecutar: al principio borra las tablas si ya existen y las crea de nuevo.

## Resultado esperado

Al final, la consulta de verificación muestra 5 registros en cada tabla (`clientes`, `productos` y `ventas`).
