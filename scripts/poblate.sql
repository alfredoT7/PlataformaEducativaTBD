INSERT INTO USUARIO (NOMBRE_USUARIO, CONTRASENIA, FECHA_NAC, NOMBRES, APELLIDOS) VALUES
('alfredo', 'notebok456', '2003-04-15', 'Alfredo', 'Torrico'),
('mariaq02', 'pass2345', '2004-05-20', 'Maria', 'Quispe'),
('carlosm03', 'pass3456', '1980-08-05', 'Carlos', 'Mamani'),
('luisag04', 'pass4567', '1975-02-25', 'Luisa', 'Garcia'),
('camila', 'notebok456', '2002-03-10', 'Camila', 'Torrico'),
('javierf06', 'pass6789', '1999-07-30', 'Javier', 'Fernandez'),
('sandrah07', 'pass7890', '2001-11-22', 'Sandra', 'Herrera'),
('laura', 'notebok456', '1985-09-14', 'Laura', 'Torrico'),
('danielc09', 'pass9012', '1982-12-17', 'Daniel', 'Castro'),
('soniag10', 'pass0123', '1978-10-05', 'Sonia', 'Gutierrez');

INSERT INTO TIPO_ARCHIVO (TIPO_ARCHIVO) VALUES
('.pdf'),
('.docx'),
('.pptx'),
('.xlxs'),
('.txt'),
('.jepg'),
('.png'),
('.mp4'),
('.mp3'),
('.zip');

INSERT INTO GRADO_ACADEMICO (GRADO_ACAD) VALUES
('Pregrado'),
('Técnico Superior'),
('Licenciatura'),
('Especialidad'),
('Maestría'),
('Doctorado'),
('Postdoctorado'),
('Diplomado'),
('Certificación Profesional'),
('Curso Avanzado');


INSERT INTO MATERIA (id_docente,nombre_materia, descripcion2) VALUES 
(5,'Matemáticas Avanzadas', 'Estudio de matemáticas aplicadas a la ingeniería'),
(5,'Física General', 'Conceptos fundamentales de la física y su aplicación en ingeniería'),
(5,'Programación', 'Introducción a la programación y estructuras de datos'),
(5,'Circuitos Eléctricos', 'Análisis de circuitos y sistemas eléctricos'),
(6,'Termodinámica', 'Principios de termodinámica y su aplicación en ingeniería'),
(6,'Mecánica de Fluidos', 'Estudio del comportamiento de los fluidos y su interacción con el entorno'),
(6,'Resistencia de Materiales', 'Análisis de la resistencia y propiedades de los materiales'),
(7,'Dinámica de Sistemas', 'Modelado y simulación de sistemas dinámicos en ingeniería'),
(7,'Control Automático', 'Principios y técnicas de control automático en sistemas de ingeniería'),
(7,'Ingeniería Ambiental', 'Estudio de los impactos ambientales y su mitigación en proyectos de ingeniería');


