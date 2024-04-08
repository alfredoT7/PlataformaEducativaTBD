create table COMENTARIO (
   ID_COMENTARIO        SERIAL               not null,
   COM_ID_COMENTARIO    INT4                 null,
   COMENTARIO           VARCHAR(200)         null,
   constraint PK_COMENTARIO primary key (ID_COMENTARIO)
);
create table DOCENTE (
   ID_DOCENTE           INT4                 not null,
   DOCENTE_DESDE        DATE                 not null,
   constraint PK_DOCENTE primary key (ID_DOCENTE)
);
create table ENTREGA (
   ID_ENTREGA           SERIAL               not null,
   ID_TIPO_ARCHIVO      INT4                 null,
   ID_COMENTARIO        INT4                 null,
   ENTREGADO            BOOL                 not null,
   RETRASO_ENTREGA      BOOL                 not null,
   CALIFICACION         INT4                 null,
   constraint PK_ENTREGA primary key (ID_ENTREGA)
);
create table ESTUDIANTE (
   ID_ESTUDIANTE        INT4                 not null,
   ESTADO_MATRICULA     BOOL                 not null,
   CORREO_ESTIDIANTIL   VARCHAR(30)          not null,
   constraint PK_ESTUDIANTE primary key (ID_ESTUDIANTE)
);
create table FUNCION (
   ID_FUNCION           INT4                 not null,
   NOM_FUNCION          VARCHAR(30)          not null,
   FUNCION_ACTIVA       BOOL                 not null,
   constraint PK_FUNCION primary key (ID_FUNCION)
);
create table FUNCION_UI (
   ID_FUNCION           INT4                 not null,
   ID_UI                INT4                 not null,
   constraint PK_FUNCION_UI primary key (ID_FUNCION, ID_UI)
);
create table GRADO_ACADEMICO (
   ID_GRADO_ACAD        SERIAL               not null,
   GRADO_ACAD           VARCHAR(30)          not null,
   constraint PK_GRADO_ACADEMICO primary key (ID_GRADO_ACAD)
);
create table LICENCIATURA (
   ID_USERN             INT4                 not null,
   ID_GRADO_ACAD        INT4                 not null,
   ID_LICENCIATURA      SERIAL               not null,
   NOM_LICENCIATURA     VARCHAR(30)          not null,
   constraint PK_LICENCIATURA primary key (ID_USERN, ID_GRADO_ACAD, ID_LICENCIATURA)
);
create table MATERIA (
   ID_ESTUDIANTE        INT4                 not null,
   ID_DOCENTE           INT4                 not null,
   ID_MATERIA           SERIAL               not null,
   NOMBRE_MATERIA       VARCHAR(30)          not null,
   DESCRIPCION2         VARCHAR(30)          not null,
   constraint PK_MATERIA primary key (ID_ESTUDIANTE, ID_DOCENTE, ID_MATERIA)
);
create table ROL (
   ID_ROL               SERIAL               not null,
   NOM_ROL              VARCHAR(100)         not null,
   ROL_ACTIVO           BOOL                 not null,
   constraint PK_ROL primary key (ID_ROL)
);
create table ROL_FUNCION (
   ID_FUNCION           INT4                 not null,
   ID_ROL               INT4                 not null,
   constraint PK_ROL_FUNCION primary key (ID_FUNCION, ID_ROL)
);
create table ROL_USUARIO (
   ID_ROL               INT4                 not null,
   ID_USERN             INT4                 not null,
   FECHA_ACTIVACION     DATE                 not null,
   DESDE                DATE                 not null,
   HASTA                DATE                 null,
   constraint PK_ROL_USUARIO primary key (ID_ROL, ID_USERN, FECHA_ACTIVACION)
);
create table SESION (
   ID_USERN             INT4                 not null,
   ID_SESION            SERIAL               not null,
   PID                  INT4                 not null,
   constraint PK_SESION primary key (ID_USERN, ID_SESION)
);
create table TAREA (
   ID_ESTUDIANTE        INT4                 not null,
   ID_DOCENTE           INT4                 not null,
   ID_MATERIA           INT4                 not null,
   ID_ENTREGA           INT4                 not null,
   NOMBRE_TAREA         VARCHAR(30)          not null,
   FECHA_ASIGNACION     DATE                 not null,
   FECHA_ENTREGA        DATE                 null,
   DESCRIPCION_TAREA    VARCHAR(200)         null,
   constraint PK_TAREA primary key (ID_ESTUDIANTE, ID_DOCENTE, ID_MATERIA, ID_ENTREGA, FECHA_ASIGNACION)
);
create table TIPO_ARCHIVO (
   ID_TIPO_ARCHIVO      SERIAL               not null,
   TIPO_ARCHIVO         VARCHAR(10)          not null,
   constraint PK_TIPO_ARCHIVO primary key (ID_TIPO_ARCHIVO)
);
create table UI (
   ID_UI                INT4                 not null,
   NOMBRE_UI            VARCHAR(30)          not null,
   UI_ACTIVA            BOOL                 not null,
   constraint PK_UI primary key (ID_UI)
);
create table USUARIO (
   ID_USERN             SERIAL               not null,
   NOMBRE               VARCHAR(30)          not null,
   CONTRASENIA          VARCHAR(30)          not null,
   FECHA_NAC            DATE                 not null,
   constraint PK_USUARIO primary key (ID_USERN)
);

