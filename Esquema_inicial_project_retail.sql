
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;



CREATE TABLE clientes (
    cliente_id      SERIAL,
    nombre          VARCHAR(50)  NOT NULL,
    apellido        VARCHAR(50)  NOT NULL,
    email           VARCHAR(100) NOT NULL,
    edad            INT          NOT NULL,
    fecha_registro  DATE         NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT pk_clientes          PRIMARY KEY (cliente_id),
    CONSTRAINT uq_clientes_email    UNIQUE (email),
    CONSTRAINT chk_clientes_edad    CHECK (edad >= 18)
);


CREATE TABLE productos (
    producto_id     SERIAL,
    nombre          VARCHAR(100)  NOT NULL,
    categoria       VARCHAR(50)   NOT NULL,
    precio          DECIMAL(10,2) NOT NULL,
    stock           INT           NOT NULL DEFAULT 0,
    CONSTRAINT pk_productos         PRIMARY KEY (producto_id),
    CONSTRAINT chk_productos_precio CHECK (precio > 0),
    CONSTRAINT chk_productos_stock  CHECK (stock >= 0)
);


CREATE TABLE ventas (
    venta_id        SERIAL,
    cliente_id      INT           NOT NULL,
    producto_id     INT           NOT NULL,
    cantidad        INT           NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_venta     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_ventas                 PRIMARY KEY (venta_id),
    CONSTRAINT fk_ventas_cliente         FOREIGN KEY (cliente_id)
        REFERENCES clientes (cliente_id) ON DELETE RESTRICT,
    CONSTRAINT fk_ventas_producto        FOREIGN KEY (producto_id)
        REFERENCES productos (producto_id) ON DELETE RESTRICT,
    CONSTRAINT chk_ventas_cantidad       CHECK (cantidad > 0),
    CONSTRAINT chk_ventas_precio_unitario CHECK (precio_unitario > 0)
);



BEGIN;

INSERT INTO clientes (nombre, apellido, email, edad, fecha_registro) VALUES
    ('Ana',     'García',    'ana.garcia@email.com',     34, '2026-01-15'),
    ('Martín',  'López',     'martin.lopez@email.com',   41, '2026-02-03'),
    ('Lucía',   'Fernández', 'lucia.fernandez@email.com', 27, '2026-03-22'),
    ('Diego',   'Sosa',      'diego.sosa@email.com',     55, '2026-04-10'),
    ('Carla',   'Romero',    'carla.romero@email.com',   19, '2026-05-05');

INSERT INTO productos (nombre, categoria, precio, stock) VALUES
    ('Alimento balanceado perro 15 kg', 'Alimentos',   45000.00, 30),
    ('Alimento balanceado gato 7,5 kg', 'Alimentos',   32000.00, 25),
    ('Collar ajustable para perro',     'Accesorios',   7500.00, 40),
    ('Rascador para gato',              'Accesorios',  18900.00, 12),
    ('Shampoo para perros 500 ml',      'Higiene',      6200.00, 50);


INSERT INTO ventas (cliente_id, producto_id, cantidad, precio_unitario, fecha_venta) VALUES
    (1, 1, 2, 45000.00, '2026-06-01 10:15:00'),
    (2, 3, 1,  7500.00, '2026-06-02 16:40:00'),
    (3, 4, 1, 18900.00, '2026-06-05 11:05:00'),
    (4, 2, 3, 32000.00, '2026-06-07 18:20:00'),
    (5, 5, 2,  6200.00, '2026-06-10 09:30:00'),
    (1, 5, 1,  6200.00, '2026-06-10 12:00:00');  -- venta de prueba

COMMIT;



SELECT producto_id, nombre, categoria, precio
FROM productos
WHERE categoria = 'Alimentos';


UPDATE productos
SET precio = ROUND(precio * 1.10, 2)
WHERE categoria = 'Alimentos';

SELECT venta_id, cliente_id, producto_id, cantidad, precio_unitario, fecha_venta
FROM ventas
WHERE venta_id = 6;


DELETE FROM ventas
WHERE venta_id = 6;



SELECT 'clientes'  AS tabla, COUNT(*) AS registros FROM clientes
UNION ALL
SELECT 'productos', COUNT(*) FROM productos
UNION ALL
SELECT 'ventas',    COUNT(*) FROM ventas;
