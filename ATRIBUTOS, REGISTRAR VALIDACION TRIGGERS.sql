-- CICLO 1: Atributos
ALTER TABLE FUNDACIONES
    ADD CONSTRAINT ck_tamano CHECK (tamano IN ('0-50' ,'50-100' , '100+'));

ALTER TABLE FUNDACIONES
    ADD CONSTRAINT ck_ano CHECK (ano > 1899);

ALTER TABLE FUNDACIONES
    ADD CONSTRAINT ck_propuesta CHECK (propuesta LIKE('%.%.%') AND( propuesta LIKE('%.pdf') or propuesta LIKE('%.html')));

ALTER TABLE PERFILES
    ADD CONSTRAINT ck_correo CHECK (correo LIKE  "%@%" and correo NOT LIKE "%@hotmail.com" AND correo NOT LIKE '%@yahoo.com' AND correo NOT LIKE '%@gmail.com');

ALTER TABLE PERFILES
    ADD CONSTRAINT ck_nombre CHECK (nombre LIKE '% %');

ALTER TABLE LOGROS
    ADD CONSTRAINT ck_categoria CHECK (categoria IN ('P','R','I'));

ALTER TABLE VALIDACIONES
    ADD CONSTRAINT ck_numero CHECK (numero BETWEEN 1 AND 99999);

ALTER TABLE VALIDACIONES
    ADD CONSTRAINT ck_justificacion CHECK (LENGTH(justificacion) > 5);

ALTER TABLE VALIDACIONES
    ADD CONSTRAINT ck_evidencias CHECK (evidencias LIKE('%.%.%') AND( evidencias LIKE('%.pdf') or evidencias LIKE('%.html')));

ALTER TABLE VALIDACIONES
    ADD CONSTRAINT ck_estado CHECK (estado IN('E','T','A'));

ALTER TABLE ERRORES
    ADD CONSTRAINT ck_operacion CHECK (operacion IN('Insert','Update','Delete','Select'));

ALTER TABLE ERRORES
    ADD CONSTRAINT ck_severidad CHECK (severidad IN('informativo','advertencia','crítico'));

ALTER TABLE EVIDENCIAS
    ADD CONSTRAINT ck_tipo CHECK (tipo IN('log','archivo','Descripción técnica'));



-- ================================================================
-- CICLO 1: CRUD - REGISTRAR VALIDACIÓN
-- ================================================================

-- Evitar valoraciones repetidas del mismo perfil sobre la misma competencia
ALTER TABLE VALIDACIONES
    ADD CONSTRAINT uq_validacion UNIQUE (perfil, competencia);

-- Trigger: asignar número, fecha y estado automáticamente al insertar

CREATE OR REPLACE TRIGGER trg_insert_validacion
BEFORE INSERT ON VALIDACIONES
FOR EACH ROW
DECLARE
    next_num NUMBER;
BEGIN
    SELECT NVL(MAX(numero), 0) + 1
    INTO next_num
    FROM VALIDACIONES;

    :NEW.numero := next_num;
    :NEW.fecha := SYSDATE;
    :NEW.estado := 'E';
END;



-- Trigger: verificar que el perfil que valida pertenezca a la red del evaluado

CREATE OR REPLACE TRIGGER trg_validacion_red
BEFORE INSERT ON VALIDACIONES
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM PERFILSIGUEPERFIL
    WHERE perfil = :NEW.perfil
      AND seguido = :NEW.profesional;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El perfil que valida no pertenece a la red del evaluado.');
    END IF;
END;


-- Trigger: solo permitir modificar justificación, evidencias o estado si está en proceso

CREATE OR REPLACE TRIGGER trg_validacion_modificar
BEFORE UPDATE ON VALIDACIONES
FOR EACH ROW
BEGIN
    IF :OLD.estado <> 'E' THEN
        RAISE_APPLICATION_ERROR(-20002, 'Solo se puede modificar si la validación está en proceso.');
    END IF;
END;



-- Trigger: controlar paso a estado terminada

CREATE OR REPLACE TRIGGER trg_validacion_terminar
BEFORE UPDATE ON VALIDACIONES
FOR EACH ROW
DECLARE
    v_evidencias NUMBER;
BEGIN
    -- Verifica condiciones para pasar a estado 'T'
    IF :NEW.estado = 'T' AND :OLD.estado = 'E' THEN
        SELECT COUNT(*)
        INTO v_evidencias
        FROM EVIDENCIASVALIDACION
        WHERE validacion = :OLD.numero;

        IF (:OLD.justificacion IS NULL OR v_evidencias = 0) THEN
            RAISE_APPLICATION_ERROR(
                -20003,
                'Para terminar la validación se requiere justificación y al menos una evidencia.'
            );
        END IF;
    END IF;
END;


-- Trigger: anular validación (solo si está terminada, y luego no cambia más)

CREATE OR REPLACE TRIGGER trg_validacion_anular
BEFORE UPDATE ON VALIDACIONES
FOR EACH ROW
BEGIN
    -- Solo puede anularse si está terminada
    IF :NEW.estado = 'A' AND :OLD.estado <> 'T' THEN
        RAISE_APPLICATION_ERROR(
            -20004,
            'Solo se puede anular una validación terminada.'
        );
    END IF;

    -- Una vez anulada, no puede cambiar más su estado
    IF :OLD.estado = 'A' AND :NEW.estado <> 'A' THEN
        RAISE_APPLICATION_ERROR(
            -20005,
            'No se puede modificar una validación anulada.'
        );
    END IF;
END;


