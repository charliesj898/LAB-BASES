
SELECT * FROM mbda.data
SELECT * FROM mbda.data WHERE RAZON = 'Casino';
INSERT INTO mbda.DATA(CORREO, RAZON, CIUDAD, PAIS, TAMA_O, PROPUESTA, A_0, PROYECTOS, SECTOR)
VALUES ('carlos.sanchez-j@mail.escuelaing.edu.co', 'Casino', 'Cogua', 'Colombia', 1992, 'casino.gov/adipiscing/lorem.pdf', 1492, 999992, 'Entretenimiento');

INSERT INTO mbda.DATA(CORREO, RAZON, CIUDAD, PAIS, TAMA_O, PROPUESTA, A_0, PROYECTOS, SECTOR)
VALUES ('juan.gaitan-p@mail.escuelaing.edu.co', 'Casino', 'Cogua', 'Colombia', 1992, 'casino.gov/adipiscing/lorem.pdf', 1492, 999992, 'Entretenimiento');

commit;

DELETE FROM mbda.data WHERE correo ='carlos.sanchez-j@mail.escuelaing.edu.co'


INSERT INTO FUNDACIONES (CORREO, TAMANO, PROPUESTA, CIUDAD, ANO)
SELECT DISTINCT
    CORREO,
    CASE
        WHEN TAMA_O BETWEEN 0 AND 50 THEN '0-50'
        WHEN TAMA_O BETWEEN 51 AND 100 THEN '50-100'
        WHEN TAMA_O > 100 THEN '100+'
    END AS TAMANO,
    
    /* --- PROPUESTA --- */
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
