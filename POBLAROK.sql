--CICLO 1: PoblarOK

-- SECTORES
INSERT INTO SECTORES (nombre) VALUES ('Salud');
INSERT INTO SECTORES (nombre) VALUES ('Educacion');
INSERT INTO SECTORES (nombre) VALUES ('Tecnologia');

-- COMPETENCIAS
INSERT INTO COMPETENCIAS (codigo, nombre) VALUES (1, 'Biomed');
INSERT INTO COMPETENCIAS (codigo, nombre) VALUES (2, 'Program');
INSERT INTO COMPETENCIAS (codigo, nombre) VALUES (3, 'Docencia');

-- PROFESIONALES
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia) 
VALUES ('ana@mail.com','Ing. biomédica','Salud',1);
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia) 
VALUES ('juan@mail.com','Ingeniero sistemas','Tecnologia',2);
INSERT INTO PROFESIONALES (correo, resumen, sector, competencia) 
VALUES ('luis@mail.com','Profesor primaria','Educacion',3);

-- FUNDACIONES
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) 
VALUES ('fund1@mail.com','GRANDE','Salud comunitaria','Bogota',2005);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) 
VALUES ('fund2@mail.com','PEQUE','Capacitación digital','Medellin',2015);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) 
VALUES ('fund3@mail.com','MEDIAN','Apoyo escolar','Cali',2010);

-- VALIDACIONES
INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia)
VALUES (101,'2025-02-01','Experiencia comprobada','CV','A','Perfil1','ana@mail.com',1);
INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia)
VALUES (102,'2025-02-02','Certificado verificado','Diploma','A','Perfil2','juan@mail.com',2);
INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia)
VALUES (103,'2025-02-03','Rechazo por inconsistencia','N/A','R','Perfil3','luis@mail.com',3);

-- ERRORES
INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, id_actor_responsable, validacion) 
VALUES (1,'Error en validación','2025-02-10 10:30','INSERT','BAJO','VALIDACION','101','101');
INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, id_actor_responsable, validacion) 
VALUES (2,'Dato inconsistente','2025-02-11 12:10','UPDATE','MEDIO','PROFESIONAL','102','102');
INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, id_actor_responsable, validacion) 
VALUES (3,'Error crítico en carga','2025-02-12 08:00','DELETE','CRITICO','SECTOR','103','103');

--SECTORES

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


--COMPETENCIAS

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


--PROFESIONALES

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


--FUNDACIONES

INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund1@mail.com','100+','Salud.comunitaria.pdf','Bogota',2005);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund2@mail.com','0-50','Capacitación.digital.pdf','Medellin',2015);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund3@mail.com','50-100','Apoyo escolar.html','Cali',2010);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund4@mail.com','0-50','Sostenibilidad.rural.pdf','Pasto',2018);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund5@mail.com','100+','Energía.renovable.pdf','Barranquilla',2008);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund6@mail.com','50-100','Cultura.comunitaria.pdf','Bogota',2012);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund7@mail.com','100+','Transporte.inclusivo.pdf','Cali',2017);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund8@mail.com','0-50','Apoyo.jurídico.html','Medellin',2019);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund9@mail.com','50-100','Música.juvenil.html','Cartagena',2016);
INSERT INTO FUNDACIONES (correo, tamano, propuesta, ciudad, ano) VALUES ('fund10@mail.com','100+','Diseño.social.html','Bogota',2021);


--ERRORES

INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, id_actor_responsable, validacion) VALUES (1,'Error en validación','2025-02-10 10:30','INSERT','informativo','VALIDACION','ana@mail.com',101);
INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, id_actor_responsable, validacion) VALUES (2,'Dato inconsistente','2025-02-11 12:10','UPDATE','advertencia','PROFESIONAL','juan@mail.com',102);
INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, id_actor_responsable, validacion) VALUES (3,'Error crítico en carga','2025-02-12 08:00','DELETE','crítico','SECTOR','luis@mail.com',103);
INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, id_actor_responsable, validacion) VALUES (4,'Error de conexión','2025-03-02 15:00','INSERT','informativo','PROFESIONAL','maria@mail.com',104);
INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, id_actor_responsable, validacion) VALUES (5,'Violación de integridad','2025-03-03 16:20','UPDATE','crítico','VALIDACION','pedro@mail.com',105);
INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, id_actor_responsable, validacion) VALUES (6,'Error en formato de dato','2025-03-04 09:00','INSERT','advertencia','COMPETENCIA','sofia@mail.com',106);
INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, id_actor_responsable, validacion) VALUES (7,'Error en permisos','2025-03-05 14:15','SELECT','crítico','PROFESIONAL','diego@mail.com',107);
INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, id_actor_responsable, validacion) VALUES (8,'Error crítico en BD','2025-03-06 17:45','UPDATE','crítico','SECTOR','laura@mail.com',108);
INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, id_actor_responsable, validacion) VALUES (9,'Error en join','2025-03-07 20:30','SELECT','informativo','VALIDACION','carlos@mail.com',109);
INSERT INTO ERRORES (id, mensaje_error, fecha_hora, operacion, severidad, gran_concepto, id_actor_responsable, validacion) VALUES (10,'Timeout en consulta','2025-03-08 11:00','DELETE','advertencia','PROFESIONAL','valeria@mail.com',110);

--VALIDACIONES

INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) VALUES (101,'2025-02-01','Experiencia comprobada','CV.pdf','A','Perfil1','ana@mail.com',1);
INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) VALUES (102,'2025-02-02','Certificado verificado','Diploma.p.pdf','A','Perfil2','juan@mail.com',2);
INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) VALUES (103,'2025-02-03','Rechazo por inconsistencia','CV.h.pdf','R','Perfil3','luis@mail.com',3);
INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) VALUES (104,'2025-03-01','Experiencia aceptada','Certificado.p.pdf','A','Perfil4','maria@mail.com',5);
INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) VALUES (105,'2025-03-02','Documentación incompleta','Carta.h.html','R','Perfil5','pedro@mail.com',4);
INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) VALUES (106,'2025-03-03','Revisión adicional','Carta.o.pdf','T','Perfil6','sofia@mail.com',6);
INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) VALUES (107,'2025-03-04','Aceptada por experiencia','Cert.t.pdf','A','Perfil7','diego@mail.com',7);
INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) VALUES (108,'2025-03-05','Rechazada por falta de info','Carta.h.pdf','R','Perfil8','laura@mail.com',8);
INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) VALUES (109,'2025-03-06','Aceptada','Soporte.h.pdf','A','Perfil9','carlos@mail.com',9);
INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia) VALUES (110,'2025-03-07','Pendiente por verificar','Carta.net.html','T','Perfil10','valeria@mail.com',10);






