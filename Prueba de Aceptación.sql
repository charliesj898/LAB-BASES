--Pedro Pablo de Ingeniería de Sistema de la Julio Garavito acaba de encontrar la plataforma Link-Us y decide registrarse pues ha escuchado buenas críticas de esta. 
--La plataforma le pregunta si es un profesional o una fundación, él selecciona profesional y procede a llenar sus datos personales.

INSERT INTO PROFESIONALES (correo, nombre, pais, resumen, sector, competencia)
VALUES ('pedropablosistemas@icloud.com', 'Pedro Pablo', 'Colombia', 'Ingeniero de Sistemas con 5 años de experiencia en desarrollo web', 'Tecnología', 0);

--Después de registrarse, Pedro Pablo se da cuenta que para progresar y tener más visibilidad en la plataforma debe agregar competencias a su perfil. 
--Decide crear su propia competencia de IA Generativa para Apps móviles y decide agregarla a su perfil.
INSERT INTO COMPETENCIAS (codigo, nombre)
VALUES (1, 'IA Generativa para Apps móviles');


--Ve que es toda una comunidad de profesionales y fundaciones trabajando en diferentes sectores, y se da cuenta que las competencias deben ser validadas por otros profesionales o fundaciones.ALTER
--Por lo que decide empezar a seguir usuarios y validar competencias de otros profesionales en su sector para que ellos a la vez vean su perfil y lo validen a él también.


