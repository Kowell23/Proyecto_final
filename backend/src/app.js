import express from 'express'
import cors from 'cors'
import dotenv from 'dotenv'
import { errorHandler } from './middlewares/error.middleware.js'
import authRoutes from './modules/auth/auth.routes.js'
import recipeRoutes from './modules/recipes/recipes.routes.js'
import userRoutes from './modules/users/users.routes.js'

dotenv.config()

const app = express()
const PORT = process.env.PORT || 3000

app.use(cors({
  origin: 'http://localhost:5173',
  credentials: true
}))

app.use(express.json())

// LOGS DE PETICIONES
app.use((req, res, next) => {
  console.log(`📡 ${req.method} ${req.url}`)
  next()
})

app.use('/api/auth', authRoutes)
app.use('/api/recipes', recipeRoutes)
app.use('/api/users', userRoutes)

app.get('/health', (req, res) => {
  res.json({
    status: 'ok',
    project: 'Recetas de Cocina API',
    version: '1.0.0'
  })
})

app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: 'Ruta no encontrada.'
  })
})

app.use(errorHandler)

app.listen(PORT, () => {
  console.log(`\n🍳 Servidor Recetas corriendo en http://localhost:${PORT}`)
  console.log(`📋 Health check: http://localhost:${PORT}/health`)
  console.log(`🛢️ Base de datos: recetas_db`)
  console.log(`🔐 Auth API: http://localhost:${PORT}/api/auth\n`)
})