
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
