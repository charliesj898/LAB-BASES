
SELECT * FROM mbda.data;
SELECT * FROM mbda.data WHERE RAZON = 'Casino';
INSERT INTO mbda.DATA(CORREO, RAZON, CIUDAD, PAIS, TAMA_O, PROPUESTA, A_0, PROYECTOS, SECTOR)
VALUES ('carlos.sanchez-j@mail.escuelaing.edu.co', 'Casino', 'Cogua', 'Colombia', 1992, 'casino.gov/adipiscing/lorem.pdf', 1492, 999992, 'Entretenimiento');

INSERT INTO mbda.DATA(CORREO, RAZON, CIUDAD, PAIS, TAMA_O, PROPUESTA, A_0, PROYECTOS, SECTOR)
VALUES ('juan.gaitan-p@mail.escuelaing.edu.co', 'Casino', 'Cogua', 'Colombia', 1992, 'casino.gov/adipiscing/lorem.pdf', 1492, 999992, 'Entretenimiento');

commit;

DELETE FROM mbda.data WHERE correo ='carlos.sanchez-j@mail.escuelaing.edu.co';


INSERT INTO FUNDACIONES (CORREO, TAMANO, PROPUESTA, CIUDAD, ANO)
SELECT DISTINCT
    CORREO,
    CASE
        WHEN TAMA_O BETWEEN 0 AND 50 THEN '0-50'
        WHEN TAMA_O BETWEEN 51 AND 100 THEN '50-100'
        WHEN TAMA_O > 100 THEN '100+'
    END AS TAMANO,
    
    --- PROPUESTA ---
    CASE
        -- Si trae carpetas, extraemos solo el nombre final
        WHEN PROPUESTA LIKE '%/%' THEN
            CASE
                WHEN LOWER(PROPUESTA) LIKE '%.xml' THEN
                    REGEXP_REPLACE(
                        REGEXP_SUBSTR(PROPUESTA, '[^/]+$'),
                        '\.[^.]+$',
                        '.html'
                    )
                WHEN LOWER(PROPUESTA) LIKE '%.pdf' OR LOWER(PROPUESTA) LIKE '%.html' THEN
                    REGEXP_SUBSTR(PROPUESTA, '[^/]+$')
                ELSE
                    REGEXP_REPLACE(
                        REGEXP_SUBSTR(PROPUESTA, '[^/]+$'),
                        '\.[^.]+$',
                        '.pdf'
                    )
            END
        -- Si NO trae carpetas
        ELSE
            CASE
                WHEN LOWER(PROPUESTA) LIKE '%.xml' THEN
                    REGEXP_REPLACE(PROPUESTA, '\.[^.]+$', '.html')
                WHEN LOWER(PROPUESTA) LIKE '%.pdf' OR LOWER(PROPUESTA) LIKE '%.html' THEN
                    PROPUESTA
                ELSE
                    REGEXP_REPLACE(PROPUESTA, '\.[^.]+$', '.pdf')
            END
    END AS PROPUESTA_CORREGIDA,

    CIUDAD,

    CASE
        WHEN A_0 < 1900 THEN 1900 
        ELSE A_0
    END AS ANO

FROM mbda.DATA
WHERE PROPUESTA LIKE '%.%.%';


INSERT INTO PERFILES (correo, nombre, pais)
SELECT DISTINCT
    CORREO,
    RAZON,
    PAIS
FROM mbda.DATA;

INSERT INTO ACTUA (fundacion, sector, proyectos)
SELECT DISTINCT
    CORREO,
    SECTOR,
    PROYECTOS
FROM mbda.DATA
WHERE SECTOR IS NOT NULL;


-- =======================
-- XCRUD
-- ========================

