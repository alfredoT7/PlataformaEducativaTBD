SELECT obtener_materia_docente_por_estudiante_excluyendo(1);


select id_materia, id_docente 
from inscripcion
where id_estudiante not in(
	select id_estudiante
	from inscripcion
	where id_estudiante=1
)

SELECT m.ID_MATERIA, m.NOMBRE_MATERIA
FROM MATERIA m
WHERE NOT EXISTS (
    SELECT 1
    FROM INSCRIPCION i
    WHERE i.ID_MATERIA = m.ID_MATERIA
    AND i.ID_ESTUDIANTE = 1
);




CREATE OR REPLACE FUNCTION obtener_materias_no_inscritas(_id_estudiante INTEGER)
RETURNS TABLE(id_materia INTEGER, id_docente INTEGER, nom_materia VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT m.ID_MATERIA, m.ID_DOCENTE, m.NOMBRE_MATERIA
    FROM MATERIA m
    WHERE NOT EXISTS (
        SELECT 1
        FROM INSCRIPCION i
        WHERE i.ID_MATERIA = m.ID_MATERIA
        AND i.ID_ESTUDIANTE = _id_estudiante
    );
END;
$$ LANGUAGE plpgsql;



SELECT t.ID_TAREA, t.NOMBRE_TAREA, t.FECHA_ASIGNACION, t.FECHA_ENTREGA, t.DESCRIPCION_TAREA
FROM TAREA t
JOIN MATERIA_TAREA mt ON t.ID_TAREA = mt.ID_TAREA
JOIN INSCRIPCION i ON mt.ID_MATERIA = i.ID_MATERIA AND mt.ID_DOCENTE = i.ID_DOCENTE
WHERE i.ID_ESTUDIANTE = 1;


SELECT t.id_tarea,t.nombre_tarea--, t.FECHA_ASIGNACION, t.FECHA_ENTREGA, t.DESCRIPCION_TAREA
SELECT t.id_tarea,t.nombre_tarea
FROM (
    SELECT mt.id_tarea
    FROM (SELECT i.ID_MATERIA, i.ID_DOCENTE
          FROM (SELECT e.ID_ESTUDIANTE
            	FROM ESTUDIANTE e
            	WHERE e.ID_ESTUDIANTE = 1
       	 ) est, INSCRIPCION i
       	 WHERE est.ID_ESTUDIANTE = i.ID_ESTUDIANTE
    ) insc, MATERIA_TAREA mt
    WHERE insc.ID_MATERIA = mt.ID_MATERIA AND insc.ID_DOCENTE = mt.ID_DOCENTE
) tareas, TAREA t
WHERE t.ID_TAREA = tareas.ID_TAREA;




--linux es un kernel
SELECT * FROM ENTREGA;




SELECT
    t.ID_TAREA,
    t.NOMBRE_TAREA,
    t.FECHA_ASIGNACION,
    t.FECHA_ENTREGA,
    t.DESCRIPCION_TAREA
FROM TAREA t
JOIN MATERIA_TAREA mt ON t.ID_TAREA = mt.ID_TAREA
WHERE mt.ID_MATERIA IN (
    SELECT ID_MATERIA
    FROM INSCRIPCION
    WHERE ID_ESTUDIANTE = 1
)
AND NOT EXISTS (
    SELECT 1
    FROM ESTUDIANTE_ENTREGA ee
    WHERE ee.ID_ENTREGA = mt.ID_TAREA  -- Asegúrate de que esta sea la relación correcta
    AND ee.ID_ESTUDIANTE = 1
);


