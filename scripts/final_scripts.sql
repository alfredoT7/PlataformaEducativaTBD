CREATE FUNCTION get_id_usuario22(nombre_usuariop character varying(20), contrasena_usuario character varying(50))
RETURNS INT AS
$$
DECLARE
    id_usuario INT;
BEGIN
    SELECT id_usern INTO id_usuario FROM usuario WHERE nombre_usuario=nombre_usuariop AND contrasenia=contrasena_usuario;
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
    nom_user VARCHAR(100),
    fecha_event DATE NOT NULL,
    hora_event TIME NOT NULL,
    dato_viejo VARCHAR(1000),
    dato_nuevo VARCHAR(1000),
    tabla VARCHAR(120),
    usuarion VARCHAR(30),
    pid_usuario INTEGER NOT NULL,
    evento VARCHAR(40)
);

CREATE OR REPLACE FUNCTION obtener_nombre_usuario_por_pid(pid_buscar INT)
RETURNS VARCHAR AS $$
DECLARE
    nombre_usuario_var VARCHAR(30);
BEGIN
    SELECT nombre_usuario INTO nombre_usuario_var
    FROM SESION, USUARIO
    WHERE SESION.id_usern = USUARIO.id_usern AND SESION.pid = pid_buscar;

    RETURN nombre_usuario_var;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION trigger_registrar_log()
RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO log_BD(nom_user,fecha_event, hora_event, dato_viejo, dato_nuevo,tabla, pid_usuario, evento)
    VALUES (obtener_nombre_usuario_por_pid(pg_backend_pid()),CURRENT_DATE, LOCALTIME, OLD,NEW, TG_TABLE_NAME, pg_backend_pid(), TG_OP);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



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
--funcion
CREATE TRIGGER log_bd_delete_funcion
AFTER DELETE ON funcion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_funcion
AFTER UPDATE ON funcion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_funcion
AFTER INSERT ON funcion
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
--inscripcion
CREATE TRIGGER log_bd_delete_inscripcion
AFTER DELETE ON inscripcion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_inscripcion
AFTER UPDATE ON inscripcion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_inscripcion
AFTER INSERT ON inscripcion
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
--rol
CREATE TRIGGER log_bd_delete_rol
AFTER DELETE ON rol
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_rol
AFTER UPDATE ON rol
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_rol
AFTER INSERT ON rol
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
--ui
CREATE TRIGGER log_bd_delete_ui
AFTER DELETE ON ui
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_ui
AFTER UPDATE ON ui
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_ui
AFTER INSERT ON ui
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--usuario
CREATE TRIGGER log_bd_delete_usuario
AFTER DELETE ON usuario
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_update_usuario
AFTER UPDATE ON usuario
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER log_bd_insert_usuario
AFTER INSERT ON usuario
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();










