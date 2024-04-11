/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     4/10/2024 10:00:58 AM                        */
/*==============================================================*/


drop index RELATIONSHIP_33_FK;

drop index COMENTARIO_PK;

drop table COMENTARIO;

drop index RELATIONSHIP_22_FK;

drop index RELATIONSHIP_21_FK;

drop index COMENTARIO_ENTREGA_PK;

drop table COMENTARIO_ENTREGA;

drop index DOCENTE_PK;

drop table DOCENTE;

drop index RELATIONSHIP_9_FK;

drop index ENTREGA_PK;

drop table ENTREGA;

drop index ESTUDIANTE_PK;

drop table ESTUDIANTE;

drop index RELATIONSHIP_30_FK;

drop index RELATIONSHIP_29_FK;

drop index ESTUDIANTE_ENTREGA_PK;

drop table ESTUDIANTE_ENTREGA;

drop index FUNCION_PK;

drop table FUNCION;

drop index RELATIONSHIP_19_FK;

drop index RELATIONSHIP_18_FK;

drop index FUNCIONUI_PK;

drop table FUNCIONUI;

drop index GRADO_ACADEMICO_PK;

drop table GRADO_ACADEMICO;

drop index RELATIONSHIP_24_FK;

drop index RELATIONSHIP_23_FK;

drop index INSCRIPCION_PK;

drop table INSCRIPCION;

drop index RELATIONSHIP_31_FK;

drop index RELATIONSHIP_10_FK;

drop index LICENCIATURA_PK;

drop table LICENCIATURA;

drop index RELATIONSHIP_32_FK;

drop index MATERIA_PK;

drop table MATERIA;

drop index RELATIONSHIP_28_FK;

drop index RELATIONSHIP_27_FK;

drop index MATERIA_TAREA_PK;

drop table MATERIA_TAREA;

drop index ROL_PK;

drop table ROL;

drop index RELATIONSHIP_17_FK;

drop index RELATIONSHIP_16_FK;

drop index ROL_FUNCION_PK;

drop table ROL_FUNCION;

drop index RELATIONSHIP_20_FK;

drop index RELATIONSHIP_15_FK;

drop index ROL_USERN_PK;

drop table ROL_USERN;

drop index RELATIONSHIP_14_FK;

drop index SESION_PK;

drop table SESION;

drop index TAREA_PK;

drop table TAREA;

drop index RELATIONSHIP_26_FK;

drop index RELATIONSHIP_25_FK;

drop index TAREA_ENTREGA_PK;

drop table TAREA_ENTREGA;

drop index TIPO_ARCHIVO_PK;

drop table TIPO_ARCHIVO;

drop index UI_PK;

drop table UI;

drop index USUARIO_PK;

drop table USUARIO;

/*==============================================================*/
/* Table: COMENTARIO                                            */
/*==============================================================*/
create table COMENTARIO (
   ID_COMENTARIO        SERIAL               not null,
   ID_COM_RESPUESTA     INT4                 null,
   COMENTARIO           VARCHAR(200)         null,
   constraint PK_COMENTARIO primary key (ID_COMENTARIO)
);

/*==============================================================*/
/* Index: COMENTARIO_PK                                         */
/*==============================================================*/
create unique index COMENTARIO_PK on COMENTARIO (
ID_COMENTARIO
);

/*==============================================================*/
/* Index: RELATIONSHIP_33_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_33_FK on COMENTARIO (
ID_COM_RESPUESTA
);

/*==============================================================*/
/* Table: COMENTARIO_ENTREGA                                    */
/*==============================================================*/
create table COMENTARIO_ENTREGA (
   ID_ENTREGA           INT4                 not null,
   ID_COMENTARIO        INT4                 not null,
   constraint PK_COMENTARIO_ENTREGA primary key (ID_ENTREGA, ID_COMENTARIO)
);

/*==============================================================*/
/* Index: COMENTARIO_ENTREGA_PK                                 */
/*==============================================================*/
create unique index COMENTARIO_ENTREGA_PK on COMENTARIO_ENTREGA (
ID_ENTREGA,
ID_COMENTARIO
);