CREATE OR REPLACE PACKAGE PK_VALIDACIONES AS
    PROCEDURE insertar_validacion(
        p_perfil VARCHAR2,
        p_profesional VARCHAR2,
        p_competencia NUMBER,
        p_justificacion VARCHAR2,
        p_evidencias VARCHAR2
    );

    PROCEDURE actualizar_validacion(
        p_numero NUMBER,
        p_justificacion VARCHAR2,
        p_evidencias VARCHAR2,
        p_estado CHAR
    );

    PROCEDURE eliminar_validacion(
        p_numero NUMBER
    );

    FUNCTION obtener_validacion(
        p_numero NUMBER
    ) RETURN SYS_REFCURSOR;

    FUNCTION listar_validaciones_por_perfil(
        p_perfil VARCHAR2
    ) RETURN SYS_REFCURSOR;

    FUNCTION listar_validaciones_por_profesional(
        p_profesional VARCHAR2
    ) RETURN SYS_REFCURSOR;

    PROCEDURE agregar_evidencia(
        p_validacion NUMBER,
        p_evidencia VARCHAR2
    );

    PROCEDURE eliminar_evidencia(
        p_validacion NUMBER,
        p_evidencia VARCHAR2
    );
END PK_VALIDACIONES;
/

-- =======================
-- CRUDI
-- ========================



CREATE OR REPLACE PACKAGE BODY PK_VALIDACIONES AS

    ------------------------------------------------------------------
    -- INSERTAR VALIDACIÓN
    ------------------------------------------------------------------
    PROCEDURE insertar_validacion(
        p_perfil VARCHAR2,
        p_profesional VARCHAR2,
        p_competencia NUMBER,
        p_justificacion VARCHAR2,
        p_evidencias VARCHAR2
    ) IS
        v_num NUMBER;
    BEGIN
        -- Inserción SIN número (lo asigna el trigger)
        INSERT INTO VALIDACIONES(numero, fecha, justificacion, evidencias,
                                  estado, perfil, profesional, competencia)
        VALUES (NULL, NULL, p_justificacion, p_evidencias, NULL,
                p_perfil, p_profesional, p_competencia);

        -- Obtener número asignado
        SELECT MAX(numero) INTO v_num FROM VALIDACIONES;

    -- Se elimina el bloque EXCEPTION con registrar_error
    END insertar_validacion;

    ------------------------------------------------------------------
    -- ACTUALIZAR VALIDACIÓN
    ------------------------------------------------------------------
    PROCEDURE actualizar_validacion(
        p_numero NUMBER,
        p_justificacion VARCHAR2,
        p_evidencias VARCHAR2,
        p_estado CHAR
    ) IS
    BEGIN
        UPDATE VALIDACIONES
        SET justificacion = COALESCE(p_justificacion, justificacion),
            evidencias    = COALESCE(p_evidencias, evidencias),
            estado        = p_estado
        WHERE numero = p_numero;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20010, 'La validación no existe.');
        END IF;

    -- Se elimina el bloque EXCEPTION con registrar_error
    END actualizar_validacion;

    ------------------------------------------------------------------
    -- ELIMINAR VALIDACIÓN
    ------------------------------------------------------------------
    PROCEDURE eliminar_validacion(
        p_numero NUMBER
    ) IS
    BEGIN
        DELETE FROM VALIDACIONES WHERE numero = p_numero;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20011, 'La validación no existe.');
        END IF;
    END eliminar_validacion;
    
    ------------------------------------------------------------------
    -- OBTENER VALIDACIÓN
    ------------------------------------------------------------------
    FUNCTION obtener_validacion(
        p_numero NUMBER
    ) RETURN SYS_REFCURSOR IS
        rc SYS_REFCURSOR;
    BEGIN
        OPEN rc FOR
            SELECT *
            FROM VALIDACIONES
            WHERE numero = p_numero;
        RETURN rc;
    END obtener_validacion;

    ------------------------------------------------------------------
    -- LISTAR VALIDACIONES POR PERFIL
    ------------------------------------------------------------------
    FUNCTION listar_validaciones_por_perfil(
        p_perfil VARCHAR2
    ) RETURN SYS_REFCURSOR IS
        rc SYS_REFCURSOR;
    BEGIN
        OPEN rc FOR
            SELECT *
            FROM VALIDACIONES
            WHERE perfil = p_perfil
            ORDER BY fecha DESC;
        RETURN rc;
    END listar_validaciones_por_perfil;
    
    ------------------------------------------------------------------
    -- LISTAR VALIDACIONES POR PROFESIONAL
    ------------------------------------------------------------------
    FUNCTION listar_validaciones_por_profesional(
        p_profesional VARCHAR2
    ) RETURN SYS_REFCURSOR IS
        rc SYS_REFCURSOR;
    BEGIN
        OPEN rc FOR
            SELECT *
            FROM VALIDACIONES
            WHERE profesional = p_profesional
            ORDER BY fecha DESC;
        RETURN rc;
    END listar_validaciones_por_profesional;

    ------------------------------------------------------------------
    -- AGREGAR EVIDENCIA
    ------------------------------------------------------------------
    PROCEDURE agregar_evidencia(
        p_validacion NUMBER,
        p_evidencia VARCHAR2
    ) IS
    BEGIN
        INSERT INTO EVIDENCIASVALIDACION (validacion, evidencia)
        VALUES (p_validacion, p_evidencia);
        
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN 
            RAISE_APPLICATION_ERROR(-20012, 'La evidencia ' || p_evidencia || ' ya está registrada para la validación ' || p_validacion || '.');
        WHEN OTHERS THEN
            RAISE;
    END agregar_evidencia;

    ------------------------------------------------------------------
    -- ELIMINAR EVIDENCIA
    ------------------------------------------------------------------
    PROCEDURE eliminar_evidencia(
        p_validacion NUMBER,
        p_evidencia VARCHAR2
    ) IS
    BEGIN
        DELETE FROM EVIDENCIASVALIDACION
        WHERE validacion = p_validacion
          AND evidencia = p_evidencia;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20013, 'La evidencia ' || p_evidencia || ' no existe para la validación ' || p_validacion || '.');
        END IF;
    END eliminar_evidencia;

