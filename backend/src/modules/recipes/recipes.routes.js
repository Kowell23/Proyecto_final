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

router.use(authenticate)

router.get('/',                    getAllRecipes)
router.get('/favorites',           getMyFavorites)
router.get('/:id',                 getRecipeById)
router.post('/:id/favorites',      addFavorite)
router.delete('/:id/favorites',    removeFavorite)

router.post('/',      authorizeRole('admin', 'moderator'), createRecipe)
router.put('/:id',    authorizeRole('admin', 'moderator'), updateRecipe)
router.delete('/:id', authorizeRole('admin', 'moderator'), deleteRecipe)

export default router