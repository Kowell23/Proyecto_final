import bcrypt from 'bcryptjs'
import jwt from 'jsonwebtoken'
import pool from '../../config/db.js'
import { registerSchema, loginSchema } from '../../validators/auth.validator.js'

// POST /api/auth/register
export const register = async (req, res, next) => {
  try {
    // 1. Validar datos de entrada con Zod
    const { name, email, password } = registerSchema.parse(req.body)

    // 2. Verificar si el email ya existe en la BD
    const [existing] = await pool.query(
      'SELECT id FROM users WHERE email = ?',
      [email]
    )
    if (existing.length > 0) {
      return res.status(409).json({
        success: false,
        message: 'Ya existe una cuenta con ese email.'
      })
    }

    // 3. Hacer hash de la contraseña
    // El "10" es el saltRounds — cuántas veces se procesa el hash
    // Más rounds = más seguro pero más lento. 10 es el estándar.
    const password_hash = await bcrypt.hash(password, 10)

    // 4. Insertar en la base de datos
    const [result] = await pool.query(
      'INSERT INTO users (name, email, password_hash) VALUES (?, ?, ?)',
      [name, email, password_hash]
    )

    // 5. Generar JWT para que el usuario quede logueado inmediatamente
    const token = jwt.sign(
      { id: result.insertId, email, role: 'user' },
      process.env.JWT_SECRET,
      { expiresIn: process.env.JWT_EXPIRES_IN }
    )

    res.status(201).json({
      success: true,
      message: 'Usuario registrado correctamente.',
      token,
      user: { id: result.insertId, name, email, role: 'user' }
    })
  } catch (error) {
    next(error) // El errorHandler global lo procesa
  }
}

// POST /api/auth/login
export const login = async (req, res, next) => {
  try {
    // 1. Validar datos de entrada
    const { email, password } = loginSchema.parse(req.body)

    // 2. Buscar usuario por email
    const [rows] = await pool.query(
      'SELECT id, name, email, password_hash, role FROM users WHERE email = ?',
      [email]
    )

    if (rows.length === 0) {
      // Mensaje genérico — no revelar si el email existe o no (seguridad)
      return res.status(401).json({
        success: false,
        message: 'Credenciales incorrectas.'
      })
    }

    const user = rows[0]

    // 3. Comparar la contraseña con el hash guardado
    // bcrypt.compare es el proceso inverso — reconstruye el hash y compara
    const isMatch = await bcrypt.compare(password, user.password_hash)
    if (!isMatch) {
      return res.status(401).json({
        success: false,
        message: 'Credenciales incorrectas.'
      })
    }

    // 4. Generar JWT
    const token = jwt.sign(
      { id: user.id, email: user.email, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: process.env.JWT_EXPIRES_IN }
    )

    res.json({
      success: true,
      message: 'Login exitoso.',
      token,
      user: { id: user.id, name: user.name, email: user.email, role: user.role }
    })
  } catch (error) {
    next(error)
  }
}

// GET /api/auth/me  (ruta protegida — requiere JWT)
export const getMe = async (req, res, next) => {
  try {
    const [rows] = await pool.query(
      'SELECT id, name, email, role, created_at FROM users WHERE id = ?',
      [req.user.id]
    )
    if (rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Usuario no encontrado.' })
    }
    res.json({ success: true, user: rows[0] })
  } catch (error) {
    next(error)
  }
}