END PK_VALIDACIONES;
/





-- =======================
-- CRUDOK
-- =======================

BEGIN
  PK_VALIDACIONES.insertar_validacion(
    p_perfil        => 'PERF001',
    p_profesional   => 'PROF001',
    p_competencia   => 10,
    p_justificacion => 'Cumple criterios',
    p_evidencias    => 'ruta1.pdf'
  );
END;
/
 
BEGIN
  PK_VALIDACIONES.listar_validaciones_por_perfil(
    p_perfil => 'PERF001'
  );
END;
/
 
BEGIN
  PK_VALIDACIONES.agregar_evidencia(
    p_validacion => 1,
    p_evidencia  => 'evidencia_foto.jpg'
  );
END;
/

BEGIN
  PK_VALIDACIONES.actualizar_validacion(
    p_numero        => 1,
    p_justificacion => 'Actualizada',
    p_evidencias    => 'ruta_modificada.pdf',
    p_estado        => 'A'
  );
END;
/
 
BEGIN
  PK_VALIDACIONES.eliminar_validacion(1);
END;
/

-- =======================
-- CRUD NO OK
-- =======================

BEGIN
  PK_VALIDACIONES.insertar_validacion(
    p_perfil        => 'PERF001',
    p_profesional   => 'PROF001',
    p_competencia   => 999,   -- no existe
    p_justificacion => 'Algo',
    p_evidencias    => 'x.pdf'
  );
END;
/
-- Violación de FK hacia COMPETENCIAS.

BEGIN
  PK_VALIDACIONES.actualizar_validacion(
    p_numero        => 1,
    p_justificacion => 'Test',
    p_evidencias    => 'doc.pdf',
    p_estado        => 'X'   -- valor no permitido por CHECK
  );
END;
/
-- CHECK del atributo 'estado' falla.

BEGIN
  PK_VALIDACIONES.agregar_evidencia(
    p_validacion => 1,
    p_evidencia  => 'evidencia_foto.jpg'
  );
END;
/
-- PK compuesta (validacion, evidencia) falla si ya existe.




-- ==============================================
-- ACTORESE — Especificación de actores
-- ==============================================

-- ==============================================
-- Paquete del actor: USUARIO
-- ==============================================
CREATE OR REPLACE PACKAGE PA_USUARIO AS
    -- Registrar una nueva validación
    PROCEDURE insertar_validacion(
        p_perfil VARCHAR2,
        p_profesional VARCHAR2,
        p_competencia NUMBER,
        p_justificacion VARCHAR2,
        p_evidencias VARCHAR2
    );

    -- Consultar una validación por número
    FUNCTION consultar_validacion(
        p_numero NUMBER
    ) RETURN SYS_REFCURSOR;
    
    -- Listar las validaciones hechas por un perfil (el mismo usuario)
    FUNCTION listar_validaciones_por_perfil(
        p_perfil VARCHAR2
    ) RETURN SYS_REFCURSOR;

    -- Registrar evidencias a una validación existente
    PROCEDURE registrar_evidencia(
        p_validacion NUMBER,
        p_evidencia VARCHAR2
    );

