
-- ================================================================
-- CICLO 1: Tablas
-- ================================================================

CREATE TABLE SECTORES(
    nombre VARCHAR(100) NOT NULL
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
        REFERENCES COMPETENCIAS(codigo),
    ADD CONSTRAINT fk_cs_sector FOREIGN KEY (sector)
        REFERENCES SECTORES(nombre);

ALTER TABLE PROFESIONALES
    ADD CONSTRAINT fk_prof_sector FOREIGN KEY (sector)
        REFERENCES SECTORES(nombre),
    ADD CONSTRAINT fk_prof_comp FOREIGN KEY (competencia)
        REFERENCES COMPETENCIAS(codigo);

ALTER TABLE ACTUA
    ADD CONSTRAINT fk_actua_fund FOREIGN KEY (fundacion)
        REFERENCES FUNDACIONES(correo),
    ADD CONSTRAINT fk_actua_sector FOREIGN KEY (sector)
        REFERENCES SECTORES(nombre);

ALTER TABLE VALIDACIONES
    ADD CONSTRAINT fk_val_prof FOREIGN KEY (profesional)
        REFERENCES PROFESIONALES(correo),
    ADD CONSTRAINT fk_val_comp FOREIGN KEY (competencia)
        REFERENCES COMPETENCIAS(codigo),
    ADD CONSTRAINT fk_val_perf FOREIGN KEY (perfil)
        REFERENCES PERFILES(correo);

ALTER TABLE ERRORES
    ADD CONSTRAINT fk_err_val FOREIGN KEY (validacion)
        REFERENCES VALIDACIONES(numero),
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
        REFERENCES ERRORES(id),
    ADD CONSTRAINT fk_notif_perf FOREIGN KEY (perfil)
        REFERENCES PERFILES(correo);

ALTER TABLE LOGROS
    ADD CONSTRAINT fk_logros_prof FOREIGN KEY (profesional)
        REFERENCES PROFESIONALES(correo);

ALTER TABLE PERFILSIGUEPERFIL
    ADD CONSTRAINT fk_psp_perfil FOREIGN KEY (perfil)
        REFERENCES PERFILES(correo),
    ADD CONSTRAINT fk_psp_seguido FOREIGN KEY (seguido)
        REFERENCES PERFILES(correo);

ALTER TABLE PROFESIONALCOMPETENCIA
    ADD CONSTRAINT fk_pc_prof FOREIGN KEY (profesional)
        REFERENCES PROFESIONALES(correo),
    ADD CONSTRAINT fk_pc_comp FOREIGN KEY (competencia)
        REFERENCES COMPETENCIAS(codigo);

ALTER TABLE EVIDENCIASVALIDACION
    ADD CONSTRAINT fk_ev_valid FOREIGN KEY (validacion)
        REFERENCES VALIDACIONES(numero);


-- CICLO 1: Atributos
ALTER TABLE FUNDACIONES
    ADD CONSTRAINT ck_tamano CHECK tamano IN ('0-50' ,'50-100' , '100+');

ALTER TABLE FUNDACIONES
    ADD CONSTRAINT ck_ano CHECK ano > 1899;

ALTER TABLE FUNDACIONES
    ADD CONSTRAINT ck_propuesta CHECK propuesta LIKE('%.%.%') AND( propuesta LIKE('%.pdf') or propuesta LIKE('%.html'));

ALTER TABLE PERFILES
    ADD CONSTRAINT ck_correo CHECK (correo LIKE  "%@%" and correo NOT LIKE "%@hotmail.com" AND correo NOT LIKE '%@yahoo.com' AND correo NOT LIKE '%@gmail.com');

ALTER TABLE PERFILES
    ADD CONSTRAINT ck_nombre CHECK nombre LIKE '% %';

ALTER TABLE LOGROS
    ADD CONSTRAINT ck_categoria CHECK categoria IN ('P','R','I');

ALTER TABLE VALIDACIONES
    ADD CONSTRAINT ck_numero CHECK (numero BETWEEN 1 AND 99999);

ALTER TABLE VALIDACIONES
    ADD CONSTRAINT ck_justificacion CHECK LENGTH(justificacion) > 5;

ALTER TABLE VALIDACIONES
    ADD CONSTRAINT ck_evidencias CHECK evidencias LIKE('%.%.%') AND( evidencias LIKE('%.pdf') or evidencias LIKE('%.html'));

ALTER TABLE VALIDACIONES
    ADD CONSTRAINT ck_estado CHECK estado IN('E','T','A');

ALTER TABLE ERRORES
    ADD CONSTRAINT ck_operacion CHECK operacion IN('Insert','Update','Delete','Select');

ALTER TABLE ERRORES
    ADD CONSTRAINT ck_severidad CHECK severidad IN('informativo','advertencia','crítico')

ALTER TABLE EVIDENCIAS
    ADD CONSTRAINT ck_tipo CHECK tipo IN('log','archivo','Descripción técnica')



-- ================================================================
-- CICLO 1: CRUD - REGISTRAR VALIDACIÓN
-- ================================================================

-- Evitar valoraciones repetidas del mismo perfil sobre la misma competencia
ALTER TABLE VALIDACIONES
    ADD CONSTRAINT uq_validacion UNIQUE (perfil, competencia);

-- Trigger: asignar número, fecha y estado automáticamente al insertar

CREATE TRIGGER trg_insert_validacion
BEFORE INSERT ON VALIDACIONES
FOR EACH ROW
BEGIN
    DECLARE next_num INT;
    SELECT IFNULL(MAX(numero), 0) + 1 INTO next_num FROM VALIDACIONES;
    SET NEW.numero = next_num;
    SET NEW.fecha = NOW();
    SET NEW.estado = 'E'; -- E = En proceso
END;

-- Trigger: verificar que el perfil que valida pertenezca a la red del evaluado

CREATE TRIGGER trg_validacion_red
BEFORE INSERT ON VALIDACIONES
FOR EACH ROW
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count
    FROM PERFILSIGUEPERFIL
    WHERE perfil = NEW.perfil
      AND seguido = NEW.profesional;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El perfil que valida no pertenece a la red del evaluado.';
    END IF;
END;

-- Trigger: solo permitir modificar justificación, evidencias o estado si está en proceso

CREATE TRIGGER trg_validacion_modificar
BEFORE UPDATE ON VALIDACIONES
FOR EACH ROW
BEGIN
    IF OLD.estado <> 'E' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Solo se puede modificar si la validación está en proceso.';
    END IF;
END;
//

-- Trigger: controlar paso a estado terminada

CREATE TRIGGER trg_validacion_terminar
BEFORE UPDATE ON VALIDACIONES
FOR EACH ROW
BEGIN
    DECLARE v_evidencias INT;

    -- Verifica condiciones para pasar a estado 'T'
    IF NEW.estado = 'T' AND OLD.estado = 'E' THEN
        SELECT COUNT(*) INTO v_evidencias
        FROM EVIDENCIASVALIDACION
        WHERE validacion = OLD.numero;

        IF (OLD.justificacion IS NULL OR v_evidencias = 0) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Para terminar la validación se requiere justificación y al menos una evidencia.';
        END IF;
    END IF;
END;

-- Trigger: anular validación (solo si está terminada, y luego no cambia más)

CREATE TRIGGER trg_validacion_anular
BEFORE UPDATE ON VALIDACIONES
FOR EACH ROW
BEGIN
    -- Solo puede anularse si está terminada
    IF NEW.estado = 'A' AND OLD.estado <> 'T' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Solo se puede anular una validación terminada.';
    END IF;

    -- Una vez anulada, no puede cambiar más su estado
    IF OLD.estado = 'A' AND NEW.estado <> 'A' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede modificar una validación anulada.';
    END IF;
END;

-- ================================================================
-- CICLO 1: CRUD - VALIDACIONES
-- TuplasOK / TuplasNoOK / Acciones / Disparadores
-- ================================================================

-- TuplasOK:


INSERT INTO PERFILSIGUEPERFIL (perfil, seguido)
VALUES ('p1@edu.co','pro1@edu.co');


INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia)
VALUES (1, NOW(), 'Validación completa del perfil', 'documento.pdf', 'E', 'p1@edu.co', 'pro1@edu.co', 1);