alter table COMENTARIO
   add constraint FK_COMENTAR_RELATIONS_COMENTAR foreign key (COM_ID_COMENTARIO)
      references COMENTARIO (ID_COMENTARIO)
      on delete cascade on update restrict;

alter table DOCENTE
   add constraint FK_DOCENTE_RELATIONS_USUARIO foreign key (ID_DOCENTE)
      references USUARIO (ID_USERN)
      on delete cascade on update restrict;

alter table ENTREGA
   add constraint FK_ENTREGA_RELATIONS_COMENTAR foreign key (ID_COMENTARIO)
      references COMENTARIO (ID_COMENTARIO)
      on delete cascade on update restrict;

alter table ENTREGA
   add constraint FK_ENTREGA_RELATIONS_TIPO_ARC foreign key (ID_TIPO_ARCHIVO)
      references TIPO_ARCHIVO (ID_TIPO_ARCHIVO)
      on delete cascade on update restrict;

alter table ESTUDIANTE
   add constraint FK_ESTUDIAN_RELATIONS_USUARIO foreign key (ID_ESTUDIANTE)
      references USUARIO (ID_USERN)
      on delete cascade on update restrict;

alter table FUNCION_UI
   add constraint FK_FUNCION__RELATIONS_UI foreign key (ID_UI)
      references UI (ID_UI)
      on delete cascade on update restrict;

alter table FUNCION_UI
   add constraint FK_FUNCION__RELATIONS_FUNCION foreign key (ID_FUNCION)
      references FUNCION (ID_FUNCION)
      on delete cascade on update restrict;

alter table LICENCIATURA
   add constraint FK_LICENCIA_RELATIONS_GRADO_AC foreign key (ID_GRADO_ACAD)
      references GRADO_ACADEMICO (ID_GRADO_ACAD)
      on delete cascade on update restrict;

alter table LICENCIATURA
   add constraint FK_LICENCIA_RELATIONS_USUARIO foreign key (ID_USERN)
      references USUARIO (ID_USERN)
      on delete cascade on update restrict;

alter table MATERIA
   add constraint FK_MATERIA_RELATIONS_ESTUDIAN foreign key (ID_ESTUDIANTE)
      references ESTUDIANTE (ID_ESTUDIANTE)
      on delete cascade on update restrict;

alter table MATERIA
   add constraint FK_MATERIA_RELATIONS_DOCENTE foreign key (ID_DOCENTE)
      references DOCENTE (ID_DOCENTE)
      on delete cascade on update restrict;

alter table ROL_FUNCION
   add constraint FK_ROL_FUNC_RELATIONS_ROL foreign key (ID_ROL)
      references ROL (ID_ROL)
      on delete cascade on update restrict;

alter table ROL_FUNCION
   add constraint FK_ROL_FUNC_RELATIONS_FUNCION foreign key (ID_FUNCION)
      references FUNCION (ID_FUNCION)
      on delete cascade on update restrict;

alter table ROL_USUARIO
   add constraint FK_ROL_USUA_RELATIONS_USUARIO foreign key (ID_USERN)
      references USUARIO (ID_USERN)
      on delete cascade on update restrict;

