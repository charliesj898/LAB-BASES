--SEGURIDAD OK

--Un usuario quiere registrar una validación.

EXEC insertar_validacion(
    'Danielaredtube@icloud.com',
    'pedropablosistemas@icloud.com',
    1,
    'Proyecto de E-Commerce con IA',
    'portafolioweb.pdf'

);

--El usuario quiere actualizar la validación que acaba de registrar.

EXEC actualizar_validacion(
    1,
    'Proyecto de E-Commerce con IA - Versión Corregida',
    'portafolioweb_v2.pdf',
    'T'
);

--El usuario quiere eliminar una validación que ya no es relevante.


EXEC eliminar_validacion(1);

--El miembro de la junta quiere ver una validación específica.

BEGIN
    consultar_validacion(69);
END;

--El miembro de la junta quiere ver todas las validaciones de un profesional en particular.


BEGIN
    listar_validaciones_por_profesional('lanadelmar@icloud.com');
END;
