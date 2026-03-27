import jwt from 'jsonwebtoken'

// Middleware de autenticación:
// Actúa como el portero de una discoteca — revisa el carnet (JWT)
// antes de dejar pasar la petición al controlador
export const authenticate = (req, res, next) => {
  const authHeader = req.headers['authorization']

  // El header debe venir así: "Bearer <token>"
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({
      success: false,
      message: 'Acceso denegado. Token no proporcionado.'
    })
  }

  const token = authHeader.split(' ')[1]

  try {
    // jwt.verify lanza excepción si el token es inválido o expiró
    const decoded = jwt.verify(token, process.env.JWT_SECRET)
    req.user = decoded  // Adjunta los datos del usuario al request
    next()              // Deja pasar
  } catch (error) {
    return res.status(401).json({
      success: false,
      message: 'Token inválido o expirado.'
    })
  }
}

// Middleware de autorización por rol:
// Verifica que el usuario autenticado tenga el rol requerido
// Uso: router.delete('/recipe/:id', authenticate, authorizeRole('admin'), ...)
export const authorizeRole = (...roles) => {
  return (req, res, next) => {
    if (!roles.includes(req.user.role)) {
      return res.status(403).json({
        success: false,
        message: 'No tienes permisos para realizar esta acción.'
      })
    }
    next()
  }
}
