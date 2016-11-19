/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     19/11/2016 09:58:50 a.m.   			*/
/* NOMBRE DE LA BASE: bd_becas					*/
/* COTEJAMIENTO: latin1_swedish_ci				*/
/*==============================================================*/

drop table if exists ACCION;

drop table if exists ASOCIACIONES;

drop table if exists BECA;

drop table if exists BITACORA;

drop table if exists CARGO;

drop table if exists DEPARTAMENTO;

drop table if exists DETALLE_USUARIO;

drop table if exists DOCUMENTO;

drop table if exists EDUCACION;

drop table if exists EXPEDIENTE;

drop table if exists FACULTAD;

drop table if exists IDIOMA;

drop table if exists INSTITUCION;

drop table if exists INVESTIGACIONES;

drop table if exists MUNICIPIO;

drop table if exists OBSERVACIONES;

drop table if exists OFERTA_BECA;

drop table if exists PROGRAMA_ESTUDIO;

drop table if exists PROGRESO;

drop table if exists REFERENCIAS;

drop table if exists SOLICITUD_DE_BECA;

drop table if exists TIPO_DOCUMENTO;

drop table if exists TIPO_USUARIO;

drop table if exists USUARIO;

/*==============================================================*/
/* Table: ACCION                                                */
/*==============================================================*/
create table ACCION
(
   ID_ACCION            int not null,
   ACCION               varchar(30),
   primary key (ID_ACCION)
);

/*==============================================================*/
/* Table: ASOCIACIONES                                          */
/*==============================================================*/
create table ASOCIACIONES
(
   ID_ASOCIACION        int not null,
   ID_DETALLE_USUARIO   int,
   NOMBRE_ASOCIACION    varchar(100),
   primary key (ID_ASOCIACION)
);

/*==============================================================*/
/* Table: BECA                                                  */
/*==============================================================*/
create table BECA
(
   ID_BECA              int not null,
   ID_EXPEDIENTE        int not null,
   FECHA_INICIO         date,
   FECHA_FIN            date,
   primary key (ID_BECA)
);

/*==============================================================*/
/* Table: BITACORA                                              */
/*==============================================================*/
create table BITACORA
(
   ID_BITACORA          int not null,
   ID_ACCION            int,
   ID_USUARIO           int,
   FECHA_BITACORA       timestamp,
   DESCRIPCION          varchar(1024),
   SQL_SCRIPT           varchar(1024),
   primary key (ID_BITACORA)
);

/*==============================================================*/
/* Table: CARGO                                                 */
/*==============================================================*/
create table CARGO
(
   ID_CARGO             int not null,
   ID_DETALLE_USUARIO   int,
   NOMBRE_CARGO         varchar(50),
   FECHA_INICIO         date,
   FECHA_FIN            date,
   LUGAR                varchar(100),
   primary key (ID_CARGO)
);

/*==============================================================*/
/* Table: DEPARTAMENTO                                          */
/*==============================================================*/
create table DEPARTAMENTO
(
   ID_DEPARTAMENTO      int not null,
   NOMBRE_DEPARTAMENTO  varchar(20),
   primary key (ID_DEPARTAMENTO)
);

/*==============================================================*/
/* Table: DETALLE_USUARIO                                       */
/*==============================================================*/
create table DETALLE_USUARIO
(
   ID_DETALLE_USUARIO   int not null,
   ID_USUARIO           int not null,
   ID_MUNICIPIO         int,
   ID_FACULTAD          int not null,
   ID_MUNICIPIO_NACIMIENTO int,
   CARNET               varchar(20),
   NOMBRE1_DU           varchar(15),
   NOMBRE2_DU           varchar(15),
   APELLIDO1_DU         varchar(15),
   APELLIDO2_DU         varchar(15),
   DEPARTAMENTO         varchar(100),
   FECHA_NACIMIENTO     date,
   PROFESION            varchar(30),
   FECHA_CONTRATACION   date,
   TELEFONO_MOVIL       varchar(9),
   TELEFONO_CASA        varchar(9),
   TELEFONO_OFICINA     varchar(9),
   primary key (ID_DETALLE_USUARIO)
);

/*==============================================================*/
/* Table: DOCUMENTO                                             */
/*==============================================================*/
create table DOCUMENTO
(
   ID_DOCUMENTO         int not null,
   ID_TIPO_DOCUMENTO    int,
   ID_EXPEDIENTE        int not null,
   DOCUMENTO_DIGITAL    longblob,
   FECHA_SOLICITUD      date,
   OBSERVACION_O        varchar(1024),
   FECHA_INGRESO        date,
   ESTADO_DOCUMENTO     varchar(15),
   primary key (ID_DOCUMENTO)
);

/*==============================================================*/
/* Table: EDUCACION                                             */
/*==============================================================*/
create table EDUCACION
(
   ID_EDUCACION         int not null,
   ID_DETALLE_USUARIO   int,
   TIPO_EDUCACION       varchar(20),
   GRADO_ALCANZADO      varchar(30),
   NOMBRE_INSTITUCION   varchar(100),
   ANIO                 int,
   primary key (ID_EDUCACION)
);

/*==============================================================*/
/* Table: EXPEDIENTE                                            */
/*==============================================================*/
create table EXPEDIENTE
(
   ID_EXPEDIENTE        int not null,
   ID_PROGRESO          int,
   ESTADO_EXPEDIENTE    varchar(10),
   primary key (ID_EXPEDIENTE)
);

/*==============================================================*/
/* Table: FACULTAD                                              */
/*==============================================================*/
create table FACULTAD
(
   ID_FACULTAD          int not null,
   FACULTAD             varchar(50),
   primary key (ID_FACULTAD)
);

