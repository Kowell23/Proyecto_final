import jwt from 'jsonwebtoken'


export const authenticate = (req, res, next) => {
  const authHeader = req.headers['authorization']

  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({
      success: false,
      message: 'Acceso denegado. Token no proporcionado.'
    })
  }

  const token = authHeader.split(' ')[1]

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET)
    req.user = decoded  
    next()             
  } catch (error) {
    return res.status(401).json({
      success: false,
      message: 'Token inválido o expirado.'
    })
  }
}

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
