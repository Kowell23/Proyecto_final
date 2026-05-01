import bcrypt from 'bcryptjs'
import jwt from 'jsonwebtoken'
import pool from '../../config/db.js'
import { registerSchema, loginSchema } from '../../validators/auth.validator.js'

export const register = async (req, res, next) => {
  try {
    const { name, email, password } = registerSchema.parse(req.body)

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

    const password_hash = await bcrypt.hash(password, 10)

    const [result] = await pool.query(
      'INSERT INTO users (name, email, password_hash) VALUES (?, ?, ?)',
      [name, email, password_hash]
    )

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
    next(error) 
  }
}

export const login = async (req, res, next) => {
  try {
    const { email, password } = loginSchema.parse(req.body)

    const [rows] = await pool.query(
      'SELECT id, name, email, password_hash, role, is_banned FROM users WHERE email = ?',
      [email]
    )

    if (rows.length === 0) {
      return res.status(401).json({
        success: false,
        message: 'Credenciales incorrectas.'
      })
    }

    const user = rows[0]

    if (user.is_banned) {
      return res.status(403).json({
        success: false,
        message: 'Tu cuenta ha sido baneada. Contacta al administrador.'
      })
    }

    const isMatch = await bcrypt.compare(password, user.password_hash)
    if (!isMatch) {
      return res.status(401).json({
        success: false,
        message: 'Credenciales incorrectas.'
      })
    }

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
