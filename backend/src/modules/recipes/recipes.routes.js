import { Router } from 'express'
import { authenticate, authorizeRole } from '../../middlewares/auth.middleware.js'
import {
  getAllRecipes,
  getRecipeById,
  createRecipe,
  updateRecipe,
  deleteRecipe,
  addFavorite,
  removeFavorite,
  getMyFavorites
} from './recipes.controller.js'

const router = Router()

router.get('/',                    getAllRecipes)
router.get('/:id',                 getRecipeById)

router.get('/favorites',           authenticate, getMyFavorites)
router.post('/:id/favorites',      authenticate, addFavorite)
router.delete('/:id/favorites',    authenticate, removeFavorite)

router.post('/',      authenticate, authorizeRole('admin', 'moderator'), createRecipe)
router.put('/:id',    authenticate, authorizeRole('admin', 'moderator'), updateRecipe)
router.delete('/:id', authenticate, authorizeRole('admin', 'moderator'), deleteRecipe)

export default router