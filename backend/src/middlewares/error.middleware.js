export const errorHandler = (err, req, res, next) => {
  console.error(`[ERROR] ${err.message}`)

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

  const statusCode = err.statusCode || 500
  res.status(statusCode).json({
    success: false,
    message: err.message || 'Error interno del servidor'
  })
}
