-- Crear la base de datos
CREATE DATABASE ejercicio_2;

USE ejercicio_2;

-- Crear la tabla inquilino
CREATE TABLE inquilino (
  dni INT PRIMARY KEY,
  nombre VARCHAR(255),
  apellido VARCHAR(255)
);

-- Crear la tabla dueño
CREATE TABLE dueño (
  dni INT PRIMARY KEY,
  nombre VARCHAR(255),
  apellido VARCHAR(255)
);

-- Crear la tabla casa
CREATE TABLE casa (
  id INT PRIMARY KEY AUTO_INCREMENT,
  dni_dueño INT,
  barrio VARCHAR(255),
  calle VARCHAR(255),
  cant_habitaciones INT,
  cant_patios INT,
  FOREIGN KEY (dni_dueño) REFERENCES dueño(dni)
);

-- Crear la tabla contrato
CREATE TABLE contrato (
  id INT PRIMARY KEY AUTO_INCREMENT,
  dni_inquilino INT,
  id_casa INT,
  deuda DECIMAL(10, 2),
  monto_alquiler DECIMAL(10, 2),
  FOREIGN KEY (dni_inquilino) REFERENCES inquilino(dni),
  FOREIGN KEY (id_casa) REFERENCES casa(id)
);




-- Datos de prueba para la tabla "dueño"
INSERT INTO dueño (dni, nombre, apellido) VALUES
(11111111, 'Pedro', 'Gomez'),
(22222222, 'Fabo', 'Romero'),
(33333333, 'Luis', 'Gomez'),
(44444444, 'Maria', 'Rodriguez');

-- Datos de prueba para la tabla "casa"
INSERT INTO casa (id, dni_dueño, barrio, calle, cant_habitaciones, cant_patios) VALUES
(1, 22222222, 'Centro', 'Colon 714', 2, 1),
(2, 11111111, 'Alberdi', 'San Martin 200', 3, 0),
(3, 33333333, 'Alberdi', 'Belgrano 300', 4, 1),
(4, 22222222, 'Centro', 'Urquiza 400', 3, 0),
(5, 44444444, 'Alberdi', 'Pellegrini 500', 2, 1);

INSERT INTO casa (id, dni_dueño, barrio, calle, cant_habitaciones, cant_patios) VALUES
(6, 22222222, 'Centro', 'Colon 1000 ', 1, 0),
(7, 33333333, 'Alberdi', 'San Martin 400', 3, 0),
(8, 33333333, 'Alberdi', 'Belgrano 500', 4, 1),
(9, 22222222, 'Centro', 'Urquiza 600', 1, 0),
(10, 44444444, 'Alberdi', 'Pellegrini 700', 2, 1);
INSERT INTO casa (id, dni_dueño, barrio, calle, cant_habitaciones, cant_patios) VALUES
(11, 33333333, 'Centro', 'Colon 1200 ', 1, 0),
(12, 44444444, 'Alberdi', 'San Martin 600', 3, 0);

-- Datos de prueba para la tabla "inquilino"
INSERT INTO inquilino (dni, nombre, apellido) VALUES
(12345678, 'Juan', 'Perez'),
(23456789, 'Maria', 'Lopez'),
(34567890, 'Carlos', 'Gomez');


-- Datos de prueba para la tabla "contrato"
INSERT INTO contrato (id, dni_inquilino, id_casa, deuda, monto_alquiler) VALUES
(1, 12345678, 1, 5000, 4000),
(2, 23456789, 2, 0, 4500),
(3, 23456789, 3, 1000, 4500),
(4, 23456789, 4, 2000, 5000),
(5, 34567890, 5, 0, 5500);
