
-- ================================================================
-- CICLO 1: Tablas
-- ================================================================

CREATE TABLE SECTORES(
    nombre VARCHAR(10) NOT NULL
);

CREATE TABLE COMPETENCIAS(
    codigo INT NOT NULL,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE COMPETENCIASECTOR(
    competencia INT NOT NULL,
    sector VARCHAR(100) NOT NULL
);

CREATE TABLE PROFESIONALES(
    correo VARCHAR(100) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    pais VARCHAR(10) NOT NULL,
    resumen VARCHAR(255),
    sector VARCHAR(100) NOT NULL,
    competencia INT NOT NULL
);

CREATE TABLE FUNDACIONES(
    correo VARCHAR(100) NOT NULL,
    tamano VARCHAR(10) NOT NULL,
    propuesta VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    ano INT NOT NULL
);

CREATE TABLE ACTUA(
    fundacion VARCHAR(100) NOT NULL,
    sector VARCHAR(100) NOT NULL,
    proyectos INT NOT NULL
);

CREATE TABLE PERFILES(
    correo VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    pais VARCHAR(50) NOT NULL
);

CREATE TABLE VALIDACIONES(
    numero INT NOT NULL,
    fecha DATE NOT NULL,
    justificacion VARCHAR(255),
    evidencias VARCHAR(255),
    estado CHAR(1) NOT NULL,
    perfil VARCHAR(100) NOT NULL,
    profesional VARCHAR(100) NOT NULL,
    competencia INT NOT NULL
);

CREATE TABLE ERRORES(
    id INT NOT NULL,
    mensaje_error VARCHAR(255) NOT NULL,
    fecha_hora DATETIME NOT NULL,
    operacion VARCHAR(20) NOT NULL,
    severidad VARCHAR(20) NOT NULL,
    gran_concepto VARCHAR(100) NOT NULL,
    id_actor_responsable VARCHAR(100) NOT NULL,
    validacion INT NOT NULL
);

CREATE TABLE CRITICO(
    error INT NOT NULL,
    estado VARCHAR(255)
);

CREATE TABLE EVIDENCIAS(
    id_evidencia INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    ruta VARCHAR(200),
    fecha DATE NOT NULL,
    id_error INT NOT NULL
);

CREATE TABLE NOTIFICACIONES(
    id_notificacion INT NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    fecha_envio DATETIME NOT NULL,
    id_error INT NOT NULL,
    perfil VARCHAR(100) NOT NULL
);

CREATE TABLE LOGROS(
    id_logro INT NOT NULL,
    categoria VARCHAR(10) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    editorial VARCHAR(100),
    profesional VARCHAR(100) NOT NULL
);

CREATE TABLE PERFILSIGUEPERFIL(
    perfil VARCHAR(100) NOT NULL,
    seguido VARCHAR(100) NOT NULL
);

CREATE TABLE PROFESIONALCOMPETENCIA(
    profesional VARCHAR(100) NOT NULL,
    competencia INT NOT NULL
);

CREATE TABLE EVIDENCIASVALIDACION(
    validacion INT NOT NULL,
    evidencia VARCHAR(100) NOT NULL
);

-- ================================================================
-- CICLO 1: Primarias
-- ================================================================

ALTER TABLE SECTORES
    ADD CONSTRAINT pk_sectores PRIMARY KEY (nombre);

ALTER TABLE COMPETENCIAS
    ADD CONSTRAINT pk_competencias PRIMARY KEY (codigo);

ALTER TABLE PROFESIONALES
    ADD CONSTRAINT pk_profesionales PRIMARY KEY (correo);

ALTER TABLE FUNDACIONES
    ADD CONSTRAINT pk_fundaciones PRIMARY KEY (correo);

ALTER TABLE ACTUA
    ADD CONSTRAINT pk_actua PRIMARY KEY (fundacion, sector);

ALTER TABLE PERFILES
    ADD CONSTRAINT pk_perfiles PRIMARY KEY (correo);

ALTER TABLE VALIDACIONES
    ADD CONSTRAINT pk_validaciones PRIMARY KEY (numero);

ALTER TABLE ERRORES
    ADD CONSTRAINT pk_errores PRIMARY KEY (id);

ALTER TABLE CRITICO
    ADD CONSTRAINT pk_critico PRIMARY KEY (error);

ALTER TABLE EVIDENCIAS
    ADD CONSTRAINT pk_evidencias PRIMARY KEY (id_evidencia);

ALTER TABLE NOTIFICACIONES
    ADD CONSTRAINT pk_notificaciones PRIMARY KEY (id_notificacion);

ALTER TABLE LOGROS
    ADD CONSTRAINT pk_logros PRIMARY KEY (id_logro);

ALTER TABLE PERFILSIGUEPERFIL
    ADD CONSTRAINT pk_perfilsigueperfil PRIMARY KEY (perfil, seguido);

ALTER TABLE PROFESIONALCOMPETENCIA
    ADD CONSTRAINT pk_profesionalcompetencia PRIMARY KEY (profesional, competencia);

ALTER TABLE COMPETENCIASECTOR
    ADD CONSTRAINT pk_competenciasector PRIMARY KEY (competencia, sector);

ALTER TABLE EVIDENCIASVALIDACION
    ADD CONSTRAINT pk_evidenciasvalidacion PRIMARY KEY (validacion, evidencia);

-- ================================================================
-- CICLO 1: Únicas
-- ================================================================

ALTER TABLE FUNDACIONES
    ADD CONSTRAINT uq_fundacion_propuesta UNIQUE (propuesta);

ALTER TABLE NOTIFICACIONES
    ADD CONSTRAINT uq_notif_descripcion UNIQUE (descripcion);

-- ================================================================
-- CICLO 1: Foráneas
-- ================================================================

ALTER TABLE COMPETENCIASECTOR
    ADD CONSTRAINT fk_cs_comp FOREIGN KEY (competencia)
        REFERENCES COMPETENCIAS(codigo);

ALTER TABLE COMPETENCIASECTOR
    ADD CONSTRAINT fk_cs_sector FOREIGN KEY (sector)
        REFERENCES SECTORES(nombre);

ALTER TABLE PROFESIONALES
    ADD CONSTRAINT fk_prof_sector FOREIGN KEY (sector)
        REFERENCES SECTORES(nombre);

ALTER TABLE PROFESIONALES
    ADD CONSTRAINT fk_prof_comp FOREIGN KEY (competencia)
        REFERENCES COMPETENCIAS(codigo);

ALTER TABLE ACTUA
    ADD CONSTRAINT fk_actua_fund FOREIGN KEY (fundacion)
        REFERENCES FUNDACIONES(correo);

ALTER TABLE ACTUA
    ADD CONSTRAINT fk_actua_sector FOREIGN KEY (sector)
        REFERENCES SECTORES(nombre);

ALTER TABLE VALIDACIONES
    ADD CONSTRAINT fk_val_prof FOREIGN KEY (profesional)
        REFERENCES PROFESIONALES(correo);

ALTER TABLE VALIDACIONES
    ADD CONSTRAINT fk_val_comp FOREIGN KEY (competencia)
        REFERENCES COMPETENCIAS(codigo);

ALTER TABLE VALIDACIONES
    ADD CONSTRAINT fk_val_perf FOREIGN KEY (perfil)
        REFERENCES PERFILES(correo);

ALTER TABLE ERRORES
    ADD CONSTRAINT fk_err_val FOREIGN KEY (validacion)
        REFERENCES VALIDACIONES(numero);

ALTER TABLE ERRORES
    ADD CONSTRAINT fk_err_actor FOREIGN KEY (id_actor_responsable)
        REFERENCES PROFESIONALES(correo);

ALTER TABLE CRITICO
    ADD CONSTRAINT fk_critico_error FOREIGN KEY (error)
        REFERENCES ERRORES(id);

ALTER TABLE EVIDENCIAS
    ADD CONSTRAINT fk_evi_error FOREIGN KEY (id_error)
        REFERENCES ERRORES(id);

ALTER TABLE NOTIFICACIONES
    ADD CONSTRAINT fk_notif_error FOREIGN KEY (id_error)
        REFERENCES ERRORES(id);

ALTER TABLE NOTIFICACIONES
    ADD CONSTRAINT fk_notif_perf FOREIGN KEY (perfil)
        REFERENCES PERFILES(correo);

ALTER TABLE LOGROS
    ADD CONSTRAINT fk_logros_prof FOREIGN KEY (profesional)
        REFERENCES PROFESIONALES(correo);

ALTER TABLE PERFILSIGUEPERFIL
    ADD CONSTRAINT fk_psp_perfil FOREIGN KEY (perfil)
        REFERENCES PERFILES(correo);

ALTER TABLE PERFILSIGUEPERFIL
    ADD CONSTRAINT fk_psp_seguido FOREIGN KEY (seguido)
        REFERENCES PERFILES(correo);

ALTER TABLE PROFESIONALCOMPETENCIA
    ADD CONSTRAINT fk_pc_prof FOREIGN KEY (profesional)
        REFERENCES PROFESIONALES(correo);

ALTER TABLE PROFESIONALCOMPETENCIA
    ADD CONSTRAINT fk_pc_comp FOREIGN KEY (competencia)
        REFERENCES COMPETENCIAS(codigo);

ALTER TABLE EVIDENCIASVALIDACION
    ADD CONSTRAINT fk_ev_valid FOREIGN KEY (validacion)
        REFERENCES VALIDACIONES(numero);