/*==============================================================*/
/* Table: IDIOMA                                                */
/*==============================================================*/
create table IDIOMA
(
   ID_IDIOMA            int not null,
   ID_DETALLE_USUARIO   int,
   IDIOMA               varchar(20),
   NIVEL_HABLA          varchar(15),
   NIVEL_LECTURA        varchar(15),
   NIVEL_ESCRITO        varchar(15),
   primary key (ID_IDIOMA)
);

/*==============================================================*/
/* Table: INSTITUCION                                           */
/*==============================================================*/
create table INSTITUCION
(
   ID_INSTITUCION       int not null,
   NOMBRE_INSTITUCION   varchar(100),
   TIPO_INSTITUCION     varchar(20),
   PAIS                 varchar(20),
   PAGINA_WEB           varchar(100),
   EMAIL                varchar(30),
   INSTITUCION_ACTIVA   bool,
   primary key (ID_INSTITUCION)
);

/*==============================================================*/
/* Table: INVESTIGACIONES                                       */
/*==============================================================*/
create table INVESTIGACIONES
(
   ID_INVESTIGACION     int not null,
   ID_DETALLE_USUARIO   int,
   TITULO_INVESTIGACION varchar(100),
   PUBLICADO            bool,
   primary key (ID_INVESTIGACION)
);

/*==============================================================*/
/* Table: MUNICIPIO                                             */
/*==============================================================*/
create table MUNICIPIO
(
   ID_MUNICIPIO         int not null,
   ID_DEPARTAMENTO      int not null,
   NOMBRE_MUNICIPIO     varchar(30),
   primary key (ID_MUNICIPIO)
);

/*==============================================================*/
/* Table: OBSERVACIONES                                         */
/*==============================================================*/
create table OBSERVACIONES
(
   ID_OBSERVACION       int not null,
   ID_EXPEDIENTE        int,
   OBSERVACION_O        varchar(1024),
   primary key (ID_OBSERVACION)
);

/*==============================================================*/
/* Table: OFERTA_BECA                                           */
/*==============================================================*/
create table OFERTA_BECA
(
   ID_OFERTA_BECA       int not null,
   ID_INSTITUCION_ESTUDIO int not null,
   ID_INSTITUCION_FINANCIERA int not null,
   ID_DOCUMENTO         int not null,
   NOMBRE_OFERTA        varchar(100),
   TIPO_OFERTA_BECA     varchar(10),
   DURACION             int,
   FECHA_CIERRE         date,
   MODALIDAD            varchar(20),
   FECHA_INICIO         date,
   IDIOMA               varchar(20),
   FINANCIAMIENTO       varchar(20),
   PERFIL               varchar(2000),
   FECHA_INGRESO        date,
   TIPO_ESTUDIO         varchar(15),
   OFERTA_BECA_ACTIVA   bool,
   primary key (ID_OFERTA_BECA)
);

/*==============================================================*/
/* Table: PROGRAMA_ESTUDIO                                      */
/*==============================================================*/
create table PROGRAMA_ESTUDIO
(
   ID_PROGRAMA_ESTUDIO  int not null,
   ID_SOLICITUD         int,
   SEMESTRE             int,
   PROGRAMA_ESTUDIO     varchar(1024),
   primary key (ID_PROGRAMA_ESTUDIO)
);

/*==============================================================*/
/* Table: PROGRESO                                              */
/*==============================================================*/
create table PROGRESO
(
   ID_PROGRESO          int not null,
   NOMBRE_PROGRESO      varchar(50),
   DESCRIPCION_PROGRESO varchar(1024),
   ESTADO_BECARIO       varchar(15),
   ESTADO_PROGRESO      varchar(15),
   primary key (ID_PROGRESO)
);

/*==============================================================*/
/* Table: REFERENCIAS                                           */
/*==============================================================*/
create table REFERENCIAS
(
   ID_REFERENCIA        int not null,
   ID_SOLICITUD         int,
   ID_MUNICIPIO         int,
   NOMBRE1_DU           varchar(15),
   NOMBRE2_DU           varchar(15),
   APELLIDO1_DU         varchar(15),
   APELLIDO2_DU         varchar(15),
   DOMICILIO            varchar(50),
   TELEFONO_MOVIL       varchar(9),
   primary key (ID_REFERENCIA)
);

/*==============================================================*/
/* Table: SOLICITUD_DE_BECA                                     */
/*==============================================================*/
create table SOLICITUD_DE_BECA
(
   ID_SOLICITUD         int not null,
   ID_USUARIO           int,
   ID_EXPEDIENTE        int,
   ID_OFERTA_BECA       int not null,
   FECHA_SOLICITUD      date,
   BENEFICIOS           varchar(1024),
   primary key (ID_SOLICITUD)
);

/*==============================================================*/
/* Table: TIPO_DOCUMENTO                                        */
/*==============================================================*/
create table TIPO_DOCUMENTO
(
   ID_TIPO_DOCUMENTO    int not null,
   TIPO_DOCUMENTO       varchar(100),
   DEPARTAMENTO         varchar(100),
   DESCRIPCION          varchar(1024),
   primary key (ID_TIPO_DOCUMENTO)
);

/*==============================================================*/
/* Table: TIPO_USUARIO                                          */
/*==============================================================*/
create table TIPO_USUARIO
(
   ID_TIPO_USUARIO      int not null,
   TIPO_USUARIO         varchar(50),
   DESCRIPCION_TIPO_USUARIO varchar(300),
   primary key (ID_TIPO_USUARIO)
);

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
create table USUARIO
(
   ID_USUARIO           int not null,
   ID_TIPO_USUARIO      int not null,
   NOMBRE_USUARIO       varchar(20),
   CLAVE                varchar(32),
   primary key (ID_USUARIO)
);

