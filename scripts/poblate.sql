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
RETURNS TABLE(nombre_materia VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT m.nombre_materia
    FROM (
        SELECT i.id_materia, i.id_docente
        FROM inscripcion i
        WHERE i.id_estudiante = _id_estudiante
    ) uno
    INNER JOIN materia m ON m.id_materia = uno.id_materia AND m.id_docente = uno.id_docente;
END;
$$ LANGUAGE plpgsql;
SELECT obtener_nombre_materia_por_estudiante(1);