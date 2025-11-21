-- ============================================
-- D.2 Crear Roles
-- ============================================

CREATE ROLE ROL_USUARIO;
CREATE ROLE ROL_JUNTA;

-- ============================================
-- D.2 Otorgar permisos a los roles
-- ============================================

GRANT EXECUTE ON PA_USUARIO TO ROL_USUARIO;
GRANT EXECUTE ON PA_JUNTA TO ROL_JUNTA;

-- ============================================
-- D.3 Asignar roles a usuarios reales
-- ============================================

GRANT ROL_USUARIO TO bd1000105535;
GRANT ROL_JUNTA TO --Pedro o alguien mas--
;