alter table ASOCIACIONES add constraint FK_PERTENECE foreign key (ID_DETALLE_USUARIO)
      references DETALLE_USUARIO (ID_DETALLE_USUARIO) on delete restrict on update restrict;

alter table BECA add constraint FK_RELATIONSHIP_14 foreign key (ID_EXPEDIENTE)
      references EXPEDIENTE (ID_EXPEDIENTE) on delete restrict on update restrict;

alter table BITACORA add constraint FK_RELATIONSHIP_8 foreign key (ID_ACCION)
      references ACCION (ID_ACCION) on delete restrict on update restrict;

alter table BITACORA add constraint FK_RELATIONSHIP_9 foreign key (ID_USUARIO)
      references USUARIO (ID_USUARIO) on delete restrict on update restrict;

alter table CARGO add constraint FK_RELATIONSHIP_26 foreign key (ID_DETALLE_USUARIO)
      references DETALLE_USUARIO (ID_DETALLE_USUARIO) on delete restrict on update restrict;

alter table DETALLE_USUARIO add constraint FK_CONTIENE3 foreign key (ID_FACULTAD)
      references FACULTAD (ID_FACULTAD) on delete restrict on update restrict;

alter table DETALLE_USUARIO add constraint FK_NACE2 foreign key (ID_MUNICIPIO_NACIMIENTO)
      references MUNICIPIO (ID_MUNICIPIO) on delete restrict on update restrict;

alter table DETALLE_USUARIO add constraint FK_NECESITA2 foreign key (ID_USUARIO)
      references USUARIO (ID_USUARIO) on delete restrict on update restrict;

alter table DETALLE_USUARIO add constraint FK_RELATIONSHIP_3 foreign key (ID_MUNICIPIO)
      references MUNICIPIO (ID_MUNICIPIO) on delete restrict on update restrict;

alter table DOCUMENTO add constraint FK_ALMACENA foreign key (ID_EXPEDIENTE)
      references EXPEDIENTE (ID_EXPEDIENTE) on delete restrict on update restrict;

alter table DOCUMENTO add constraint FK_ES_DE foreign key (ID_TIPO_DOCUMENTO)
      references TIPO_DOCUMENTO (ID_TIPO_DOCUMENTO) on delete restrict on update restrict;

alter table EDUCACION add constraint FK_TIENE foreign key (ID_DETALLE_USUARIO)
      references DETALLE_USUARIO (ID_DETALLE_USUARIO) on delete restrict on update restrict;

alter table EXPEDIENTE add constraint FK_RELATIONSHIP_16 foreign key (ID_PROGRESO)
      references PROGRESO (ID_PROGRESO) on delete restrict on update restrict;

alter table IDIOMA add constraint FK_HABLA foreign key (ID_DETALLE_USUARIO)
      references DETALLE_USUARIO (ID_DETALLE_USUARIO) on delete restrict on update restrict;

alter table INVESTIGACIONES add constraint FK_RELATIONSHIP_21 foreign key (ID_DETALLE_USUARIO)
      references DETALLE_USUARIO (ID_DETALLE_USUARIO) on delete restrict on update restrict;

alter table MUNICIPIO add constraint FK_RELATIONSHIP_4 foreign key (ID_DEPARTAMENTO)
      references DEPARTAMENTO (ID_DEPARTAMENTO) on delete restrict on update restrict;

alter table OBSERVACIONES add constraint FK_SE_REALIZAN_A foreign key (ID_EXPEDIENTE)
      references EXPEDIENTE (ID_EXPEDIENTE) on delete restrict on update restrict;

alter table OFERTA_BECA add constraint FK_ES_FINANCIADA foreign key (ID_INSTITUCION_ESTUDIO)
      references INSTITUCION (ID_INSTITUCION) on delete restrict on update restrict;

alter table OFERTA_BECA add constraint FK_ES_IMPARTIDA foreign key (ID_INSTITUCION_FINANCIERA)
      references INSTITUCION (ID_INSTITUCION) on delete restrict on update restrict;

alter table OFERTA_BECA add constraint FK_RELATIONSHIP_13 foreign key (ID_DOCUMENTO)
      references DOCUMENTO (ID_DOCUMENTO) on delete restrict on update restrict;

alter table PROGRAMA_ESTUDIO add constraint FK_RELATIONSHIP_24 foreign key (ID_SOLICITUD)
      references SOLICITUD_DE_BECA (ID_SOLICITUD) on delete restrict on update restrict;

alter table REFERENCIAS add constraint FK_RELATIONSHIP_25 foreign key (ID_SOLICITUD)
      references SOLICITUD_DE_BECA (ID_SOLICITUD) on delete restrict on update restrict;

alter table REFERENCIAS add constraint FK_RELATIONSHIP_29 foreign key (ID_MUNICIPIO)
      references MUNICIPIO (ID_MUNICIPIO) on delete restrict on update restrict;

alter table SOLICITUD_DE_BECA add constraint FK_CONTIENE2 foreign key (ID_OFERTA_BECA)
      references OFERTA_BECA (ID_OFERTA_BECA) on delete restrict on update restrict;

alter table SOLICITUD_DE_BECA add constraint FK_REALIZA foreign key (ID_USUARIO)
      references USUARIO (ID_USUARIO) on delete restrict on update restrict;

alter table SOLICITUD_DE_BECA add constraint FK_RELATIONSHIP_12 foreign key (ID_EXPEDIENTE)
      references EXPEDIENTE (ID_EXPEDIENTE) on delete restrict on update restrict;