CREATE OR REPLACE FUNCTION insertar_materia(_id_docente INTEGER,_nombre_materia VARCHAR,_descripcion2 VARCHAR
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO MATERIA (id_docente, nombre_materia, descripcion2) VALUES 
    (_id_docente, _nombre_materia, _descripcion2);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION obtener_materias_por_docente(_id_docente INTEGER)
RETURNS TABLE(id_mat INTEGER, nom_materia VARCHAR) AS $$
BEGIN
    RETURN QUERY 
    SELECT id_materia, nombre_materia
    FROM MATERIA 
    WHERE id_docente = _id_docente;
END;
$$ LANGUAGE plpgsql;
SELECT obtener_materias_por_docente(5);


CREATE OR REPLACE FUNCTION insertar_tarea(_nombre_tarea VARCHAR,_fecha_asignacion DATE,_fecha_entrega DATE,_descripcion_tarea VARCHAR
)
RETURNS INTEGER AS $$
DECLARE
    _id_tarea INTEGER;
BEGIN
    INSERT INTO TAREA(nombre_tarea, fecha_asignacion, fecha_entrega, descripcion_tarea)
    VALUES (_nombre_tarea, _fecha_asignacion, _fecha_entrega, _descripcion_tarea)
    RETURNING id_tarea INTO _id_tarea;
    RETURN _id_tarea;
END;
$$ LANGUAGE plpgsql;


insert into materia_tarea(id_materia, id_docente, id_tarea, periodo_acad) values (...)


CREATE OR REPLACE FUNCTION insertar_materia_tarea(_id_materia INTEGER,_id_docente INTEGER,_id_tarea INTEGER,_periodo_acad VARCHAR
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO materia_tarea (id_materia, id_docente, id_tarea, periodo_acad) VALUES 
    (_id_materia, _id_docente, _id_tarea, _periodo_acad);
END;
$$ LANGUAGE plpgsql;


INSERT INTO INSCRIPCION (id_materia, id_docente, id_estudiante, periodo_academico) VALUES (1, 5, 1, 'I-2024');
INSERT INTO INSCRIPCION (id_materia, id_docente, id_estudiante, periodo_academico) VALUES (3, 5, 1, 'I-2024');
INSERT INTO INSCRIPCION (id_materia, id_docente, id_estudiante, periodo_academico) VALUES (5, 6, 1, 'I-2024');

INSERT INTO INSCRIPCION (id_materia, id_docente, id_estudiante, periodo_academico) VALUES (2, 5, 2, 'I-2024');
INSERT INTO INSCRIPCION (id_materia, id_docente, id_estudiante, periodo_academico) VALUES (4, 5, 2, 'I-2024');
INSERT INTO INSCRIPCION (id_materia, id_docente, id_estudiante, periodo_academico) VALUES (6, 6, 2, 'I-2024');

INSERT INTO INSCRIPCION (id_materia, id_docente, id_estudiante, periodo_academico) VALUES (3, 5, 3, 'I-2024');
INSERT INTO INSCRIPCION (id_materia, id_docente, id_estudiante, periodo_academico) VALUES (7, 6, 3, 'I-2024');
INSERT INTO INSCRIPCION (id_materia, id_docente, id_estudiante, periodo_academico) VALUES (9, 7, 3, 'I-2024');

INSERT INTO INSCRIPCION (id_materia, id_docente, id_estudiante, periodo_academico) VALUES (4, 5, 4, 'I-2024');
INSERT INTO INSCRIPCION (id_materia, id_docente, id_estudiante, periodo_academico) VALUES (8, 7, 4, 'I-2024');
INSERT INTO INSCRIPCION (id_materia, id_docente, id_estudiante, periodo_academico) VALUES (11, 5, 4, 'I-2024');


select nombre_materia 
	from(select id_materia, id_docente from inscripcion 
		where id_estudiante=1) uno, materia
where materia.id_materia=uno.id_materia and materia.id_docente=uno.id_docente

CREATE OR REPLACE FUNCTION obtener_nombre_materia_por_estudiante(_id_estudiante INTEGER)
RETURNS TABLE(id_materia INTEGER, id_docente INTEGER, nombre_materia VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT m.id_materia, m.id_docente, m.nombre_materia
    FROM inscripcion i
    JOIN materia m ON m.id_materia = i.id_materia AND m.id_docente = i.id_docente
    WHERE i.id_estudiante = _id_estudiante;
END;
$$ LANGUAGE plpgsql;
SELECT obtener_nombre_materia_por_estudiante(1);



select id_materia, id_docente
from(	
select distinct id_materia as a1, id_docente as d1 --id_materia, id_docente
from inscripcion 
where id_estudiante not in(select id_estudiante from inscripcion where id_estudiante=1)
) one, materia
where one.a1=materia.id_materia and one.d1 = materia.id_docente



CREATE OR REPLACE FUNCTION obtener_nombre_materia_por_estudiante(_id_estudiante INTEGER)
RETURNS TABLE(id_materia INTEGER, id_docente INTEGER, nombre_materia VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT m.id_materia, m.id_docente, m.nombre_materia
    FROM inscripcion i
    JOIN materia m ON m.id_materia = i.id_materia AND m.id_docente = i.id_docente
    WHERE i.id_estudiante = _id_estudiante;
END;
$$ LANGUAGE plpgsql;
SELECT obtener_nombre_materia_por_estudiante(1);
DROP FUNCTION obtener_nombre_materia_por_estudiante(integer)





--funcion insertar_inscripcionFUNCIONA
CREATE OR REPLACE FUNCTION insertar_inscripcion(_id_materia INTEGER,_id_docente INTEGER,_id_estudiante INTEGER,_periodo_academico VARCHAR
)
RETURNS void AS $$
BEGIN
    INSERT INTO INSCRIPCION (id_materia, id_docente, id_estudiante, periodo_academico)
    VALUES (_id_materia, _id_docente, _id_estudiante, _periodo_academico);
END;
$$ LANGUAGE plpgsql;

SELECT insertar_inscripcion(3, 5, 1, 'I-2024');

--funcoin para obtener materias a la que el estudiante no esta inscrito
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
select obtener_materias_no_inscritas(1)
--obtener tareas por estudiante 

CREATE OR REPLACE FUNCTION obtener_tareas_por_cod_estudiant(_id_estudiante INTEGER)
RETURNS TABLE(id_tarea INTEGER, nombre_tarea VARCHAR) AS $$
BEGIN
    RETURN QUERY
	
	SELECT t.id_tarea,t.nombre_tarea
	FROM (
		SELECT mt.id_tarea
		FROM (SELECT i.ID_MATERIA, i.ID_DOCENTE
			  FROM (SELECT e.ID_ESTUDIANTE
					FROM ESTUDIANTE e
					WHERE e.ID_ESTUDIANTE =_id_estudiante
			 ) est, INSCRIPCION i
			 WHERE est.ID_ESTUDIANTE = i.ID_ESTUDIANTE
		) insc, MATERIA_TAREA mt
		WHERE insc.ID_MATERIA = mt.ID_MATERIA AND insc.ID_DOCENTE = mt.ID_DOCENTE
	) tareas, TAREA t
	WHERE t.ID_TAREA = tareas.ID_TAREA;
	
END;
$$ LANGUAGE plpgsql;
select obtener_tareas_por_cod_estudiant(1)

--insertar entrega
CREATE OR REPLACE FUNCTION insertar_entrega(_retraso_entrega BOOLEAN, _archivo BYTEA)
RETURNS INTEGER AS $$
DECLARE
    _id_entrega INTEGER;
BEGIN
    INSERT INTO ENTREGA(retraso_entrega, archivo)
    VALUES (_retraso_entrega, _archivo)
    RETURNING id_entrega INTO _id_entrega;

    RETURN _id_entrega;
END;
$$ LANGUAGE plpgsql;


--SELECT * FROM TAREA_ENTREGA;
SELECT * FROM TAREA_ENTREGA;
CREATE OR REPLACE FUNCTION insertar_tarea_entrega(_id_tarea INTEGER, _id_entrega INTEGER, _fecha_tarea_entregada DATE)
RETURNS VOID AS $$
BEGIN
    INSERT INTO TAREA_ENTREGA(id_tarea, id_entrega, fecha_tarea_entregada)
    VALUES (_id_tarea, _id_entrega, _fecha_tarea_entregada);
END;
$$ LANGUAGE plpgsql;


--SELECT * FROM ESTUDIANTE_ENTREGA;
SELECT * FROM ESTUDIANTE_ENTREGA;
CREATE OR REPLACE FUNCTION insertar_estudiante_entrega(_id_estudiante INTEGER, _id_entrega INTEGER)
RETURNS VOID AS $$
BEGIN
    INSERT INTO ESTUDIANTE_ENTREGA(id_estudiante, id_entrega)
    VALUES (_id_estudiante, _id_entrega);
END;
$$ LANGUAGE plpgsql;





SELECT distinct
    t.ID_TAREA, 
    t.NOMBRE_TAREA, 
    t.FECHA_ASIGNACION, 
    t.FECHA_ENTREGA, 
    t.DESCRIPCION_TAREA,
    e.ARCHIVO
FROM TAREA t
JOIN MATERIA_TAREA mt ON t.ID_TAREA = mt.ID_TAREA
JOIN INSCRIPCION i ON mt.ID_MATERIA = i.ID_MATERIA
JOIN ESTUDIANTE_ENTREGA ee ON i.ID_ESTUDIANTE = ee.ID_ESTUDIANTE
JOIN ENTREGA e ON ee.ID_ENTREGA = e.ID_ENTREGA
WHERE mt.ID_DOCENTE = 5 AND e.ARCHIVO IS NOT NULL;





SELECT DISTINCT
    t.ID_TAREA, 
    t.NOMBRE_TAREA, 
    t.FECHA_ASIGNACION, 
    t.FECHA_ENTREGA, 
    t.DESCRIPCION_TAREA,
    m.NOMBRE_MATERIA,  -- Asumiendo que 'NOMBRE_MATERIA' es el nombre de la columna en la tabla MATERIA
    e.ARCHIVO
FROM TAREA t
JOIN MATERIA_TAREA mt ON t.ID_TAREA = mt.ID_TAREA
JOIN MATERIA m ON mt.ID_MATERIA = m.ID_MATERIA  -- Uniendo la tabla MATERIA aquí
JOIN INSCRIPCION i ON m.ID_MATERIA = i.ID_MATERIA
JOIN ESTUDIANTE_ENTREGA ee ON i.ID_ESTUDIANTE = ee.ID_ESTUDIANTE
JOIN ENTREGA e ON ee.ID_ENTREGA = e.ID_ENTREGA
WHERE mt.ID_DOCENTE = 5 AND e.ARCHIVO IS NOT NULL;