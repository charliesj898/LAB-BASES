--CICLO 1: PoblarNoOK

--2) Escriban tres casos de inserción que no deberían permitirse y no se permiten por las reglas de integridad definidas
-- . Documenten lo que desean validar. Traten de ilustrar lo más significativo.


-- PROFESIONALES: columna correo es NOT NULL
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia)
VALUES (NULL, 'Resumen profesional ejemplo', 'Salud', 1);
-- ERROR por violación de NOT NULL

-- COMPETENCIAS: codigo es INT, intento insertar texto
INSERT INTO COMPETENCIAS (codigo, nombre)
VALUES ('ABC', 'Comp_invalida');
-- ERROR: tipo de dato incorrecto (se espera entero en 'codigo').


-- FUNDACIONES: año es INT(3), intento con valor alfabético
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano)
VALUES ('fundX@mail.com','PEQUE','Prueba tipo','Bogota','AÑO');
-- ERROR: tipo de dato incorrecto (se espera entero en 'año').

--CICLO 1: PoblarNoOK

--3) Escriban tres casos de inserción que no deberían permitirse y todavía se permiten.
-- Documenten lo que desean validar. Traten de ilustrar lo más significativo.

-- ya existe COMPETENCIA con codigo = 1
INSERT INTO COMPETENCIAS (codigo, nombre) VALUES (1, 'Sistemas');

-- ya existe PROFESIONAL con correo = 'ana@mail.com'
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia)
VALUES ('ana@mail.com', 'Resumen generico', 'Salud', 1);

-- ya existe NOTIFICACION con id_notificacion = 1
INSERT INTO NOTIFICACIONES (id_notificacion, descripcion, correo, fecha_envio, id_error, perfil)
VALUES (1, 'Notificación generica', 'monitor@mail.com', '2025-02-20 10:00:00', 1, 'Perfil1');



-- CICLO 1: PoblarNoOK (2)

--2) Revisen los casos del paso 3) del punto anterior y para cada uno de ellos indique el
--nombre de la restricción que los protege.

-- ya existe COMPETENCIA con codigo = 1
INSERT INTO COMPETENCIAS (codigo, nombre) VALUES (1, 'Sistemas');

------> pk_competencias PROTEGE ESTA RESTRICCION

-- ya existe PROFESIONAL con correo = 'ana@mail.com'
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia)
VALUES ('ana@mail.com', 'Resumen generico', 'Salud', 1);

------> pk_profesionales PROTEGE ESTA RESTRICCION

-- ya existe NOTIFICACION con id_notificacion = 1
INSERT INTO NOTIFICACIONES (id_notificacion, descripcion, correo, fecha_envio, id_error, perfil)
VALUES (1, 'Notificación generica', 'monitor@mail.com', '2025-02-20 10:00:00', 1, 'Perfil1');

------> pk_notificaciones PROTEGE ESTA RESTRICCION

--3) Propongan otros tres casos que ilustren la protección de la bases de datos. Para
--estos indiquen también el nombre de la restricción que los protege.

INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, id_actor_responsable, validacion) 
VALUES (4,'Error en validación','2025-02-10 10:30','REMOVER','Informativo','VALIDACION','101','101');
--ck_operacion es la restriccion que protege

INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, id_actor_responsable, validacion) 
VALUES (4,'Error en validación','2025-02-10 10:30','REMOVER','Extrema','VALIDACION','101','101');
--ck_severidad es la restriccion que protege

INSERT INTO EVIDENCIAS (tipo, ruta, fecha, id_error) 
VALUES ('Video','/img/err1.png','2025-02-10',1);
--ck_tipo es al restriccion que protege

--------------------------------------------------
--LAB 06
--------------------------------------------------

-- Error crítico inválido (UPDATE)
INSERT INTO ERRORES (
    id, mensaje_error, fecha_hora, operacion,
    severidad, gran_concepto, id_actor_responsable, validacion
) VALUES (
    502, 
    'Actualización interrumpida – datos corruptos', 
    SYSDATE,
    'UPDATE',
    'CRITICO',
    'Perfiles',
    'correo_del_actor@dominio.com',
    1
);


INSERT INTO CRITICO (error, estado)
VALUES (
    502,
    XMLTYPE(
        '<EstadoSistema>
            <CPU>alto</CPU>
            <Usuarios>??</Usuarios>
        </EstadoSistema>'
    )
);



INSERT INTO CRITICO (error, estado)
VALUES (
    999,
    XMLType('
        <Estado>
            <cpu>50</cpu>
            <usuarios>40</usuarios>
            <procesos>10</procesos>
            <carga>Baja</carga>
        </Estado>
    ')
);

INSERT INTO CRITICO (error, estado)
VALUES (
    6,
    XMLType('
        <Estado>
            <cpu>40</cpu>
            <usuarios>30</usuarios>
            <procesos>10
            <carga>Media</carga>
        </Estado>
    ')
);


INSERT INTO CRITICO (error, estado)
VALUES (
    7,
    XMLType('
        <Estado>
            <cpu>82</cpu>
            <usuarios>110</usuarios>
            <procesoss>22</procesoss>
            <carga>Alta</carga>
        </Estado>
    ')
);

INSERT INTO CRITICO (error, estado)
VALUES (
    8,
    XMLType('<Estado></Estado>')
);