alter table USUARIO add constraint FK_RELATIONSHIP_27 foreign key (ID_TIPO_USUARIO)
      references TIPO_USUARIO (ID_TIPO_USUARIO) on delete restrict on update restrict;

INSERT INTO departamento  VALUES (1, 'Ahuachapán');
INSERT INTO departamento  VALUES (2, 'Cabañas');
INSERT INTO departamento  VALUES (3, 'Chalatenango');
INSERT INTO departamento  VALUES (4, 'Cuscatlán');
INSERT INTO departamento  VALUES (5, 'La Libertad');
INSERT INTO departamento  VALUES (6, 'La Paz');
INSERT INTO departamento  VALUES (7, 'La Unión');
INSERT INTO departamento  VALUES (8, 'Morazán');
INSERT INTO departamento  VALUES (9, 'San Miguel');
INSERT INTO departamento  VALUES (10, 'San Salvador');
INSERT INTO departamento  VALUES (11, 'San Vicente');
INSERT INTO departamento  VALUES (12, 'Santa Ana');
INSERT INTO departamento  VALUES (13, 'Sonsonate');
INSERT INTO departamento  VALUES (14, 'Usulután');

INSERT INTO municipio  VALUES (1, 1, 'Ahuachapán');
INSERT INTO municipio  VALUES (2, 1, 'Jujutla');
INSERT INTO municipio  VALUES (3, 1, 'Atiquizaya');
INSERT INTO municipio  VALUES (4, 1, 'Concepción de Ataco');
INSERT INTO municipio  VALUES (5, 1, 'El Refugio');
INSERT INTO municipio  VALUES (6, 1, 'Guaymango');
INSERT INTO municipio  VALUES (7, 1, 'Apaneca');
INSERT INTO municipio  VALUES (8, 1, 'San Francisco Menéndez');
INSERT INTO municipio  VALUES (9, 1, 'San Lorenzo');
INSERT INTO municipio  VALUES (10, 1, 'San Pedro Puxtla');
INSERT INTO municipio  VALUES (11, 1, 'Tacuba');
INSERT INTO municipio  VALUES (12, 1, 'Turín');
INSERT INTO municipio  VALUES (13, 2, 'Cinquera');
INSERT INTO municipio  VALUES (14, 2, 'Villa Dolores');
INSERT INTO municipio  VALUES (15, 2, 'Guacotecti');
INSERT INTO municipio  VALUES (16, 2, 'Ilobasco');
INSERT INTO municipio  VALUES (17, 2, 'Jutiapa');
INSERT INTO municipio  VALUES (18, 2, 'San Isidro');
INSERT INTO municipio  VALUES (19, 2, 'Sensuntepeque');
INSERT INTO municipio  VALUES (20, 2, 'Ciudad de Tejutepeque');
INSERT INTO municipio  VALUES (21, 2, 'Victoria');
INSERT INTO municipio  VALUES (22, 3, 'Agua Caliente');
INSERT INTO municipio  VALUES (23, 3, 'Arcatao');
INSERT INTO municipio  VALUES (24, 3, 'Azacualpa');
INSERT INTO municipio  VALUES (25, 3, 'Chalatenango');
INSERT INTO municipio  VALUES (26, 3, 'Citalá');
INSERT INTO municipio  VALUES (27, 3, 'Comalapa');
INSERT INTO municipio  VALUES (28, 3, 'Concepción Quezaltepeque');
INSERT INTO municipio  VALUES (29, 3, 'Dulce Nombre de María');
INSERT INTO municipio  VALUES (30, 3, 'El Carrizal');
INSERT INTO municipio  VALUES (31, 3, 'El Paraíso');
INSERT INTO municipio  VALUES (32, 3, 'La Laguna');
INSERT INTO municipio  VALUES (33, 3, 'La Palma');
INSERT INTO municipio  VALUES (34, 3, 'La Reina');
INSERT INTO municipio  VALUES (35, 3, 'Las Vueltas');
INSERT INTO municipio  VALUES (36, 3, 'Nombre de Jesús');
INSERT INTO municipio  VALUES (37, 3, 'Nueva Concepción');
INSERT INTO municipio  VALUES (38, 3, 'Nueva Trinidad');
INSERT INTO municipio  VALUES (39, 3, 'Ojos de Agua');
INSERT INTO municipio  VALUES (40, 3, 'Potonico');
INSERT INTO municipio  VALUES (41, 3, 'San Antonio de la Cruz');
INSERT INTO municipio  VALUES (42, 3, 'San Antonio Los Ranchos');
INSERT INTO municipio  VALUES (43, 3, 'San Fernando');
INSERT INTO municipio  VALUES (44, 3, 'San Francisco Lempa');
INSERT INTO municipio  VALUES (45, 3, 'San Francisco Morazán');
INSERT INTO municipio  VALUES (46, 3, 'San Ignacio');
INSERT INTO municipio  VALUES (47, 3, 'San Isidro Labrador');
INSERT INTO municipio  VALUES (48, 3, 'San José Cancasque');
INSERT INTO municipio  VALUES (49, 3, 'San José Las Flores');
INSERT INTO municipio  VALUES (50, 3, 'San Luis del Carmen');
INSERT INTO municipio  VALUES (51, 3, 'San Miguel de Mercedes');
INSERT INTO municipio  VALUES (52, 3, 'San Rafael');
INSERT INTO municipio  VALUES (53, 3, 'Santa Rita');
INSERT INTO municipio  VALUES (54, 3, 'Tejutla');
INSERT INTO municipio  VALUES (55, 4, 'Candelaria');
INSERT INTO municipio  VALUES (56, 4, 'Cojutepeque');
INSERT INTO municipio  VALUES (57, 4, 'El Carmen');
INSERT INTO municipio  VALUES (58, 4, 'El Rosario');
INSERT INTO municipio  VALUES (59, 4, 'Monte San Juan');
INSERT INTO municipio  VALUES (60, 4, 'Oratorio de Concepción');
INSERT INTO municipio  VALUES (61, 4, 'San Bartolomé Perulapía');
INSERT INTO municipio  VALUES (62, 4, 'San Cristóbal');
INSERT INTO municipio  VALUES (63, 4, 'San José Guayabal');
INSERT INTO municipio  VALUES (64, 4, 'San Pedro Perulapán');
INSERT INTO municipio  VALUES (65, 4, 'San Rafael Cedros');
INSERT INTO municipio  VALUES (66, 4, 'San Ramón');
INSERT INTO municipio  VALUES (67, 4, 'Santa Cruz Analquito');
INSERT INTO municipio  VALUES (68, 4, 'Santa Cruz Michapa');
INSERT INTO municipio  VALUES (69, 4, 'Suchitoto');
INSERT INTO municipio  VALUES (70, 4, 'Tenancingo');
INSERT INTO municipio  VALUES (71, 5, 'Antiguo Cuscatlán');
INSERT INTO municipio  VALUES (72, 5, 'Chiltiupán');
INSERT INTO municipio  VALUES (73, 5, 'Ciudad Arce');
INSERT INTO municipio  VALUES (74, 5, 'Colón');
INSERT INTO municipio  VALUES (75, 5, 'Comasagua');
INSERT INTO municipio  VALUES (76, 5, 'Huizúcar');
INSERT INTO municipio  VALUES (77, 5, 'Jayaque');
INSERT INTO municipio  VALUES (78, 5, 'Jicalapa');
INSERT INTO municipio  VALUES (79, 5, 'La Libertad');
INSERT INTO municipio  VALUES (80, 5, 'Nueva San Salvador');
INSERT INTO municipio  VALUES (81, 5, 'Nuevo Cuscatlán');
INSERT INTO municipio  VALUES (82, 5, 'Opico');
INSERT INTO municipio  VALUES (83, 5, 'Quezaltepeque');
INSERT INTO municipio  VALUES (84, 5, 'Sacacoyo');
INSERT INTO municipio  VALUES (85, 5, 'San José Villanueva');
INSERT INTO municipio  VALUES (86, 5, 'San Matías');
INSERT INTO municipio  VALUES (87, 5, 'San Pablo Tacachico');
INSERT INTO municipio  VALUES (88, 5, 'Talnique');
INSERT INTO municipio  VALUES (89, 5, 'Tamanique');
INSERT INTO municipio  VALUES (90, 5, 'Teotepeque');
INSERT INTO municipio  VALUES (91, 5, 'Tepecoyo');
INSERT INTO municipio  VALUES (92, 5, 'Zaragoza');
INSERT INTO municipio  VALUES (93, 6, 'Cuyultitán');
INSERT INTO municipio  VALUES (94, 6, 'El Rosario');
INSERT INTO municipio  VALUES (95, 6, 'Jerusalén');
INSERT INTO municipio  VALUES (96, 6, 'Mercedes La Ceiba');
INSERT INTO municipio  VALUES (97, 6, 'Olocuilta');
INSERT INTO municipio  VALUES (98, 6, 'Paraíso de Osorio');
INSERT INTO municipio  VALUES (99, 6, 'San Antonio Masahuat');
INSERT INTO municipio  VALUES (100, 6, 'San Emigdio');
INSERT INTO municipio  VALUES (101, 6, 'San Francisco Chinameca');
INSERT INTO municipio  VALUES (102, 6, 'San Juan Nonualco');
INSERT INTO municipio  VALUES (103, 6, 'San Juan Talpa');
INSERT INTO municipio  VALUES (104, 6, 'San Juan Tepezontes');
INSERT INTO municipio  VALUES (105, 6, 'San Luis La Herradura');
INSERT INTO municipio  VALUES (106, 6, 'San Luis Talpa');
INSERT INTO municipio  VALUES (107, 6, 'San Miguel Tepezontes');
INSERT INTO municipio  VALUES (108, 6, 'San Pedro Masahuat');
INSERT INTO municipio  VALUES (109, 6, 'San Pedro Nonualco');
INSERT INTO municipio  VALUES (110, 6, 'San Rafael Obrajuelo');
INSERT INTO municipio  VALUES (111, 6, 'Santa María Ostuma');
INSERT INTO municipio  VALUES (112, 6, 'Santiago Nonualco');
INSERT INTO municipio  VALUES (113, 6, 'Tapalhuaca');
INSERT INTO municipio  VALUES (114, 6, 'Zacatecoluca');
INSERT INTO municipio  VALUES (115, 7, 'Anamorós');
INSERT INTO municipio  VALUES (116, 7, 'Bolívar');
INSERT INTO municipio  VALUES (117, 7, 'Concepción de Oriente');
INSERT INTO municipio  VALUES (118, 7, 'Conchagua');
INSERT INTO municipio  VALUES (119, 7, 'El Carmen');
INSERT INTO municipio  VALUES (120, 7, 'El Sauce');
INSERT INTO municipio  VALUES (121, 7, 'Intipucá');
INSERT INTO municipio  VALUES (122, 7, 'La Unión');
INSERT INTO municipio  VALUES (123, 7, 'Lislique');
INSERT INTO municipio  VALUES (124, 7, 'Meanguera del Golfo');
INSERT INTO municipio  VALUES (125, 7, 'Nueva Esparta');
INSERT INTO municipio  VALUES (126, 7, 'Pasaquina');
INSERT INTO municipio  VALUES (127, 7, 'Polorós');
INSERT INTO municipio  VALUES (128, 7, 'San Alejo');
INSERT INTO municipio  VALUES (129, 7, 'San José');
INSERT INTO municipio  VALUES (130, 7, 'Santa Rosa de Lima');
INSERT INTO municipio  VALUES (131, 7, 'Yayantique');
INSERT INTO municipio  VALUES (132, 7, 'Yucuayquín');
INSERT INTO municipio  VALUES (133, 8, 'Arambala');
INSERT INTO municipio  VALUES (134, 8, 'Cacaopera');
INSERT INTO municipio  VALUES (135, 8, 'Chilanga');
INSERT INTO municipio  VALUES (136, 8, 'Corinto');
INSERT INTO municipio  VALUES (137, 8, 'Delicias de Concepción');
INSERT INTO municipio  VALUES (138, 8, 'El Divisadero');
INSERT INTO municipio  VALUES (139, 8, 'El Rosario');
INSERT INTO municipio  VALUES (140, 8, 'Gualococti');
INSERT INTO municipio  VALUES (141, 8, 'Guatajiagua');
INSERT INTO municipio  VALUES (142, 8, 'Joateca');
INSERT INTO municipio  VALUES (143, 8, 'Jocoaitique');
INSERT INTO municipio  VALUES (144, 8, 'Jocoro');
INSERT INTO municipio  VALUES (145, 8, 'Lolotiquillo');
INSERT INTO municipio  VALUES (146, 8, 'Meanguera');
INSERT INTO municipio  VALUES (147, 8, 'Osicala');
INSERT INTO municipio  VALUES (148, 8, 'Perquín');
INSERT INTO municipio  VALUES (149, 8, 'San Carlos');
INSERT INTO municipio  VALUES (150, 8, 'San Fernando');
INSERT INTO municipio  VALUES (151, 8, 'San Francisco Gotera');
INSERT INTO municipio  VALUES (152, 8, 'San Isidro');
INSERT INTO municipio  VALUES (153, 8, 'San Simón');
INSERT INTO municipio  VALUES (154, 8, 'Sensembra');
INSERT INTO municipio  VALUES (155, 8, 'Sociedad');
INSERT INTO municipio  VALUES (156, 8, 'Torola');
INSERT INTO municipio  VALUES (157, 8, 'Yamabal');
INSERT INTO municipio  VALUES (158, 8, 'Yoloaiquín');
INSERT INTO municipio  VALUES (159, 9, 'Carolina');
INSERT INTO municipio  VALUES (160, 9, 'Chapeltique');
INSERT INTO municipio  VALUES (161, 9, 'Chinameca');
INSERT INTO municipio  VALUES (162, 9, 'Chirilagua');
INSERT INTO municipio  VALUES (163, 9, 'Ciudad Barrios');
INSERT INTO municipio  VALUES (164, 9, 'Comacarán');
INSERT INTO municipio  VALUES (165, 9, 'El Tránsito');
INSERT INTO municipio  VALUES (166, 9, 'Lolotique');
INSERT INTO municipio  VALUES (167, 9, 'Moncagua');
INSERT INTO municipio  VALUES (168, 9, 'Nueva Guadalupe');
INSERT INTO municipio  VALUES (169, 9, 'Nuevo Edén de San Juan');
INSERT INTO municipio  VALUES (170, 9, 'Quelepa');
INSERT INTO municipio  VALUES (171, 9, 'San Antonio');
INSERT INTO municipio  VALUES (172, 9, 'San Gerardo');
INSERT INTO municipio  VALUES (173, 9, 'San Jorge');
INSERT INTO municipio  VALUES (174, 9, 'San Luis de la Reina');
INSERT INTO municipio  VALUES (175, 9, 'San Miguel');
INSERT INTO municipio  VALUES (176, 9, 'San Rafael');
INSERT INTO municipio  VALUES (177, 9, 'Sesori');
INSERT INTO municipio  VALUES (178, 9, 'Uluazapa');
INSERT INTO municipio  VALUES (179, 10, 'Aguilares');
INSERT INTO municipio  VALUES (180, 10, 'Apopa');
INSERT INTO municipio  VALUES (181, 10, 'Ayutuxtepeque');
INSERT INTO municipio  VALUES (182, 10, 'Cuscatancingo');
INSERT INTO municipio  VALUES (183, 10, 'Delgado');
INSERT INTO municipio  VALUES (184, 10, 'El Paisnal');
INSERT INTO municipio  VALUES (185, 10, 'Guazapa');
INSERT INTO municipio  VALUES (186, 10, 'Ilopango');
INSERT INTO municipio  VALUES (187, 10, 'Mejicanos');
INSERT INTO municipio  VALUES (188, 10, 'Nejapa');
INSERT INTO municipio  VALUES (189, 10, 'Panchimalco');
INSERT INTO municipio  VALUES (190, 10, 'Rosario de Mora');
INSERT INTO municipio  VALUES (191, 10, 'San Marcos');
INSERT INTO municipio  VALUES (192, 10, 'San Martín');
INSERT INTO municipio  VALUES (193, 10, 'San Salvador');
INSERT INTO municipio  VALUES (194, 10, 'Santiago Texacuangos');
INSERT INTO municipio  VALUES (195, 10, 'Santo Tomás');
INSERT INTO municipio  VALUES (196, 10, 'Soyapango');
INSERT INTO municipio  VALUES (197, 10, 'Tonacatepeque');
INSERT INTO municipio  VALUES (198, 11, 'Apastepeque');
INSERT INTO municipio  VALUES (199, 11, 'Guadalupe');
INSERT INTO municipio  VALUES (200, 11, 'San Cayetano Istepeque');
INSERT INTO municipio  VALUES (201, 11, 'San Esteban Catarina');
INSERT INTO municipio  VALUES (202, 11, 'San Ildefonso');
INSERT INTO municipio  VALUES (203, 11, 'San Lorenzo');
INSERT INTO municipio  VALUES (204, 11, 'San Sebastián');
INSERT INTO municipio  VALUES (205, 11, 'Santa Clara');
INSERT INTO municipio  VALUES (206, 11, 'Santo Domingo');
INSERT INTO municipio  VALUES (207, 11, 'San Vicente');
INSERT INTO municipio  VALUES (208, 11, 'Tecoluca');
INSERT INTO municipio  VALUES (209, 11, 'Tepetitán');
INSERT INTO municipio  VALUES (210, 11, 'Verapaz');
INSERT INTO municipio  VALUES (211, 12, 'Candelaria de la Frontera');
INSERT INTO municipio  VALUES (212, 12, 'Chalchuapa');
INSERT INTO municipio  VALUES (213, 12, 'Coatepeque');
INSERT INTO municipio  VALUES (214, 12, 'El Congo');
INSERT INTO municipio  VALUES (215, 12, 'El Porvenir');
INSERT INTO municipio  VALUES (216, 12, 'Masahuat');
INSERT INTO municipio  VALUES (217, 12, 'Metapán');
INSERT INTO municipio  VALUES (218, 12, 'San Antonio Pajonal');
INSERT INTO municipio  VALUES (219, 12, 'San Sebastián Salitrillo');
INSERT INTO municipio  VALUES (220, 12, 'Santa Ana');
INSERT INTO municipio  VALUES (221, 12, 'Santa Rosa Guachipilín');
INSERT INTO municipio  VALUES (222, 12, 'Santiago de la Frontera');
INSERT INTO municipio  VALUES (223, 12, 'Texistepeque');
INSERT INTO municipio  VALUES (224, 13, 'Acajutla');
INSERT INTO municipio  VALUES (225, 13, 'Armenia');
INSERT INTO municipio  VALUES (226, 13, 'Caluco');
INSERT INTO municipio  VALUES (227, 13, 'Cuisnahuat');
INSERT INTO municipio  VALUES (228, 13, 'Izalco');
INSERT INTO municipio  VALUES (229, 13, 'Juayúa');
INSERT INTO municipio  VALUES (230, 13, 'Nahuizalco');
INSERT INTO municipio  VALUES (231, 13, 'Nahulingo');
INSERT INTO municipio  VALUES (232, 13, 'Salcoatitán');
INSERT INTO municipio  VALUES (233, 13, 'San Antonio del Monte');
INSERT INTO municipio  VALUES (234, 13, 'San Julián');
INSERT INTO municipio  VALUES (235, 13, 'Santa Catarina Masahuat');
INSERT INTO municipio  VALUES (236, 13, 'Santa Isabel Ishuatán');
INSERT INTO municipio  VALUES (237, 13, 'Santo Domingo');
INSERT INTO municipio  VALUES (238, 13, 'Sonsonate');
INSERT INTO municipio  VALUES (239, 13, 'Sonzacate');
INSERT INTO municipio  VALUES (240, 14, 'Alegría');
INSERT INTO municipio  VALUES (241, 14, 'Berlín');
INSERT INTO municipio  VALUES (242, 14, 'California');
INSERT INTO municipio  VALUES (243, 14, 'Concepción Batres');
INSERT INTO municipio  VALUES (244, 14, 'El Triunfo');
INSERT INTO municipio  VALUES (245, 14, 'Ereguayquín');
INSERT INTO municipio  VALUES (246, 14, 'Estanzuelas');
INSERT INTO municipio  VALUES (247, 14, 'Jiquilisco');
INSERT INTO municipio  VALUES (248, 14, 'Jucuapa');
INSERT INTO municipio  VALUES (249, 14, 'Jucuarán');
INSERT INTO municipio  VALUES (250, 14, 'Mercedes Umaña');
INSERT INTO municipio  VALUES (251, 14, 'Nueva Granada');
INSERT INTO municipio  VALUES (252, 14, 'Ozatlán');
INSERT INTO municipio  VALUES (253, 14, 'Puerto El Triunfo');
INSERT INTO municipio  VALUES (254, 14, 'San Agustín');
INSERT INTO municipio  VALUES (255, 14, 'San Buenaventura');
INSERT INTO municipio  VALUES (256, 14, 'San Dionisio');
INSERT INTO municipio  VALUES (257, 14, 'San Francisco Javier');
INSERT INTO municipio  VALUES (258, 14, 'Santa Elena');
INSERT INTO municipio  VALUES (259, 14, 'Santa María');
INSERT INTO municipio  VALUES (260, 14, 'Santiago de María');
INSERT INTO municipio  VALUES (261, 14, 'Tecapán');
INSERT INTO municipio  VALUES (262, 14, 'Usulután');

