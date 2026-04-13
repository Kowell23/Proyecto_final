import pool from '../../config/db.js'
import { recipeSchema } from '../../validators/recipes.validator.js'

export const getAllRecipes = async (req, res, next) => {
  try {
    const [recipes] = await pool.query(`
      SELECT r.id, r.title, r.description, r.image_url, r.category,
             r.created_at, u.name AS author
      FROM recipes r
      JOIN users u ON r.created_by = u.id
      ORDER BY r.created_at DESC
    `)
    res.json({ success: true, data: recipes })
  } catch (error) {
    next(error)
  }
}

export const getRecipeById = async (req, res, next) => {
  try {
    const { id } = req.params

    const [recipes] = await pool.query(`
      SELECT r.*, u.name AS author
      FROM recipes r
      JOIN users u ON r.created_by = u.id
      WHERE r.id = ?
    `, [id])

    if (recipes.length === 0) {
      return res.status(404).json({ success: false, message: 'Receta no encontrada.' })
    }

    const [ingredients] = await pool.query(`
      SELECT i.name, ri.quantity
      FROM recipe_ingredients ri
      JOIN ingredients i ON ri.ingredient_id = i.id
      WHERE ri.recipe_id = ?
    `, [id])

    res.json({ success: true, data: { ...recipes[0], ingredients } })
  } catch (error) {
    next(error)
  }
}

export const createRecipe = async (req, res, next) => {
  try {
    const { title, description, instructions, image_url, category, ingredients } = recipeSchema.parse(req.body)

    const [result] = await pool.query(
      'INSERT INTO recipes (title, description, instructions, image_url, category, created_by) VALUES (?, ?, ?, ?, ?, ?)',
      [title, description || null, instructions, image_url || null, category || null, req.user.id]
    )

    const recipeId = result.insertId

    if (ingredients && ingredients.length > 0) {
      for (const ing of ingredients) {
        await pool.query(
          'INSERT IGNORE INTO ingredients (name) VALUES (?)',
          [ing.name]
        )
        const [[{ id: ingId }]] = await pool.query(
          'SELECT id FROM ingredients WHERE name = ?',
          [ing.name]
        )
        await pool.query(
          'INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity) VALUES (?, ?, ?)',
          [recipeId, ingId, ing.quantity || null]
        )
      }
    }

    res.status(201).json({
      success: true,
      message: 'Receta creada correctamente.',
      data: { id: recipeId, title }
    })
  } catch (error) {
    next(error)
  }
}

export const updateRecipe = async (req, res, next) => {
  try {
    const { id } = req.params
    const { title, description, instructions, image_url, category } = recipeSchema.partial().parse(req.body)

    const [existing] = await pool.query('SELECT id FROM recipes WHERE id = ?', [id])
    if (existing.length === 0) {
      return res.status(404).json({ success: false, message: 'Receta no encontrada.' })
    }

    await pool.query(
      'UPDATE recipes SET title=?, description=?, instructions=?, image_url=?, category=? WHERE id=?',
      [title, description || null, instructions, image_url || null, category || null, id]
    )

    res.json({ success: true, message: 'Receta actualizada correctamente.' })
  } catch (error) {
    next(error)
  }
}

export const deleteRecipe = async (req, res, next) => {
  try {
    const { id } = req.params

    const [existing] = await pool.query('SELECT id FROM recipes WHERE id = ?', [id])
    if (existing.length === 0) {
      return res.status(404).json({ success: false, message: 'Receta no encontrada.' })
    }

    await pool.query('DELETE FROM recipes WHERE id = ?', [id])
    res.json({ success: true, message: 'Receta eliminada correctamente.' })
  } catch (error) {
    next(error)
  }
}

export const addFavorite = async (req, res, next) => {
  try {
    const { id } = req.params
    const userId = req.user.id

    await pool.query(
      'INSERT IGNORE INTO favorites (user_id, recipe_id) VALUES (?, ?)',
      [userId, id]
    )

    res.json({ success: true, message: 'Receta añadida a favoritos.' })
  } catch (error) {
    next(error)
  }
}

export const removeFavorite = async (req, res, next) => {
  try {
    const { id } = req.params
    const userId = req.user.id

    await pool.query(
      'DELETE FROM favorites WHERE user_id = ? AND recipe_id = ?',
      [userId, id]
    )

    res.json({ success: true, message: 'Receta eliminada de favoritos.' })
  } catch (error) {
    next(error)
  }
}

export const getMyFavorites = async (req, res, next) => {
  try {
    const userId = req.user.id

    const [favorites] = await pool.query(`
      SELECT r.id, r.title, r.description, r.image_url, r.category, u.name AS author
      FROM favorites f
      JOIN recipes r ON f.recipe_id = r.id
      JOIN users u ON r.created_by = u.id
      WHERE f.user_id = ?
      ORDER BY f.created_at DESC
    `, [userId])

    res.json({ success: true, data: favorites })
  } catch (error) {
    next(error)
  }
}