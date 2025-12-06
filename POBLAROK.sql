-- CICLO 1: PoblarOK

--------------------------------------------------
-- 1. SECTORES
--------------------------------------------------
INSERT INTO SECTORES (nombre) VALUES ('Salud');
INSERT INTO SECTORES (nombre) VALUES ('Educacion');
INSERT INTO SECTORES (nombre) VALUES ('Tecnologia');
INSERT INTO SECTORES (nombre) VALUES ('Agroindustria');
INSERT INTO SECTORES (nombre) VALUES ('Energía');
INSERT INTO SECTORES (nombre) VALUES ('Turismo');
INSERT INTO SECTORES (nombre) VALUES ('Transporte');
INSERT INTO SECTORES (nombre) VALUES ('Construccion');
INSERT INTO SECTORES (nombre) VALUES ('Finanzas');
INSERT INTO SECTORES (nombre) VALUES ('Cultura');
INSERT INTO SECTORES (nombre) VALUES ('Quimica');
INSERT INTO SECTORES (nombre) VALUES ('Derecho');

--------------------------------------------------
-- 2. COMPETENCIAS
--------------------------------------------------
INSERT INTO COMPETENCIAS (codigo, nombre) VALUES (1, 'Biomed');
INSERT INTO COMPETENCIAS (codigo, nombre) VALUES (2, 'Program');
INSERT INTO COMPETENCIAS (codigo, nombre) VALUES (3, 'Docencia');
INSERT INTO COMPETENCIAS (codigo, nombre) VALUES (4, 'Gestion');
INSERT INTO COMPETENCIAS (codigo, nombre) VALUES (5, 'Contab');
INSERT INTO COMPETENCIAS (codigo, nombre) VALUES (6, 'Mecanica');
INSERT INTO COMPETENCIAS (codigo, nombre) VALUES (7, 'Quimica');
INSERT INTO COMPETENCIAS (codigo, nombre) VALUES (8, 'Derecho');
INSERT INTO COMPETENCIAS (codigo, nombre) VALUES (9, 'Musica');
INSERT INTO COMPETENCIAS (codigo, nombre) VALUES (10, 'Diseño');


--------------------------------------------------
-- 3. PROFESIONALES
--------------------------------------------------
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia) VALUES ('ana@mail.com','Ing. biomédica','Salud',1);
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia) VALUES ('juan@mail.com','Ingeniero sistemas','Tecnologia',2);
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia) VALUES ('luis@mail.com','Profesor primaria','Educacion',3);
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia) VALUES ('maria@mail.com','Contadora','Finanzas',5);
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia) VALUES ('pedro@mail.com','Gerente agro','Agroindustria',4);
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia) VALUES ('sofia@mail.com','Mecánica automotriz','Transporte',6);
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia) VALUES ('diego@mail.com','Químico investigador','Quimica',7);
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia) VALUES ('laura@mail.com','Abogada','Derecho',8);
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia) VALUES ('carlos@mail.com','Músico violinista','Cultura',9);
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia) VALUES ('valeria@mail.com','Diseñadora gráfica','Cultura',10);


--------------------------------------------------
-- 4. PERFILES
--------------------------------------------------
-- Usamos dominios que no son gmail/hotmail/yahoo y nombres con espacio
INSERT INTO PERFILES (correo, nombre, pais) VALUES ('perf.ana@test.co', 'Perfil Uno', 'Colombia');
INSERT INTO PERFILES (correo, nombre, pais) VALUES ('perf.juan@test.co', 'Perfil Dos', 'Colombia');
INSERT INTO PERFILES (correo, nombre, pais) VALUES ('perf.luis@test.co', 'Perfil Tres', 'Colombia');
INSERT INTO PERFILES (correo, nombre, pais) VALUES ('perf.maria@test.co', 'Perfil Cuatro', 'Colombia');
INSERT INTO PERFILES (correo, nombre, pais) VALUES ('perf.pedro@test.co', 'Perfil Cinco', 'Colombia');
INSERT INTO PERFILES (correo, nombre, pais) VALUES ('perf.sofia@test.co', 'Perfil Seis', 'Colombia');
INSERT INTO PERFILES (correo, nombre, pais) VALUES ('perf.diego@test.co', 'Perfil Siete', 'Colombia');
INSERT INTO PERFILES (correo, nombre, pais) VALUES ('perf.laura@test.co', 'Perfil Ocho', 'Colombia');
INSERT INTO PERFILES (correo, nombre, pais) VALUES ('perf.carlos@test.co', 'Perfil Nueve', 'Colombia');
INSERT INTO PERFILES (correo, nombre, pais) VALUES ('perf.vale@test.co', 'Perfil Diez', 'Colombia');