INSERT INTO `accion` (`ID_ACCION`, `ACCION`) VALUES
(1, 'INGRESAR');
INSERT INTO `accion` (`ID_ACCION`, `ACCION`) VALUES

(2, 'ACTUALIZAR');
INSERT INTO `accion` (`ID_ACCION`, `ACCION`) VALUES
(3, 'CONSULTAR');
INSERT INTO `accion` (`ID_ACCION`, `ACCION`) VALUES
(4, 'ELIMINAR');
INSERT INTO `accion` (`ID_ACCION`, `ACCION`) VALUES
(5, 'LOGIN');
INSERT INTO `accion` (`ID_ACCION`, `ACCION`) VALUES
(6, 'LOGOUT');
INSERT INTO `accion` (`ID_ACCION`, `ACCION`) VALUES(7, 'REPORTE');

INSERT INTO facultad VALUES (1, 'Jurisprudencia y Ciencias Sociales');
INSERT INTO facultad VALUES (2, 'Ingeniería y Arquitectura');
INSERT INTO facultad VALUES (3, 'Medicina');
INSERT INTO facultad VALUES (4, 'Odontología');
INSERT INTO facultad VALUES (5, 'Multidisciplinaria Paracentral');
INSERT INTO facultad VALUES (6, 'Multidisciplinaria Oriental');
INSERT INTO facultad VALUES (7, 'Multidisciplinaria de Occidente');
INSERT INTO facultad VALUES (8, 'Química y Farmacia');
INSERT INTO facultad VALUES (9, 'Ciencias Agronómicas');
INSERT INTO facultad VALUES (10, 'Ciencias y Humanidades');
INSERT INTO facultad VALUES (11, 'Ciencias Naturales Matemática');
INSERT INTO facultad VALUES (12, 'Ciencias Económicas');
INSERT INTO facultad VALUES (13, 'Administrativo');