/*==============================================================*/
/* Index: RELATIONSHIP_21_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_21_FK on COMENTARIO_ENTREGA (
ID_ENTREGA
);

/*==============================================================*/
/* Index: RELATIONSHIP_22_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_22_FK on COMENTARIO_ENTREGA (
ID_COMENTARIO
);

/*==============================================================*/
/* Table: DOCENTE                                               */
/*==============================================================*/
create table DOCENTE (
   ID_DOCENTE           INT4                 not null,
   DOCENTE_DESDE        DATE                 not null,
   constraint PK_DOCENTE primary key (ID_DOCENTE)
);

/*==============================================================*/
/* Index: DOCENTE_PK                                            */
/*==============================================================*/
create unique index DOCENTE_PK on DOCENTE (
ID_DOCENTE
);

/*==============================================================*/
/* Table: ENTREGA                                               */
/*==============================================================*/
create table ENTREGA (
   ID_ENTREGA           SERIAL               not null,
   ID_TIPO_ARCHIVO      INT4                 null,
   RETRASO_ENTREGA      BOOL                 not null,
   CALIFICACION         INT4                 null,
   constraint PK_ENTREGA primary key (ID_ENTREGA)
);

/*==============================================================*/
/* Index: ENTREGA_PK                                            */
/*==============================================================*/
create unique index ENTREGA_PK on ENTREGA (
ID_ENTREGA
);

/*==============================================================*/
/* Index: RELATIONSHIP_9_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_9_FK on ENTREGA (
ID_TIPO_ARCHIVO
);

/*==============================================================*/
/* Table: ESTUDIANTE                                            */
/*==============================================================*/
create table ESTUDIANTE (
   ID_ESTUDIANTE        INT4                 not null,
   ESTADO_MATRICULA     BOOL                 not null,
   CORREO_ESTIDIANTIL   VARCHAR(30)          not null,
   constraint PK_ESTUDIANTE primary key (ID_ESTUDIANTE)
);

/*==============================================================*/
/* Index: ESTUDIANTE_PK                                         */
/*==============================================================*/
create unique index ESTUDIANTE_PK on ESTUDIANTE (
ID_ESTUDIANTE
);

/*==============================================================*/
/* Table: ESTUDIANTE_ENTREGA                                    */
/*==============================================================*/
create table ESTUDIANTE_ENTREGA (
   ID_ESTUDIANTE        INT4                 not null,
   ID_ENTREGA           INT4                 not null,
   constraint PK_ESTUDIANTE_ENTREGA primary key (ID_ESTUDIANTE, ID_ENTREGA)
);

/*==============================================================*/
/* Index: ESTUDIANTE_ENTREGA_PK                                 */
/*==============================================================*/
create unique index ESTUDIANTE_ENTREGA_PK on ESTUDIANTE_ENTREGA (
ID_ESTUDIANTE,
ID_ENTREGA
);

/*==============================================================*/
/* Index: RELATIONSHIP_29_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_29_FK on ESTUDIANTE_ENTREGA (
ID_ESTUDIANTE
);

/*==============================================================*/
/* Index: RELATIONSHIP_30_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_30_FK on ESTUDIANTE_ENTREGA (
ID_ENTREGA
);

/*==============================================================*/
/* Table: FUNCION                                               */
/*==============================================================*/
create table FUNCION (
   ID_FUNCION           INT4                 not null,
   NOMBRE_FUNCION       VARCHAR(30)          not null,
   FUNCION_ACTIVA       BOOL                 not null,
   constraint PK_FUNCION primary key (ID_FUNCION)
);

/*==============================================================*/
/* Index: FUNCION_PK                                            */
/*==============================================================*/
create unique index FUNCION_PK on FUNCION (
ID_FUNCION
);

/*==============================================================*/
/* Table: FUNCIONUI                                             */
/*==============================================================*/
create table FUNCIONUI (
   ID_UI                INT4                 not null,
   ID_FUNCION           INT4                 not null,
   constraint PK_FUNCIONUI primary key (ID_UI, ID_FUNCION)
);

/*==============================================================*/
/* Index: FUNCIONUI_PK                                          */
/*==============================================================*/
create unique index FUNCIONUI_PK on FUNCIONUI (
ID_UI,
ID_FUNCION
);

