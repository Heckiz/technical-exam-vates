--1)   Mostrar los datos de los dueños de la casa ubicada en Colon 714 en el barrio Centro.
SELECT dueño.* 
FROM dueño 
JOIN casa  ON dueño.dni = casa.dni_dueño
WHERE casa.calle = 'Colon 714' AND casa.barrio = 'Centro';

--2)   ¿Cuánta plata en total le deben a cada dueño del barrio Alberdi?
SELECT dueño.*, SUM(contrato.deuda) AS 'TOTAL A COBRAR ($)'
FROM dueño 
JOIN casa ON dueño.dni = casa.dni_dueño
JOIN contrato ON contrato.id_casa = casa.id
WHERE casa.barrio = 'Alberdi'
GROUP BY dueño.dni, casa.id;

--3)   ¿Cuál es la deuda total de cada inquilino, mostrar los datos de los inquilinos?
SELECT inquilino.*, SUM(contrato.deuda) as "DEUDA TOTAL ($)"
FROM inquilino 
JOIN contrato ON contrato.dni_inquilino = inquilino.dni
GROUP BY inquilino.dni;

--4)   Mostrar los datos de las personas que poseen más de 3 casas, con apellido “Gomez”.
SELECT dueño.*, count(casa.id) AS "CANTIDAD DE CASAS"
FROM dueño 
JOIN casa  ON dueño.dni = casa.dni_dueño
WHERE dueño.apellido = 'Gomez'
GROUP BY dueño.dni
HAVING COUNT(casa.id) > 3;

--5)   Mostrar los datos de las personas que poseen más de 2 casas con más de 2 habitaciones.
SELECT dueño.*, count(casa.id) AS "CANTIDAD DE CASAS"
FROM dueño 
JOIN casa  ON dueño.dni = casa.dni_dueño
WHERE casa.cant_habitaciones>2
GROUP BY dueño.dni
HAVING COUNT(casa.id) > 2 ;

--6)   Mostrar los datos de los inquilinos que alquilen más de 1 casa que con más de 1 habitación y sin patio.
SELECT inquilino.*, count(casa.id) AS "CANTIDAD DE CASAS"
FROM inquilino 
JOIN contrato  ON contrato.dni_inquilino = inquilino.dni
JOIN casa ON contrato.id_casa = casa.id
WHERE casa.cant_habitaciones>1 AND casa.cant_patios = 0
GROUP BY inquilino.dni
HAVING COUNT(casa.id) > 1 ;

--7)   Mostrar los datos de los dueños que tengan deudores en todas sus casas.
SELECT dueño.*
FROM dueño 
JOIN casa ON dueño.dni = casa.dni_dueño
JOIN contrato ON contrato.id_casa = casa.id
GROUP BY dueño.dni;


--8) Calcular las siguientes estadísticas:
--a.    Cantidad de casas de cada dueño. 
--b.    Dueño/s con más casas.
--c.    Dueño/s con más casas en cada barrio.
--d.    Casa que más veces se alquiló.


--A) Cantidad de casas de cada dueño. 
SELECT dueño.*, COUNT(casa.id) AS 'CANTIDAD DE CASAS'
FROM dueño
JOIN casa ON dueño.dni = casa.dni_dueño
GROUP BY dueño.dni;

--B) Dueño/s con más casas.
SELECT dueño.dni, dueño.nombre, COUNT(casa.id) AS cantidad_casas
FROM dueño 
JOIN casa  ON dueño.dni = casa.dni_dueño
GROUP BY dueño.dni
ORDER BY cantidad_casas DESC
LIMIT 1;

--C) Dueño/s con más casas en cada barrio.
SELECT casa.barrio, dueño.dni, dueño.nombre,  COUNT(casa.id) AS cantidad_casas
FROM dueño 
JOIN casa  ON dueño.dni = casa.dni_dueño
GROUP BY casa.barrio, dueño.dni
ORDER BY cantidad_casas DESC;


--D) Casa que más veces se alquiló.
SELECT casa.id, casa.calle, casa.barrio, COUNT(contrato.id) AS veces_alquilada
FROM casa
JOIN contrato ON casa.id = contrato.id_casa
GROUP BY casa.id
ORDER BY veces_alquilada DESC
LIMIT 1;

--9) Mostrar cuantas casas hay con 3 habitaciones cuyo monto de alquiler este entre $4500 y $5500.
SELECT COUNT(*) AS cantidad_casas
FROM casa
WHERE casa.cant_habitaciones = 3 AND casa.id IN (
    SELECT id_casa
    FROM contrato
    WHERE monto_alquiler >= 4500 AND monto_alquiler <= 5500
);