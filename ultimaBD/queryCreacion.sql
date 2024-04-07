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
