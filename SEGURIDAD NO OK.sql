--SEGURIDAD NO OK

--El usuario quiere cambiar el estado de alguna validación. (mantener_estado_validacion)

BEGIN
    mantener_estado_validacion(
        103,
        'T'
    )
END;

--El usuario quiere ver todos las validaciones de un profesional en especifico. (listar_validaciones_profesional)

BEGIN
    listar_validaciones_profesional(
    'miamalkhova@hotnet.com'
    )
END;

--El miembro de Junta desea registrar una evidencia a una validación en especifico. (registar_evidencia)
BEGIN
    registar_evidencia(
        101,
        'https://drive.google.com/mi_evidencia.pdf'
    )
END;