/*==============================================================*/
/* Index: RELATIONSHIP_18_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_18_FK on FUNCIONUI (
ID_FUNCION
);

/*==============================================================*/
/* Index: RELATIONSHIP_19_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_19_FK on FUNCIONUI (
ID_UI
);

/*==============================================================*/
/* Table: GRADO_ACADEMICO                                       */
/*==============================================================*/
create table GRADO_ACADEMICO (
   ID_GRADO_ACAD        SERIAL               not null,
   GRADO_ACAD           VARCHAR(30)          not null,
   constraint PK_GRADO_ACADEMICO primary key (ID_GRADO_ACAD)
);

/*==============================================================*/
/* Index: GRADO_ACADEMICO_PK                                    */
/*==============================================================*/
create unique index GRADO_ACADEMICO_PK on GRADO_ACADEMICO (
ID_GRADO_ACAD
);

/*==============================================================*/
/* Table: INSCRIPCION                                           */
/*==============================================================*/
create table INSCRIPCION (
   ID_MATERIA           INT4                 not null,
   ID_DOCENTE           INT4                 not null,
   ID_ESTUDIANTE        INT4                 not null,
   PERIODO_ACADEMICO    VARCHAR(8)           not null,
   constraint PK_INSCRIPCION primary key (ID_MATERIA, ID_DOCENTE, ID_ESTUDIANTE, PERIODO_ACADEMICO)
);

/*==============================================================*/
/* Index: INSCRIPCION_PK                                        */
/*==============================================================*/
create unique index INSCRIPCION_PK on INSCRIPCION (
ID_MATERIA,
ID_DOCENTE,
ID_ESTUDIANTE,
PERIODO_ACADEMICO
);

/*==============================================================*/
/* Index: RELATIONSHIP_23_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_23_FK on INSCRIPCION (
ID_MATERIA,
ID_DOCENTE
);

/*==============================================================*/
/* Index: RELATIONSHIP_24_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_24_FK on INSCRIPCION (
ID_ESTUDIANTE
);

/*==============================================================*/
/* Table: LICENCIATURA                                          */
/*==============================================================*/
create table LICENCIATURA (
   ID_GRADO_ACAD        INT4                 not null,
   ID_LICENCIATURA      SERIAL               not null,
   ID_DOCENTE           INT4                 not null,
   NOM_LICENCIATURA     VARCHAR(30)          not null,
   constraint PK_LICENCIATURA primary key (ID_GRADO_ACAD, ID_LICENCIATURA, ID_DOCENTE)
);

/*==============================================================*/
/* Index: LICENCIATURA_PK                                       */
/*==============================================================*/
create unique index LICENCIATURA_PK on LICENCIATURA (
ID_GRADO_ACAD,
ID_LICENCIATURA,
ID_DOCENTE
);

/*==============================================================*/
/* Index: RELATIONSHIP_10_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_10_FK on LICENCIATURA (
ID_GRADO_ACAD
);

/*==============================================================*/
/* Index: RELATIONSHIP_31_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_31_FK on LICENCIATURA (
ID_DOCENTE
);

/*==============================================================*/
/* Table: MATERIA                                               */
/*==============================================================*/
create table MATERIA (
   ID_MATERIA           SERIAL               not null,
   ID_DOCENTE           INT4                 not null,
   NOMBRE_MATERIA       VARCHAR(30)          not null,
   DESCRIPCION2         VARCHAR(30)          not null,
   constraint PK_MATERIA primary key (ID_MATERIA, ID_DOCENTE)
);

/*==============================================================*/
/* Index: MATERIA_PK                                            */
/*==============================================================*/
create unique index MATERIA_PK on MATERIA (
ID_MATERIA,
ID_DOCENTE
);

/*==============================================================*/
/* Index: RELATIONSHIP_32_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_32_FK on MATERIA (
ID_DOCENTE
);

/*==============================================================*/
/* Table: MATERIA_TAREA                                         */
/*==============================================================*/
create table MATERIA_TAREA (
   ID_MATERIA           INT4                 not null,
   ID_DOCENTE           INT4                 not null,
   ID_TAREA             INT4                 not null,
   PERIODO_ACAD         VARCHAR(8)           not null,
   constraint PK_MATERIA_TAREA primary key (ID_MATERIA, ID_DOCENTE, ID_TAREA, PERIODO_ACAD)
);