alter table ROL_USUARIO
   add constraint FK_ROL_USUA_RELATIONS_ROL foreign key (ID_ROL)
      references ROL (ID_ROL)
      on delete cascade on update restrict;

alter table SESION
   add constraint FK_SESION_RELATIONS_USUARIO foreign key (ID_USERN)
      references USUARIO (ID_USERN)
      on delete cascade on update restrict;

alter table TAREA
   add constraint FK_TAREA_RELATIONS_MATERIA foreign key (ID_ESTUDIANTE, ID_DOCENTE, ID_MATERIA)
      references MATERIA (ID_ESTUDIANTE, ID_DOCENTE, ID_MATERIA)
      on delete cascade on update restrict;

alter table TAREA
   add constraint FK_TAREA_RELATIONS_ENTREGA foreign key (ID_ENTREGA)
      references ENTREGA (ID_ENTREGA)
      on delete cascade on update restrict;
	  
	  
--parte 2 
CREATE FUNCTION get_id_usuario22(nombre_usuario character varying(20), contrasena_usuario character varying(50))
RETURNS INT AS
$$
DECLARE
    id_usuario INT;
BEGIN
    SELECT id_usern INTO id_usuario FROM usuario WHERE nombre=nombre_usuario AND contrasenia=contrasena_usuario;
    RETURN id_usuario;
END;
$$
LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION insertar_sesion(p_id_user INT, p_pid INT, p_hora_inicio TIMESTAMP, p_fecha_actual DATE)
RETURNS VOID AS $$
BEGIN
    INSERT INTO SESION (ID_USERN, PID, hora_inicio_sesion, fecha_inicio_sesion)
    VALUES (p_id_user, p_pid, p_hora_inicio, p_fecha_actual);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_rols(id_usern_param INT)
RETURNS TABLE(nom_rol VARCHAR) AS $$
BEGIN
    RETURN QUERY 
    SELECT rol.nom_rol
    FROM rol_usuario
    JOIN rol ON rol_usuario.id_rol = rol.id_rol
    WHERE rol_usuario.id_usern = id_usern_param;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION obtener_nombre_ui_por_usuario(p_id_user INT)
RETURNS TABLE(nombre_ui VARCHAR) AS $$
BEGIN
    RETURN QUERY 
    SELECT ui.nombre_ui 
    FROM (SELECT funcion_ui.id_ui
          FROM (SELECT rol_funcion.id_funcion
                FROM (SELECT rol_usuario.id_rol
                      FROM (SELECT usuario.id_usern
                            FROM public.usuario
                            WHERE id_usern=p_id_user) uno, rol_usuario
                      WHERE rol_usuario.id_usern=uno.id_usern) dos, rol_funcion
                WHERE rol_funcion.id_rol=dos.id_rol) tres, funcion_ui
          WHERE funcion_ui.id_funcion=tres.id_funcion
    ) cuatro, ui
    WHERE ui.id_ui= cuatro.id_ui;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION ui_no_permitida(p_id_user INT)
