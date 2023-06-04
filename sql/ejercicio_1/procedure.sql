DELIMITER //
CREATE PROCEDURE INSCRIPCION(
  IN p_dni_est INT,
  IN p_id_curso INT
)
BEGIN
  DECLARE v_estudiante_count INT;
  DECLARE v_curso_count INT;
  DECLARE v_inscripcion_count INT;

  -- Verificar si el estudiante está registrado
  SELECT COUNT(*) INTO v_estudiante_count
  FROM ESTUDIANTES
  WHERE DNI_EST = p_dni_est;

  IF v_estudiante_count = 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'El estudiante no está registrado.';
  END IF;

  -- Verificar si el curso está registrado
  SELECT COUNT(*) INTO v_curso_count
  FROM CURSO
  WHERE id_curso = p_id_curso;

  IF v_curso_count = 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'El curso no está registrado.';
  END IF;

  -- Verificar si el estudiante ya está inscrito en el curso
  SELECT COUNT(*) INTO v_inscripcion_count
  FROM CURSO_ESTUDIANTE
  WHERE dni_est = p_dni_est AND id_curso = p_id_curso;

  IF v_inscripcion_count > 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'El estudiante ya está inscrito en el curso.';
  END IF;

  -- Insertar la inscripción del estudiante en el curso
  INSERT INTO CURSO_ESTUDIANTE (dni_est, id_curso)
  VALUES (p_dni_est, p_id_curso);

  -- Mensaje de éxito
  SELECT 'Inscripción realizada correctamente.' AS mensaje;

END //

DELIMITER ;