/*==============================================================*/
/* Index: MATERIA_TAREA_PK                                      */
/*==============================================================*/
create unique index MATERIA_TAREA_PK on MATERIA_TAREA (
ID_MATERIA,
ID_DOCENTE,
ID_TAREA,
PERIODO_ACAD
);

/*==============================================================*/
/* Index: RELATIONSHIP_27_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_27_FK on MATERIA_TAREA (
ID_MATERIA,
ID_DOCENTE
);

/*==============================================================*/
/* Index: RELATIONSHIP_28_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_28_FK on MATERIA_TAREA (
ID_TAREA
);

/*==============================================================*/
/* Table: ROL                                                   */
/*==============================================================*/
create table ROL (
   ID_ROL               SERIAL               not null,
   NOMBRE_ROL           VARCHAR(30)          not null,
   ROL_ACTIVO           BOOL                 not null,
   constraint PK_ROL primary key (ID_ROL)
);

/*==============================================================*/
/* Index: ROL_PK                                                */
/*==============================================================*/
create unique index ROL_PK on ROL (
ID_ROL
);

/*==============================================================*/
/* Table: ROL_FUNCION                                           */
/*==============================================================*/
create table ROL_FUNCION (
   ID_FUNCION           INT4                 not null,
   ID_ROL               INT4                 not null,
   constraint PK_ROL_FUNCION primary key (ID_FUNCION, ID_ROL)
);

/*==============================================================*/
/* Index: ROL_FUNCION_PK                                        */
/*==============================================================*/
create unique index ROL_FUNCION_PK on ROL_FUNCION (
ID_FUNCION,
ID_ROL
);

/*==============================================================*/
/* Index: RELATIONSHIP_16_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_16_FK on ROL_FUNCION (
ID_ROL
);

/*==============================================================*/
/* Index: RELATIONSHIP_17_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_17_FK on ROL_FUNCION (
ID_FUNCION
);

/*==============================================================*/
/* Table: ROL_USERN                                             */
/*==============================================================*/
create table ROL_USERN (
   ID_USERN             INT4                 not null,
   ID_ROL               INT4                 not null,
   FECHA_ACTVACION      DATE                 not null,
   DESDE                DATE                 not null,
   HASTA                DATE                 not null,
   constraint PK_ROL_USERN primary key (ID_USERN, ID_ROL, FECHA_ACTVACION)
);

/*==============================================================*/
/* Index: ROL_USERN_PK                                          */
/*==============================================================*/
create unique index ROL_USERN_PK on ROL_USERN (
ID_USERN,
ID_ROL,
FECHA_ACTVACION
);

/*==============================================================*/
/* Index: RELATIONSHIP_15_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_15_FK on ROL_USERN (
ID_ROL
);

/*==============================================================*/
/* Index: RELATIONSHIP_20_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_20_FK on ROL_USERN (
ID_USERN
);

/*==============================================================*/
/* Table: SESION                                                */
/*==============================================================*/
create table SESION (
   ID_USERN             INT4                 not null,
   ID_SESION            SERIAL               not null,
   PID                  INT4                 not null,
   constraint PK_SESION primary key (ID_USERN, ID_SESION)
);

/*==============================================================*/
/* Index: SESION_PK                                             */
/*==============================================================*/
create unique index SESION_PK on SESION (
ID_USERN,
ID_SESION
);

/*==============================================================*/
/* Index: RELATIONSHIP_14_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_14_FK on SESION (
ID_USERN
);

/*==============================================================*/
/* Table: TAREA                                                 */
/*==============================================================*/
create table TAREA (
   ID_TAREA             SERIAL               not null,
   NOMBRE_TAREA         VARCHAR(30)          not null,
   FECHA_ASIGNACION     DATE                 null,
   FECHA_ENTREGA        DATE                 null,
   DESCRIPCION_TAREA    VARCHAR(200)         null,
   constraint PK_TAREA primary key (ID_TAREA)
);