--------------------------------------------------
-- 5. FUNDACIONES
--------------------------------------------------
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund1@mail.com','100+','Salud.comunitaria.pdf','Bogota',2005);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund2@mail.com','0-50','Capacitación.digital.pdf','Medellin',2015);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund3@mail.com','50-100','Apoyo.escolar.html','Cali',2010);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund4@mail.com','0-50','Sostenibilidad.rural.pdf','Pasto',2018);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund5@mail.com','100+','Energía.renovable.pdf','Barranquilla',2008);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund6@mail.com','50-100','Cultura.comunitaria.pdf','Bogota',2012);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund7@mail.com','100+','Transporte.inclusivo.pdf','Cali',2017);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund8@mail.com','0-50','Apoyo.jurídico.html','Medellin',2019);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund9@mail.com','50-100','Música.juvenil.html','Cartagena',2016);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund10@mail.com','100+','Diseño.social.html','Bogota',2021);


--------------------------------------------------
-- 5.. (PERFILSIGUEPERFIL)
--------------------------------------------------
INSERT INTO PERFILSIGUEPERFIL (perfil, seguido) VALUES ('perf.ana@test.co', 'ana@mail.com');
INSERT INTO PERFILSIGUEPERFIL (perfil, seguido) VALUES ('perf.juan@test.co', 'juan@mail.com');
INSERT INTO PERFILSIGUEPERFIL (perfil, seguido) VALUES ('perf.luis@test.co', 'luis@mail.com');
INSERT INTO PERFILSIGUEPERFIL (perfil, seguido) VALUES ('perf.maria@test.co', 'maria@mail.com');
INSERT INTO PERFILSIGUEPERFIL (perfil, seguido) VALUES ('perf.pedro@test.co', 'pedro@mail.com');
INSERT INTO PERFILSIGUEPERFIL (perfil, seguido) VALUES ('perf.sofia@test.co', 'sofia@mail.com');
INSERT INTO PERFILSIGUEPERFIL (perfil, seguido) VALUES ('perf.diego@test.co', 'diego@mail.com');
INSERT INTO PERFILSIGUEPERFIL (perfil, seguido) VALUES ('perf.laura@test.co', 'laura@mail.com');
INSERT INTO PERFILSIGUEPERFIL (perfil, seguido) VALUES ('perf.carlos@test.co', 'carlos@mail.com');
INSERT INTO PERFILSIGUEPERFIL (perfil, seguido) VALUES ('perf.vale@test.co', 'valeria@mail.com');

--------------------------------------------------
-- 6. VALIDACIONES 
--------------------------------------------------
INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) 
VALUES (101, TO_DATE('2025-02-01', 'YYYY-MM-DD'), 'Experiencia comprobada','CV.doc.pdf','A','perf.ana@test.co','ana@mail.com',1);

INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) 
VALUES (102, TO_DATE('2025-02-02', 'YYYY-MM-DD'), 'Certificado verificado','Diploma.p.pdf','A','perf.juan@test.co','juan@mail.com',2);

INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) 
VALUES (103, TO_DATE('2025-02-03', 'YYYY-MM-DD'), 'Rechazo por inconsistencia','CV.h.pdf','R','perf.luis@test.co','luis@mail.com',3);

INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) 
VALUES (104, TO_DATE('2025-03-01', 'YYYY-MM-DD'), 'Experiencia aceptada','Certificado.p.pdf','A','perf.maria@test.co','maria@mail.com',5);

INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) 
VALUES (105, TO_DATE('2025-03-02', 'YYYY-MM-DD'), 'Documentación incompleta','Carta.h.html','R','perf.pedro@test.co','pedro@mail.com',4);

INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) 
VALUES (106, TO_DATE('2025-03-03', 'YYYY-MM-DD'), 'Revisión adicional','Carta.o.pdf','T','perf.sofia@test.co','sofia@mail.com',6);

INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) 
VALUES (107, TO_DATE('2025-03-04', 'YYYY-MM-DD'), 'Aceptada por experiencia','Cert.t.pdf','A','perf.diego@test.co','diego@mail.com',7);

INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) 
VALUES (108, TO_DATE('2025-03-05', 'YYYY-MM-DD'), 'Rechazada por falta de info','Carta.h.pdf','R','perf.laura@test.co','laura@mail.com',8);

INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) 
VALUES (109, TO_DATE('2025-03-06', 'YYYY-MM-DD'), 'Aceptada','Soporte.h.pdf','A','perf.carlos@test.co','carlos@mail.com',9);

INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) 
VALUES (110, TO_DATE('2025-03-07', 'YYYY-MM-DD'), 'Pendiente por verificar','Carta.net.html','T','perf.vale@test.co','valeria@mail.com',10);

--------------------------------------------------
-- 7. ERRORES
--------------------------------------------------

INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, validacion, id_actor_responsable) 
VALUES (201, 'Falla por FK de Competencia (Prueba)', TO_DATE('2025-04-01', 'YYYY-MM-DD'), 'Insert', 'crítico', 'VALIDACION', 1, 'ana@mail.com');

INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, validacion, id_actor_responsable) 
VALUES (202, 'Falla por CHECK de Estado (Prueba)', TO_DATE('2025-04-02', 'YYYY-MM-DD'), 'Update', 'advertencia', 'VALIDACION', 2, 'juan@mail.com');

INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, validacion, id_actor_responsable) 
VALUES (203, 'Falla de trigger por red (Prueba)', TO_DATE('2025-04-03', 'YYYY-MM-DD'), 'Insert', 'crítico', 'PROFESIONAL', 3, 'luis@mail.com');

INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, validacion, id_actor_responsable) 
VALUES (204, 'Falla por referencia en Logros (Prueba)', TO_DATE('2025-04-04', 'YYYY-MM-DD'), 'Delete', 'informativo', 'PROFESIONAL', 4, 'maria@mail.com');

INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, validacion, id_actor_responsable) 
VALUES (205, 'Falla por modificación anulada (Prueba)', TO_DATE('2025-04-05', 'YYYY-MM-DD'), 'Update', 'crítico', 'VALIDACION', 5, 'pedro@mail.com');



--------------------------------------------------
--LAB 06
--------------------------------------------------
-- Error crítico (DELETE)
INSERT INTO ERRORES (
    id, mensaje_error, fecha_hora, operacion,
    severidad, gran_concepto, id_actor_responsable, validacion
) VALUES (
    501, 
    'Eliminación fallida por llave foránea', 
    SYSDATE,
    'DELETE',
    'CRITICO',
    'Usuarios',
    'correo_del_actor@dominio.com',
    1 -- Debe existir en VALIDACIONES
);
INSERT INTO CRITICO (error, estado)
VALUES (
    501,
    XMLTYPE(
        '<EstadoSistema>
            <CPU_Usage>35</CPU_Usage>
            <Usuarios_Conectados>120</Usuarios_Conectados>
            <Procesos_Activos>58</Procesos_Activos>
            <Nivel_Carga>MEDIA</Nivel_Carga>
        </EstadoSistema>'
    )
);


INSERT INTO CRITICO (error, estado)
VALUES (
    201,
    XMLType('
        <Estado>
            <cpu>45</cpu>
            <usuarios>80</usuarios>
            <procesos>20</procesos>
            <carga>Media</carga>
        </Estado>
    ')
);

INSERT INTO CRITICO (error, estado)
VALUES (
    202,
    XMLType('
        <Estado>
            <cpu>90</cpu>
            <usuarios>150</usuarios>
            <procesos>41</procesos>
            <carga>Critica</carga>
        </Estado>
    ')
);

INSERT INTO CRITICO (error, estado)
VALUES (
    203,
    XMLType('
        <Estado>
            <cpu>33</cpu>
            <usuarios>60</usuarios>
            <procesos>12</procesos>
            <carga>Baja</carga>
        </Estado>
    ')
);

INSERT INTO CRITICO (error, estado)
VALUES (
    204,
    XMLType('
        <Estado>
            <cpu>70</cpu>
            <usuarios>95</usuarios>
            <procesos>27</procesos>
            <carga>Media</carga>
        </Estado>
    ')
);