RETURNS TABLE(nombre_ui_p VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT u.nombre_ui
    FROM ui u
    WHERE u.nombre_ui NOT IN (
        SELECT nombre_ui
        FROM obtener_nombre_ui_por_usuario(p_id_user)
    );
END;
$$ LANGUAGE plpgsql;




CREATE TABLE log_BD (
    id_log_BD SERIAL PRIMARY KEY NOT NULL,
    fecha_event DATE NOT NULL,
    hora_event TIME NOT NULL,
    dato_viejo VARCHAR(1000),
    dato_nuevo VARCHAR(1000),
    tabla VARCHAR(120), 
    pid_usuario INTEGER NOT NULL,
    evento VARCHAR(40)
);





--ultimo


CREATE OR REPLACE FUNCTION trigger_registrar_log()
RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO log_BD(fecha_event, hora_event, dato_viejo, tabla, pid_usuario, evento)
    VALUES (CURRENT_DATE, LOCALTIME, OLD,NEW, TG_TABLE_NAME, pg_backend_pid(), TG_OP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


--estudiante
CREATE TRIGGER log_bd_delete_estudiante
AFTER DELETE ON estudiante
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_estudiante
AFTER UPDATE ON estudiante
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_estudiante
AFTER INSERT ON estudiante
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--docente
CREATE TRIGGER log_bd_delete_docente
AFTER DELETE ON docente
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_docente
AFTER UPDATE ON docente
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_docente
AFTER INSERT ON docente
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--materia
CREATE TRIGGER log_bd_delete_materia
AFTER DELETE ON materia
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_materia
AFTER UPDATE ON materia
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_materia
AFTER INSERT ON materia
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--sesion
CREATE TRIGGER log_bd_delete_sesion
AFTER DELETE ON sesion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_sesion
AFTER UPDATE ON sesion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_sesion
AFTER INSERT ON sesion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--licenciatura
CREATE TRIGGER log_bd_delete_licenciatura
AFTER DELETE ON licenciatura
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_licenciatura
AFTER UPDATE ON licenciatura
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_licenciatura
AFTER INSERT ON licenciatura
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--grado_academico
CREATE TRIGGER log_bd_delete_grado_academico
AFTER DELETE ON grado_academico
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_grado_academico
AFTER UPDATE ON grado_academico
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_grado_academico
AFTER INSERT ON grado_academico
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--rol_usuario
CREATE TRIGGER log_bd_delete_rol_usuario
AFTER DELETE ON rol_usuario
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_rol_usuario
AFTER UPDATE ON rol_usuario
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_grado_rol_usuario
AFTER INSERT ON rol_usuario
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--comentario
CREATE TRIGGER log_bd_delete_comentario
AFTER DELETE ON comentario
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_comentario
AFTER UPDATE ON comentario
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_comentario
AFTER INSERT ON comentario
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--rol_funcion
CREATE TRIGGER log_bd_delete_rol_funcion
AFTER DELETE ON rol_funcion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_rol_funcion
AFTER UPDATE ON rol_funcion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_rol_funcion
AFTER INSERT ON rol_funcion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--entrega
CREATE TRIGGER log_bd_delete_entrega
AFTER DELETE ON entrega
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_entrega
AFTER UPDATE ON entrega
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_entrega
AFTER INSERT ON entrega
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--funcion_ui
CREATE TRIGGER log_bd_delete_funcion_ui
AFTER DELETE ON funcion_ui
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_funcion_ui
AFTER UPDATE ON funcion_ui
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_funcion_ui
AFTER INSERT ON funcion_ui
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--tarea
CREATE TRIGGER log_bd_delete_tarea
AFTER DELETE ON tarea
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_tarea
AFTER UPDATE ON tarea
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_tarea
AFTER INSERT ON tarea
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--Consultas de insert
INSERT INTO DOCENTE (ID_DOCENTE, DOCENTE_DESDE) VALUES
(1, '2023-01-01'),
(2, '2023-01-15'),
(3, '2022-08-01'),
(4, '2022-09-01'),
(5, '2023-02-10');
--
INSERT INTO ENTREGA (ID_TIPO_ARCHIVO, ID_COMENTARIO, ENTREGADO, RETRASO_ENTREGA, CALIFICACION) VALUES
(1, NULL, TRUE, FALSE, 85),
(2, 1, TRUE, TRUE, 70),
(1, 2, TRUE, FALSE, 90),
(3, NULL, TRUE, TRUE, 60),
(2, 3, TRUE, FALSE, 88);
--
INSERT INTO ESTUDIANTE (ID_ESTUDIANTE, ESTADO_MATRICULA, CORREO_ESTIDIANTIL) VALUES
(1, TRUE, 'estudiante1@universidad.edu'),
(2, FALSE, 'estudiante2@universidad.edu'),
(3, TRUE, 'estudiante3@universidad.edu'),
(4, TRUE, 'estudiante4@universidad.edu'),
(5, FALSE, 'estudiante5@universidad.edu');
----
INSERT INTO FUNCION (ID_FUNCION, NOM_FUNCION, FUNCION_ACTIVA) VALUES
(1, 'Crear Usuario', TRUE),
(2, 'Eliminar Usuario', TRUE),
(3, 'Actualizar Datos', FALSE),
(4, 'Consultar Usuarios', TRUE),
(5, 'Generar Reportes', FALSE);
--
INSERT INTO FUNCION_UI (ID_FUNCION, ID_UI) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3),
(5, 4);

INSERT INTO GRADO_ACADEMICO (GRADO_ACAD) VALUES
('Licenciatura en Matemáticas'),
('Maestría en Física'),
('Doctorado en Química'),
('Licenciatura en Informática'),
('Maestría en Historia del Arte');
--
INSERT INTO LICENCIATURA (ID_USERN, ID_GRADO_ACAD, NOM_LICENCIATURA) VALUES
(1, 1, 'Matemáticas Aplicadas'),
(2, 2, 'Física Teórica'),
(3, 3, 'Química Orgánica'),
(4, 4, 'Ingeniería de Software'),
(5, 5, 'Historia del Arte Moderno');
--
INSERT INTO MATERIA (ID_ESTUDIANTE, ID_DOCENTE, NOMBRE_MATERIA, DESCRIPCION2) VALUES
(1, 1, 'Álgebra Lineal', 'Fundamentos de vectores y matrices'),
(2, 2, 'Mecánica Clásica', 'Leyes de movimiento y gravedad'),
(3, 3, 'Química Analítica', 'Técnicas de análisis químico'),
(4, 4, 'Programación Avanzada', 'Desarrollo de software complejo'),
(5, 5, 'Arte Contemporáneo', 'Estudio del arte del siglo XX y XXI');

INSERT INTO ROL (NOM_ROL, ROL_ACTIVO) VALUES
('Administrador', TRUE),
('Docente', TRUE),
('Estudiante', TRUE),
('Invitado', FALSE),
('Coordinador', TRUE);


INSERT INTO ROL_FUNCION (ID_FUNCION, ID_ROL) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(5, 4);


INSERT INTO ROL_USUARIO (ID_ROL, ID_USERN, FECHA_ACTIVACION, DESDE, HASTA) VALUES
(1, 1, '2023-01-01', '2023-01-01', NULL),
(2, 2, '2023-02-01', '2023-02-01', '2023-12-31'),
(3, 3, '2023-03-01', '2023-03-01', NULL),
(1, 4, '2023-04-01', '2023-04-01', '2024-03-31'),
(2, 5, '2023-05-01', '2023-05-01', NULL);


INSERT INTO TAREA (ID_ESTUDIANTE, ID_DOCENTE, ID_MATERIA, ID_ENTREGA, NOMBRE_TAREA, FECHA_ASIGNACION, FECHA_ENTREGA, DESCRIPCION_TAREA) VALUES
(1, 1, 1, 1, 'Tarea de Álgebra', '2023-03-01', '2023-03-15', 'Resolver sistemas de ecuaciones'),
(2, 2, 2, 2, 'Laboratorio de Física', '2023-04-01', '2023-04-15', 'Experimento de caída libre'),
(3, 3, 3, 3, 'Informe Químico', '2023-05-01', '2023-05-15', 'Análisis cualitativo de muestras'),
(4, 4, 4, 4, 'Proyecto Final', '2023-06-01', NULL, 'Desarrollo de una aplicación web'),
(5, 5, 5, 5, 'Ensayo de Arte', '2023-07-01', '2023-07-15', 'Crítica de una obra contemporánea');


INSERT INTO TIPO_ARCHIVO (TIPO_ARCHIVO) VALUES
('PDF'),
('DOCX'),
('PPTX'),
('XLSX'),
('ZIP');


INSERT INTO UI (ID_UI, NOMBRE_UI, UI_ACTIVA) VALUES
(1, 'Inicio', TRUE),
(2, 'Perfil', TRUE),
(3, 'Mensajes', TRUE),
(4, 'Configuración', FALSE),
(5, 'Ayuda', TRUE);

select * from usuario
INSERT INTO USUARIO (NOMBRE, CONTRASENIA, FECHA_NAC) VALUES
('alfredo', 'notebok456', '1990-05-15'),
('Laura Martínez', '12345678', '1989-04-22'),
('Carlos Gómez', 'claveSegura', '1992-03-30'),
('Ana López', 'miContraseña', '1991-02-11'),
('Roberto Díaz', 'password', '1993-01-08');





select * from log_bd

CREATE OR REPLACE FUNCTION trigger_registrar_log()
RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO log_BD(fecha_event, hora_event, dato_viejo, dato_nuevo, tabla, pid_usuario, evento)
    VALUES (CURRENT_DATE, LOCALTIME, OLD,NEW, TG_TABLE_NAME, pg_backend_pid(), TG_OP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


select * from log_bd