/*==============================================================*/
/* Index: TAREA_PK                                              */
/*==============================================================*/
create unique index TAREA_PK on TAREA (
ID_TAREA
);

/*==============================================================*/
/* Table: TAREA_ENTREGA                                         */
/*==============================================================*/
create table TAREA_ENTREGA (
   ID_TAREA             INT4                 not null,
   ID_ENTREGA           INT4                 not null,
   FECHA_TAREA_ENTREGADA DATE                 not null,
   constraint PK_TAREA_ENTREGA primary key (ID_TAREA, ID_ENTREGA, FECHA_TAREA_ENTREGADA)
);

/*==============================================================*/
/* Index: TAREA_ENTREGA_PK                                      */
/*==============================================================*/
create unique index TAREA_ENTREGA_PK on TAREA_ENTREGA (
ID_TAREA,
ID_ENTREGA,
FECHA_TAREA_ENTREGADA
);

/*==============================================================*/
/* Index: RELATIONSHIP_25_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_25_FK on TAREA_ENTREGA (
ID_TAREA
);

/*==============================================================*/
/* Index: RELATIONSHIP_26_FK                                    */
/*==============================================================*/
create  index RELATIONSHIP_26_FK on TAREA_ENTREGA (
ID_ENTREGA
);

/*==============================================================*/
/* Table: TIPO_ARCHIVO                                          */
/*==============================================================*/
create table TIPO_ARCHIVO (
   ID_TIPO_ARCHIVO      SERIAL               not null,
   TIPO_ARCHIVO         VARCHAR(10)          not null,
   constraint PK_TIPO_ARCHIVO primary key (ID_TIPO_ARCHIVO)
);

/*==============================================================*/
/* Index: TIPO_ARCHIVO_PK                                       */
/*==============================================================*/
create unique index TIPO_ARCHIVO_PK on TIPO_ARCHIVO (
ID_TIPO_ARCHIVO
);

/*==============================================================*/
/* Table: UI                                                    */
/*==============================================================*/
create table UI (
   ID_UI                INT4                 not null,
   NOMBRE_UI            VARCHAR(30)          not null,
   UI_ACTIVO            BOOL                 not null,
   constraint PK_UI primary key (ID_UI)
);

/*==============================================================*/
/* Index: UI_PK                                                 */
/*==============================================================*/
create unique index UI_PK on UI (
ID_UI
);

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
create table USUARIO (
   ID_USERN             SERIAL               not null,
   NOMBRE               VARCHAR(30)          not null,
   CONTRASENIA          VARCHAR(30)          not null,
   FECHA_NAC            DATE                 not null,
   constraint PK_USUARIO primary key (ID_USERN)
);

/*==============================================================*/
/* Index: USUARIO_PK                                            */
/*==============================================================*/
create unique index USUARIO_PK on USUARIO (
ID_USERN
);

alter table COMENTARIO
   add constraint FK_COMENTAR_RELATIONS_COMENTAR foreign key (ID_COM_RESPUESTA)
      references COMENTARIO (ID_COMENTARIO)
      on delete restrict on update restrict;

alter table COMENTARIO_ENTREGA
   add constraint FK_COMENTAR_RELATIONS_ENTREGA foreign key (ID_ENTREGA)
      references ENTREGA (ID_ENTREGA)
      on delete restrict on update restrict;

alter table COMENTARIO_ENTREGA
   add constraint FK_COMENTAR_RELATIONS_COMENTAR foreign key (ID_COMENTARIO)
      references COMENTARIO (ID_COMENTARIO)
      on delete restrict on update restrict;

alter table DOCENTE
   add constraint FK_DOCENTE_RELATIONS_USUARIO foreign key (ID_DOCENTE)
      references USUARIO (ID_USERN)
      on delete restrict on update restrict;

alter table ENTREGA
   add constraint FK_ENTREGA_RELATIONS_TIPO_ARC foreign key (ID_TIPO_ARCHIVO)
      references TIPO_ARCHIVO (ID_TIPO_ARCHIVO)
      on delete restrict on update restrict;

alter table ESTUDIANTE
   add constraint FK_ESTUDIAN_RELATIONS_USUARIO foreign key (ID_ESTUDIANTE)
      references USUARIO (ID_USERN)
      on delete restrict on update restrict;