INSERT INTO tipo_usuario  VALUES (1, 'Candidato', 'Profesional que puede optar por una beca.');
INSERT INTO tipo_usuario  VALUES (2, 'Becario', 'Profesional que tras un proceso de selección se le concedió una beca y está cursando actualmente el proceso.');
INSERT INTO tipo_usuario  VALUES (3, 'Comisión de beca de una facultad', 'Entidad encargada de velar por todo lo referente a las becas de la facultad.');
INSERT INTO tipo_usuario  VALUES (4, 'Junta Directiva de una Facultad', 'Entidad superior de una facultad que decide sobre el otorgamiento de becas tras recibir la propuesta de la Comisión de Becas de dicha facultad.');
INSERT INTO tipo_usuario  VALUES (5, 'Consejo superior universitario', 'Entidad superior de la Universidad de El Salvador encargada de dictar resoluciones pertinentes para el cumplimiento de las leyes y reglamentos universitarios.');
INSERT INTO tipo_usuario  VALUES (6, 'Fiscalía', 'Entidad encargada de asesorar y dar garantía a los contratos de becas con los becarios.');
INSERT INTO tipo_usuario  VALUES (7, 'Colaborador del consejo de becas', 'Delegado del Consejo de Becas para apoyar en las actividades de dicha organización.');
INSERT INTO tipo_usuario  VALUES (8, 'Director/a del consejo de becas', 'Autoridad superior del Consejo de Becas y que monitorea las becas de postgrado.');
INSERT INTO tipo_usuario  VALUES (9, 'Administrador del sistema', 'Realiza funciones de gestión de usuarios y revisión de bitácoras del sistema.');
INSERT INTO tipo_usuario  VALUES (10, 'Inactivo o anónimo', 'Este rol se define para los usuarios del sistema que ya no tienen acceso al mismo.');

