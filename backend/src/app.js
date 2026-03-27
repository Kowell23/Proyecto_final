import express from 'express'
import cors from 'cors'
import dotenv from 'dotenv'
import { errorHandler } from './middlewares/error.middleware.js'
import authRoutes from './modules/auth/auth.routes.js'

dotenv.config()

const app = express()
const PORT = process.env.PORT || 3000

// ─── Middlewares globales ──────────────────────────────────────────────────────
app.use(cors({
  origin: 'http://localhost:5173', // Puerto de Vite (Vue)
  credentials: true
}))
app.use(express.json())            // Parsea body como JSON

// ─── Rutas ────────────────────────────────────────────────────────────────────
app.use('/api/auth', authRoutes)

// Health check — para verificar que el servidor vive
app.get('/health', (req, res) => {
  res.json({ status: 'ok', project: 'Recetas de Cocina API', version: '1.0.0' })
})

// Ruta no encontrada — 404
app.use((req, res) => {
  res.status(404).json({ success: false, message: 'Ruta no encontrada.' })
})

// ─── Controlador de errores global (siempre al final) ─────────────────────────
app.use(errorHandler)

// ─── Iniciar servidor ─────────────────────────────────────────────────────────
app.listen(PORT, () => {
  console.log(`\n🍳 Servidor Recetas corriendo en http://localhost:${PORT}`)
  console.log(`📋 Health check: http://localhost:${PORT}/health\n`)
})
