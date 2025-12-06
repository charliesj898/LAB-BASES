--Pedro Pablo de Ingeniería de Sistema de la Julio Garavito acaba de encontrar la plataforma Link-Us y decide registrarse pues ha escuchado buenas críticas de esta. 
--La plataforma le pregunta si es un profesional o una fundación, él selecciona profesional y procede a llenar sus datos personales.

INSERT INTO PROFESIONALES (correo, nombre, pais, resumen, sector, competencia)
VALUES ('pedropablosistemas@gmail.com', 'Pedro Pablo', 'Colombia', 'Ingeniero de Sistemas con 5 años de experiencia en desarrollo web', 'Tecnología', 0);

--El sistema registra que el correo está mal pues no puede tener dominio @gmail.com para profesionales. ck_correo

INSERT INTO PROFESIONALES (correo, nombre, pais, resumen, sector, competencia)
VALUES ('pedropablosistemas@icloud.com', 'Pedro Pablo', 'Colombia', 'Ingeniero de Sistemas con 5 años de experiencia en desarrollo web', 'Tecnología', 0);

--Después de registrarse, Pedro Pablo se da cuenta que para progresar y tener más visibilidad en la plataforma debe agregar competencias a su perfil. 
--Decide crear su propia competencia de IA Generativa para Apps móviles y decide agregarla a su perfil.
INSERT INTO COMPETENCIAS (codigo, nombre)
VALUES (1, 'IA Generativa para Apps móviles');


--Ve que es toda una comunidad de profesionales y fundaciones trabajando en diferentes sectores, y se da cuenta que las competencias deben ser validadas por otros profesionales o fundaciones.ALTER
--Por lo que decide empezar a seguir usuarios y validar competencias de otros profesionales en su sector para que ellos a la vez vean su perfil y lo validen a él también.


INSERT INTO PERFILSIGUEPERFIL (perfil, seguido)
VALUES ('juanpablotecnologia@netube.com','pedropablosistemas@gmail.com');

--Pedro Pablo coloca su primera validación. 

INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia)
VALUES (1, NOW(), 'Proyecto de E-Commerce con IA', 'portafolioweb.pdf', 'E', 'juanpablotecnologia@netube.com','pedropablosistemas@icloud.com', 1);

--El sistema rechaza la validación pues el perfil que le validaba era un bot creada con IA, por lo que se rechaza esa validación . trg_validacion_red

--El perfil recibe la validación de otro usuario que sí pertenece a su red y se verifica la validación correctamente. Por lo que se inserta al sistema PROCEDURE agregar_validacion

INSERT INTO VALIDACIONES (numero, fecha, justificacion, evidencias, estado, perfil, profesional, competencia)
VALUES (1, NOW(), 'Proyecto de E-Commerce con IA', 'portafolioweb.pdf', 'T', 'Danielaredtube@icloud.com','pedropablosistemas@icloud.com', 1);

EXEC insertar_validacion(
    'Danielaredtube@icloud.com',
    'pedropablosistemas@icloud.com',
    1,
    'Proyecto de E-Commerce con IA',
    'portafolioweb.pdf'

);

--Pedro Pablo se da cuenta que cometió un error en la evidencia de su validación pues puso el documento que no era y decide actualizarla. PROCEDURE actualizar_validacion

EXEC actualizar_validacion(
    1,
    'Proyecto de E-Commerce con IA - Versión Corregida',
    'portafolioweb_v2.pdf',
    'T'
);

--Finalmente Pedro Pablo decide eliminar una validación que había hecho pues se dio cuenta que ese proyecto fue plagiado de otros y llamar al ese perfil a proceso disciplinario. PROCEDURE eliminar_validacion

EXEC eliminar_validacion(1);

--Luego de agregar, actualizar y eliminar validaciiones, Pedro lleva muchos meses en la plataforma y decide listar todas las validaciones que ha hecho a otros perfiles para llevar un control de su actividad. FUNCTION listar_validaciones_por_perfil


BEGIN 
    listar_validaciones_por_perfil('pedropablosistemas@icloud.com');
END;

--Por último quiere ver especificamente una validación que recibió. FUNCTION obtener_validacion

BEGIN
    obtener_validacion(34);
END;

--Luego de varios meses de Pedro Pablo usando la plataforma, haciendo validaciones y recibiéndolas, el Miembro de Junta ve algo extraño en su cuenta y se da cuenta que Pedro Pablo ha estado haciendo validaciones falsas a otros perfiles y recibiendo validaciones falsas también.
--Por lo que el Miembro de Junta decide consultar las validaciones sospechas y registrar el estado de estas como ANULADA (A). FUNCTION listar_validaciones_por_profesional
BEGIN
    listar_validaciones_por_profesional('pedropablosistemas@icloud.com');
END;

EXEC mantener_estado_validacion(3, 'A');
EXEC mantener_estado_validacion(8, 'A');
EXEC mantener_estado_validacion(17, 'A');
EXEC mantener_estado_validacion(24, 'A');
EXEC mantener_estado_validacion(39, 'A');

--Finalmente, Pedro Pablo al ver que tiene tantas validaciones anuladas decide eliminar su cuenta de la plataforma sin antes eliminar todas las validaciones y evidencias que ha hecho y recibido. PROCEDURE eliminar_validaciones

EXEC eliminar_validaciones(1);
EXEC eliminar_validaciones(2);
EXEC eliminar_validaciones(3);
EXEC eliminar_validaciones(4);
EXEC eliminar_validaciones(5);
EXEC eliminar_evidencias(1);
EXEC eliminar_evidencias(2);
EXEC eliminar_evidencias(3);
EXEC eliminar_evidencias(4);
EXEC eliminar_evidencias(5);
--.....ETC 

--Asi pues su cuenta es eliminada de la plataforma.

DELETE FROM PROFESIONALES
WHERE correo = 'pedropablosistemas@icloud.com';


-- ================================================================















