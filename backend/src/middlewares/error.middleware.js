// Controlador de errores global
// Va al final de todos los middlewares en app.js
// Captura cualquier error que pase por next(error)
// y evita que el servidor se caiga con un stack trace expuesto
export const errorHandler = (err, req, res, next) => {
  console.error(`[ERROR] ${err.message}`)

  // Errores de validación de Zod
  if (err.name === 'ZodError') {
    return res.status(400).json({
      success: false,
      message: 'Datos inválidos',
      errors: err.errors.map(e => ({
        campo: e.path.join('.'),
        mensaje: e.message
      }))
    })
  }

  // Error genérico — nunca exponer el stack en producción
  const statusCode = err.statusCode || 500
  res.status(statusCode).json({
    success: false,
    message: err.message || 'Error interno del servidor'
  })
}