alter table ESTUDIANTE_ENTREGA
   add constraint FK_ESTUDIAN_RELATIONS_ESTUDIAN foreign key (ID_ESTUDIANTE)
      references ESTUDIANTE (ID_ESTUDIANTE)
      on delete restrict on update restrict;

alter table ESTUDIANTE_ENTREGA
   add constraint FK_ESTUDIAN_RELATIONS_ENTREGA foreign key (ID_ENTREGA)
      references ENTREGA (ID_ENTREGA)
      on delete restrict on update restrict;

alter table FUNCIONUI
   add constraint FK_FUNCIONU_RELATIONS_FUNCION foreign key (ID_FUNCION)
      references FUNCION (ID_FUNCION)
      on delete restrict on update restrict;

alter table FUNCIONUI
   add constraint FK_FUNCIONU_RELATIONS_UI foreign key (ID_UI)
      references UI (ID_UI)
      on delete restrict on update restrict;

alter table INSCRIPCION
   add constraint FK_INSCRIPC_RELATIONS_MATERIA foreign key (ID_MATERIA, ID_DOCENTE)
      references MATERIA (ID_MATERIA, ID_DOCENTE)
      on delete restrict on update restrict;

alter table INSCRIPCION
   add constraint FK_INSCRIPC_RELATIONS_ESTUDIAN foreign key (ID_ESTUDIANTE)
      references ESTUDIANTE (ID_ESTUDIANTE)
      on delete restrict on update restrict;

alter table LICENCIATURA
   add constraint FK_LICENCIA_RELATIONS_GRADO_AC foreign key (ID_GRADO_ACAD)
      references GRADO_ACADEMICO (ID_GRADO_ACAD)
      on delete restrict on update restrict;

alter table LICENCIATURA
   add constraint FK_LICENCIA_RELATIONS_DOCENTE foreign key (ID_DOCENTE)
      references DOCENTE (ID_DOCENTE)
      on delete restrict on update restrict;

alter table MATERIA
   add constraint FK_MATERIA_RELATIONS_DOCENTE foreign key (ID_DOCENTE)
      references DOCENTE (ID_DOCENTE)
      on delete restrict on update restrict;

alter table MATERIA_TAREA
   add constraint FK_MATERIA__RELATIONS_MATERIA foreign key (ID_MATERIA, ID_DOCENTE)
      references MATERIA (ID_MATERIA, ID_DOCENTE)
      on delete restrict on update restrict;

alter table MATERIA_TAREA
   add constraint FK_MATERIA__RELATIONS_TAREA foreign key (ID_TAREA)
      references TAREA (ID_TAREA)
      on delete restrict on update restrict;

alter table ROL_FUNCION
   add constraint FK_ROL_FUNC_RELATIONS_ROL foreign key (ID_ROL)
      references ROL (ID_ROL)
      on delete restrict on update restrict;

alter table ROL_FUNCION
   add constraint FK_ROL_FUNC_RELATIONS_FUNCION foreign key (ID_FUNCION)
      references FUNCION (ID_FUNCION)
      on delete restrict on update restrict;

alter table ROL_USERN
   add constraint FK_ROL_USER_RELATIONS_ROL foreign key (ID_ROL)
      references ROL (ID_ROL)
      on delete restrict on update restrict;

alter table ROL_USERN
   add constraint FK_ROL_USER_RELATIONS_USUARIO foreign key (ID_USERN)
      references USUARIO (ID_USERN)
      on delete restrict on update restrict;

alter table SESION
   add constraint FK_SESION_RELATIONS_USUARIO foreign key (ID_USERN)
      references USUARIO (ID_USERN)
      on delete restrict on update restrict;

alter table TAREA_ENTREGA
   add constraint FK_TAREA_EN_RELATIONS_TAREA foreign key (ID_TAREA)
      references TAREA (ID_TAREA)
      on delete restrict on update restrict;

alter table TAREA_ENTREGA
   add constraint FK_TAREA_EN_RELATIONS_ENTREGA foreign key (ID_ENTREGA)
      references ENTREGA (ID_ENTREGA)
      on delete restrict on update restrict;

