select * from usuario --where contrasena='password1'
select * from sesion
--añadir columna a la tabla sesion
ALTER TABLE SESION
ADD COLUMN inicio_sesion TIMESTAMP;

select CURRENT_TIMESTAMP;
INSERT INTO SESION (ID_USER, ID_SESION, PID, inicio_sesion)
VALUES (2, 1,3, CURRENT_TIMESTAMP);
INSERT INTO SESION (ID_USER, ID_SESION, PID, inicio_sesion)
VALUES (2, 5,123, CURRENT_TIMESTAMP);


CREATE OR REPLACE FUNCTION insertar_sesion(p_id_user INT,p_id_sesion INT,p_pid INT,p_hora_inicio TIMESTAMP)
RETURNS VOID AS $$
BEGIN
    INSERT INTO SESION (ID_USER, ID_SESION, PID, inicio_sesion)
    VALUES (p_id_user, p_id_sesion, p_pid, p_hora_inicio);
END;
$$ LANGUAGE plpgsql;
----
ALTER TABLE SESION
ADD COLUMN fecha_inicio_sesion DATE;
ALTER TABLE SESION
DROP COLUMN fecha_inicio_sesion
---
CREATE FUNCTION get_id_usuario22(nombre_usuario character varying(20), contrasena_usuario character varying(50))
RETURNS INT AS
$$
DECLARE
    id_usuario INT;
BEGIN
    SELECT id_user INTO id_usuario FROM usuario WHERE nombre = nombre_usuario AND contrasena = contrasena_usuario;
    RETURN id_usuario;
END;
$$
LANGUAGE PLPGSQL;




CREATE OR REPLACE FUNCTION insertar_sesion(p_id_user INT, p_id_sesion INT, p_pid INT, p_hora_inicio TIMESTAMP, p_fecha_actual DATE)
RETURNS VOID AS $$
BEGIN
    INSERT INTO SESION (ID_USER, ID_SESION, PID, hora_inicio_sesion, fecha_inicio_sesion)
    VALUES (p_id_user, p_id_sesion, p_pid, p_hora_inicio, p_fecha_actual);
END;
$$ LANGUAGE plpgsql;



----consulta
select ui.nombre_ui 
from (select funcionui.id_ui
	from (select rol_funcion.id_funcion
		 from (select rol_usuario.id_rol
			  from(select usuario.id_user
				  from public.usuario
				  where id_user=1) uno, rol_usuario
			  where rol_usuario.id_user=uno.id_user) dos, rol_funcion
		 where rol_funcion.id_rol=dos.id_rol) tres, funcionui
	where funcionui.id_funcion=tres.id_funcion
) cuatro, ui
where ui.id_ui= cuatro.id_ui
---consulta


--consulta
select funcionui.id_ui
	from (select rol_funcion.id_funcion
		 from (select rol_usuario.id_rol
			  from(select usuario.id_user
				  from public.usuario
				  where id_user=1) uno, rol_usuario
			  where rol_usuario.id_user=uno.id_user) dos, rol_funcion
		 where rol_funcion.id_rol=dos.id_rol) tres, funcionui
	where funcionui.id_funcion=tres.id_funcion







SELECT * FROM USUARIO;

-- FUNCION
SELECT * FROM FUNCION;

-- FUNCIONUI
SELECT * FROM FUNCIONUI;

-- ROL
SELECT * FROM ROL;

-- ROL_FUNCION
SELECT * FROM ROL_FUNCION;

-- ROL_USUARIO
SELECT * FROM ROL_USUARIO;

-- SESION
SELECT * FROM SESION;

-- UI
SELECT * FROM UI;