END PA_USUARIO;
/
--------------------------------------------------

-- ==============================================
-- Paquete del actor: MIEMBRO DE JUNTA
-- ==============================================
CREATE OR REPLACE PACKAGE PA_JUNTA AS
    
    -- Consultar una validación por número
    FUNCTION consultar_validacion(
        p_numero NUMBER
    ) RETURN SYS_REFCURSOR;

    -- Listar validaciones por profesional evaluado
    FUNCTION listar_validaciones_por_profesional(
        p_profesional VARCHAR2
    ) RETURN SYS_REFCURSOR;

    -- Cambiar estado de una validación (terminar o anular)
    PROCEDURE mantener_estado_validacion(
        p_numero NUMBER,
        p_estado CHAR
    );

END PA_JUNTA;
/


-- ==============================================
-- ACTORESI — Implementación de actores
-- ==============================================

-- ==============================================
-- IMPLEMENTACIÓN PA_USUARIO
-- ==============================================
CREATE OR REPLACE PACKAGE BODY PA_USUARIO AS

    FUNCTION consultar_validacion(
        p_numero NUMBER
    ) RETURN SYS_REFCURSOR IS
        rc SYS_REFCURSOR;
    BEGIN
        rc := PK_VALIDACIONES.obtener_validacion(p_numero);
        RETURN rc;
    END consultar_validacion;



    FUNCTION listar_validaciones_por_perfil(
        p_perfil VARCHAR2
    ) RETURN SYS_REFCURSOR IS
        rc SYS_REFCURSOR;
    BEGIN
        rc := PK_VALIDACIONES.listar_validaciones_por_perfil(p_perfil);
        RETURN rc;
    END listar_validaciones_por_perfil;



    PROCEDURE registrar_evidencia(
        p_validacion NUMBER,
        p_evidencia VARCHAR2
    ) IS
    BEGIN
        PK_VALIDACIONES.agregar_evidencia(
            p_validacion => p_validacion,
            p_evidencia => p_evidencia
        );
    END registrar_evidencia;

PROCEDURE insertar_validacion(
        p_perfil VARCHAR2,
        p_profesional VARCHAR2,
        p_competencia NUMBER,
        p_justificacion VARCHAR2,
        p_evidencias VARCHAR2
    ) IS
    BEGIN
        -- Delega la inserción al paquete central CRUDI
        PK_VALIDACIONES.insertar_validacion(
            p_perfil        => p_perfil,
            p_profesional   => p_profesional,
            p_competencia   => p_competencia,
            p_justificacion => p_justificacion,
            p_evidencias    => p_evidencias
        );
    END insertar_validacion;

END PA_USUARIO;
/
--------------------------------------------------


-- ==============================================
-- IMPLEMENTACIÓN PA_JUNTA
-- ==============================================
CREATE OR REPLACE PACKAGE BODY PA_JUNTA AS

    FUNCTION consultar_validacion(
        p_numero NUMBER
    ) RETURN SYS_REFCURSOR IS
        rc SYS_REFCURSOR;
    BEGIN
        rc := PK_VALIDACIONES.obtener_validacion(p_numero);
        RETURN rc;
    END consultar_validacion;



    FUNCTION listar_validaciones_por_profesional(
        p_profesional VARCHAR2
    ) RETURN SYS_REFCURSOR IS
        rc SYS_REFCURSOR;
    BEGIN
        rc := PK_VALIDACIONES.listar_validaciones_por_profesional(p_profesional);
        RETURN rc;
    END listar_validaciones_por_profesional;



    PROCEDURE mantener_estado_validacion(
        p_numero NUMBER,
        p_estado CHAR
    ) IS
    BEGIN
        PK_VALIDACIONES.actualizar_validacion(
            p_numero        => p_numero,
            p_justificacion => NULL,
            p_evidencias    => NULL,
            p_estado        => p_estado
        );
    END mantener_estado_validacion;

END PA_JUNTA;
/