insert  into `usuario`(`ID_USUARIO`,`ID_TIPO_USUARIO`,`NOMBRE_USUARIO`,`CLAVE`) values (1,1,'GM16001','GM16001'),(2,7,'LP16002','LP16002'),(3,2,'MM16003','MM16003'),(4,2,'MM16004','MM16004'),(5,2,'LP16005','LP16005'),(6,3,'HP16006','HP16006'),(7,4,'RR16007','RR16007'),(8,2,'MR16008','MR16008'),(9,4,'PL16009','PL16009'),(10,4,'MM16010','MM16010'),(11,3,'CV16011','CV16011'),(12,5,'GS16012','GS16012'),(13,6,'ES16013','ES16013'),(14,8,'PP16014','PP16014'),(15,9,'CM16015','CM16015');

insert  into `detalle_usuario`(`ID_DETALLE_USUARIO`,`ID_USUARIO`,`ID_MUNICIPIO`,`ID_FACULTAD`,`ID_MUNICIPIO_NACIMIENTO`,`CARNET`,`NOMBRE1_DU`,`NOMBRE2_DU`,`APELLIDO1_DU`,`APELLIDO2_DU`,`DEPARTAMENTO`,`FECHA_NACIMIENTO`,`PROFESION`,`FECHA_CONTRATACION`,`TELEFONO_MOVIL`,`TELEFONO_CASA`,`TELEFONO_OFICINA`) values (1,1,NULL,2,NULL,'GM16001','Oscar','Darío','González','Muríllo',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,2,NULL,12,NULL,'LP16002','Germán','Antonio','Lotero','Paz',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,3,NULL,12,NULL,'MM16003','Carlos','Alberto','Moreno','Moreno',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,4,NULL,8,NULL,'MM16004','Arturo','Tabares','Moreno','Mora',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,5,NULL,9,NULL,'LP16005','Maria','José','Lara','Paz',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,6,NULL,2,NULL,'HP16006','karla','Marina','Hurtado','Paz',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,7,NULL,2,NULL,'RR16007','Julio','Cesar','Rodas','Rodas',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,8,NULL,2,NULL,'MR16008','Luis','Guillermo','Moreno','Rodas',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,9,NULL,4,NULL,'PL16009','Carlos ','David','paz','Linares',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,10,NULL,7,NULL,'MM16010','Roberto','David','Molina','Molina',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,11,NULL,9,NULL,'CV16011','Delmy','Victoria','Correa','Silva',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,12,NULL,13,NULL,'GS16012','Fabio','Alexander','García','Silva',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,13,NULL,13,NULL,'ES16013','Luis','Anibal','Escobar','Silva',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(14,14,NULL,13,NULL,'PP16014','Lida','Patricia','Pineda','Pineda',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(15,15,NULL,13,NULL,'CM16015','Julio ','Cesar','Castro','Monsalve',NULL,NULL,NULL,NULL,NULL,NULL,NULL);


