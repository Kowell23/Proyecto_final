import { Router } from 'express'
import { register, login, getMe } from './auth.controller.js'
import { authenticate } from '../../middlewares/auth.middleware.js'

const router = Router()

// Rutas públicas — no requieren token
router.post('/register', register)
router.post('/login',    login)

// Ruta privada — requiere token válido
router.get('/me', authenticate, getMe)

export default router
