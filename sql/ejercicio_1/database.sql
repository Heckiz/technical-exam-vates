-- Crear la base de datos
CREATE DATABASE ejercicio_1;
USE ejercicio_1;

-- Crear la tabla curso
CREATE TABLE curso (
  id_curso INT PRIMARY KEY,
  nom_curso VARCHAR(255)
);

-- Crear la tabla estudiantes
CREATE TABLE estudiantes (
  dni_est INT PRIMARY KEY,
  nom_apell VARCHAR(255)
);

-- Crear la tabla materia
CREATE TABLE materia (
  id_materia INT PRIMARY KEY,
  nom_materia VARCHAR(255)
);
-- Crear la tabla curso_estudiante
CREATE TABLE curso_estudiante (
  dni_est INT,
  id_curso INT,
  PRIMARY KEY (dni_est, id_curso),
  FOREIGN KEY (dni_est) REFERENCES estudiantes(dni_est),
  FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);


-- Crear la tabla evaluacion
CREATE TABLE evaluacion (
  id_curso INT,
  id_evaluacion INT,
  id_materia INT,
  fecha DATE,
  PRIMARY KEY (id_curso, id_materia, id_evaluacion),
  FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
  FOREIGN KEY (id_materia) REFERENCES materia(id_materia)
);


ALTER TABLE evaluacion
ADD INDEX idx_id_evaluacion (id_evaluacion);

-- Crear la tabla estudiante_evaluacion
CREATE TABLE estudiante_evaluacion (
  dni_est INT,
  id_evaluacion INT,
  calificacion INT,
  PRIMARY KEY (dni_est, id_evaluacion),
  FOREIGN KEY (dni_est) REFERENCES estudiantes(dni_est),
  FOREIGN KEY (id_evaluacion) REFERENCES evaluacion(id_evaluacion)
);


-- Insertar datos en la tabla estudiantes
INSERT INTO estudiantes (dni_est, nom_apell)
VALUES (40474620, 'Fabo Romero'),
       (38624015, 'Bender Rodriguez'),
       (35645208, 'Philip  J. Fry');

-- Insertar datos en la tabla materia
INSERT INTO materia (id_materia, nom_materia)
VALUES (1, 'Robotica'),
       (2, 'Astronomia'),
       (3, 'Programación');

-- Insertar datos en la tabla curso
INSERT INTO curso (id_curso, nom_curso)
VALUES (1, 'curso A'),
       (2, 'curso B'),
       (3, 'curso C');

-- Insertar datos en la tabla curso_estudiante
INSERT INTO curso_estudiante (dni_est, id_curso)
VALUES (40474620, 1),
       (38624015, 2),
       (35645208, 1);

-- Insertar datos en la tabla evaluacion
INSERT INTO evaluacion (id_curso, id_evaluacion, id_materia, fecha)
VALUES (1, 1, 1, '2023-01-01'),
       (1, 2, 2, '2023-02-01'),
       (2, 1, 1, '2023-03-01');

-- Insertar datos en la tabla estudiante_evaluacion
INSERT INTO estudiante_evaluacion (dni_est, id_evaluacion, calificacion)
VALUES (40474620, 1, 80),
       (38624015, 1, 90),
       (35645208, 2, 85);
