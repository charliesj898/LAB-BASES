--Consulta propuesta en el archivo:

SELECT 
    e.id_actor_responsable      AS usuario,
    e.operacion                 AS tipo_operacion,
    EXTRACTVALUE(c.estado, '/EstadoSistema/NivelCarga') AS nivel_carga,
    
    COUNT(e.id)                 AS total_errores,
    COUNT(ev.id_evidencia)      AS total_evidencias

FROM ERRORES e
LEFT JOIN CRITICO c 
       ON c.error = e.id
LEFT JOIN EVIDENCIAS ev
       ON ev.id_error = e.id

WHERE e.fecha_hora >= ADD_MONTHS(SYSDATE, -1)

GROUP BY 
    e.id_actor_responsable,
    e.operacion,
    EXTRACTVALUE(c.estado, '/EstadoSistema/NivelCarga')

ORDER BY 
    total_errores DESC;


--Consulta propuesta por nosotros


--"Obtener el promedio de uso de CPU por cada operación (INSERT/UPDATE/DELETE/SELECT) en los errores críticos."

SELECT 
    e.operacion,
    AVG( TO_NUMBER( EXTRACTVALUE(c.estado, '/estado/cpu') ) ) AS promedio_cpu
FROM ERRORES e
JOIN CRITICO c ON c.error = e.id
GROUP BY e.operacion
ORDER BY promedio_cpu DESC;



-- Consulta punto 5

--“Qué errores críticos se presentan cuando el servidor está cerca de colapsar (CPU > 80% o RAM > 85% o más de 2 servicios caídos)”

SELECT 
    e.id AS id_error,
    e.fecha_hora,
    e.operacion,
    e.id_actor_responsable,
    EXTRACTVALUE(c.estado, '/estado_sistema/cpu_uso') AS cpu,
    EXTRACTVALUE(c.estado, '/estado_sistema/memoria_ram_uso') AS ram,
    COUNT(EXTRACTVALUE(value(t), '/servicio')) AS servicios_caidos
FROM ERRORES e
JOIN CRITICO c ON e.id = c.error
LEFT JOIN TABLE(
    XMLSEQUENCE(
        EXTRACT(c.estado, '/estado_sistema/servicios_caidos/servicio')
    )
) t ON 1=1
WHERE
    e.severidad = 'critico'
    AND (
        TO_NUMBER(EXTRACTVALUE(c.estado, '/estado_sistema/cpu_uso')) > 80
        OR TO_NUMBER(EXTRACTVALUE(c.estado, '/estado_sistema/memoria_ram_uso')) > 85
        OR (
            SELECT COUNT(*) 
            FROM TABLE(
                XMLSEQUENCE(
                    EXTRACT(c.estado, '/estado_sistema/servicios_caidos/servicio')
                )
            ) s
        ) >= 2
    )
GROUP BY 
    e.id, e.fecha_hora, e.operacion, e.id_actor_responsable, 
    EXTRACTVALUE(c.estado, '/estado_sistema/cpu_uso'),
    EXTRACTVALUE(c.estado, '/estado_sistema/memoria_ram_uso');