--TuplasNoOK:


-- Error: justificación demasiado corta
INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia)
VALUES (2, NOW(), 'OK', 'prueba.pdf', 'E', 'p1@edu.co', 'pro1@edu.co', 1);
-- NoOK: Violación de ck_justificacion.

-- Error: formato de evidencia no válido
INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia)
VALUES (3, NOW(), 'Evidencia completa', 'captura.png', 'E', 'p1@edu.co', 'pro1@edu.co', 1);
-- NoOK: Violación de ck_evidencias.

--Acciones:
ALTER TABLE EVIDENCIASVALIDACION
    DROP FOREIGN KEY fk_ev_valid,
    ADD CONSTRAINT fk_ev_valid FOREIGN KEY (validacion)
        REFERENCES VALIDACIONES(numero)
        ON DELETE CASCADE
        ON UPDATE CASCADE;

--AccionesOK

-- Insertar evidencia asociada a una validación existente
INSERT INTO EVIDENCIASVALIDACION (validacion, evidencia)
VALUES (1, 'Informe_prueba.pdf');

-- Eliminar la validación 1
DELETE FROM VALIDACIONES WHERE numero = 1;
-- OK: La evidencia asociada se elimina automáticamente (ON DELETE CASCADE).


--DisparadoresOK

-- Insertar una validación válida (el perfil pertenece a la red)
INSERT INTO VALIDACIONES (justificacion, evidencias, perfil, profesional, competencia)
VALUES ('Evaluación técnica completa', 'evidencia.pdf', 'p1@edu.co', 'pro1@edu.co', 1);
-- OK: Se asigna número, fecha y estado automáticamente.


--DisparadoresnoOK

-- Caso 1: El perfil no pertenece a la red del evaluado
INSERT INTO VALIDACIONES (justificacion, evidencias, perfil, profesional, competencia)
VALUES ('Evaluación no permitida', 'evidencia.pdf', 'p2@edu.co', 'pro1@edu.co', 1);
-- NoOK: Disparador trg_validacion_red impide la inserción.

-- Caso 2: Intentar modificar una validación terminada
UPDATE VALIDACIONES
SET estado = 'T'
WHERE numero = 1;
-- NoOK: Disparador trg_validacion_modificar bloquea la actualización si no está “E”.

--XDisparadores

DROP TRIGGER IF EXISTS trg_insert_validacion;
DROP TRIGGER IF EXISTS trg_validacion_red;
DROP TRIGGER IF EXISTS trg_validacion_modificar;
DROP TRIGGER IF EXISTS trg_validacion_terminar;
DROP TRIGGER IF EXISTS trg_validacion_anular;
