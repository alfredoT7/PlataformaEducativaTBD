select * from usuario

create log_plat table(
	id_log serial PRIMARY KEY,
	fecha_event Date notnull,
	hora_event time notnull,
	dato_viejo varchar(1000),
	dato_nuevo varchar(1000),
	tabla varchar(120),
	usuarion varchar(30),
	pid integer,
)

select pg_backend_pid()
select * from tipo_archivo

CREATE TABLE evento (
    id_event INT4 NOT NULL,
    tipo_evento VARCHAR(100) NOT NULL,
    CONSTRAINT pk_evento PRIMARY KEY (id_event)
);

CREATE TABLE log_BD (
    id_log_BD SERIAL PRIMARY KEY NOT NULL,
    fecha_event DATE NOT NULL,
    hora_event TIME NOT NULL,
    dato_viejo VARCHAR(1000),
    dato_nuevo VARCHAR(1000),
    tabla VARCHAR(120),
    usuarion VARCHAR(30),
    pid_usuario INTEGER NOT NULL,
    id_event INTEGER NOT NULL,
    CONSTRAINT fk_log_BD FOREIGN KEY (id_event)
        REFERENCES evento(id_event)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);

select * from log_BD




CREATE OR REPLACE FUNCTION trigger_registrar_log()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_bd(fecha_event, hora_event, dato_viejo, dato_nuevo, tabla, pid_usuario, type_event)
    VALUES (CURRENT_DATE, LOCALTIME, OLD, NEW, TG_TABLE_NAME, pg_backend_pid(), TG_OP);
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


---calificacionn
CREATE TRIGGER trig_logBD_insert_calif
AFTER INSERT ON calificacion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();


CREATE TRIGGER trig_logBD_update_calif
AFTER UPDATE ON calificacion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_delete_calif
AFTER DELETE ON calificacion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--materia
CREATE TRIGGER trig_logBD_insert_mater
AFTER INSERT ON materia
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();


CREATE TRIGGER trig_logBD_update_mater
AFTER UPDATE ON materia
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_delete_mater
AFTER DELETE ON materia
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
---sesion
CREATE TRIGGER trig_logBD_insert_sesion
AFTER INSERT ON sesion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();


CREATE TRIGGER trig_logBD_update_sesion
AFTER UPDATE ON sesion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_delete_sesion
AFTER DELETE ON sesion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
---rol_usern
CREATE TRIGGER trig_logBD_insert_rol_usern
AFTER INSERT ON rol_usuario
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_update_rol_usern
AFTER UPDATE ON rol_usuario
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_delete_rol_usern
AFTER DELETE ON rol_usuario
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
---LICENCIATURA
CREATE TRIGGER trig_logBD_insert_licenciatura
AFTER INSERT ON licenciatura
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_update_licenciatura
AFTER UPDATE ON licenciatura
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_delete_licenciatura
AFTER DELETE ON licenciatura
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--asignacion_tarea
CREATE TRIGGER trig_logBD_insert_asignacion_tarea
AFTER INSERT ON asignacion_tarea
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_update_asignacion_tarea
AFTER UPDATE ON asignacion_tarea
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_delete_asignacion_tarea
AFTER DELETE ON asignacion_tarea
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--rol_funcion
CREATE TRIGGER trig_logBD_insert_asignacion_rol_funcion
AFTER INSERT ON rol_funcion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_update_asignacion_rol_funcion
AFTER UPDATE ON rol_funcion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_delete_asignacion_rol_funcion
AFTER DELETE ON rol_funcion
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--funcionui
CREATE TRIGGER trig_logBD_insert_asignacion_funcionui
AFTER INSERT ON funcionui
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_update_asignacion_funcionui
AFTER UPDATE ON funcionui
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_delete_asignacion_funcionui
AFTER DELETE ON funcionui
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--carrera
CREATE TRIGGER trig_logBD_insert_asignacion_carrera
AFTER INSERT ON carrera
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_update_asignacion_carrera
AFTER UPDATE ON carrera
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_delete_asignacion_carrera
AFTER DELETE ON carrera
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--telefono

CREATE TRIGGER trig_logBD_insert_asignacion_telefono
AFTER INSERT ON telefono
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_update_asignacion_telefono
AFTER UPDATE ON telefono
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_delete_asignacion_telefono
AFTER DELETE ON telefono
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();
--correo
CREATE TRIGGER trig_logBD_insert_asignacion_correo
AFTER INSERT ON correo
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_update_asignacion_correo
AFTER UPDATE ON correo
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();

CREATE TRIGGER trig_logBD_delete_asignacion_correo
AFTER DELETE ON correo
FOR EACH ROW
EXECUTE FUNCTION trigger_registrar_log();




ALTER TABLE log_bd DROP COLUMN id_event;
