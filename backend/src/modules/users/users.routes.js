import { Router } from 'express'
import pool from '../../config/db.js'
import { authenticate, authorizeRole } from '../../middlewares/auth.middleware.js'

const router = Router()

router.use(authenticate)

router.get('/', authorizeRole('admin'), async (req, res, next) => {
  try {
    const [rows] = await pool.query(
      'SELECT id, name, email, role, is_banned, created_at FROM users ORDER BY created_at DESC'
    )
    res.json({ success: true, data: rows })
  } catch (error) {
    next(error)
  }
})

router.put('/:id/ban', authorizeRole('admin'), async (req, res, next) => {
  try {
    const { id } = req.params
    const [existing] = await pool.query('SELECT id, is_banned FROM users WHERE id = ?', [id])

    if (existing.length === 0) {
      return res.status(404).json({ success: false, message: 'Usuario no encontrado.' })
    }

    const newStatus = !existing[0].is_banned

    await pool.query('UPDATE users SET is_banned = ? WHERE id = ?', [newStatus, id])

    res.json({
      success: true,
      message: newStatus ? 'Usuario baneado.' : 'Usuario desbaneado.'
    })
  } catch (error) {
    next(error)
  }
})

router.delete('/:id', authorizeRole('admin'), async (req, res, next) => {
  try {
    const { id } = req.params

    const [existing] = await pool.query('SELECT id FROM users WHERE id = ?', [id])

    if (existing.length === 0) {
      return res.status(404).json({ success: false, message: 'Usuario no encontrado.' })
    }

    await pool.query('DELETE FROM users WHERE id = ?', [id])

    res.json({ success: true, message: 'Usuario eliminado.' })
  } catch (error) {
    next(error)
  }
})

export default router