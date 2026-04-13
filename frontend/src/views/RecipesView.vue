<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth.store.js'
import api from '../services/api.js'

const recipes = ref([])
const loading = ref(true)
const error   = ref(null)
const router  = useRouter()
const auth    = useAuthStore()

onMounted(async () => {
  try {
    const { data } = await api.get('/recipes')
    recipes.value = data.data
  } catch (err) {
    error.value = 'No se pudieron cargar las recetas.'
  } finally {
    loading.value = false
  }
})

async function toggleFavorite(recipe) {
  try {
    if (recipe.isFavorite) {
      await api.delete(`/recipes/${recipe.id}/favorites`)
      recipe.isFavorite = false
    } else {
      await api.post(`/recipes/${recipe.id}/favorites`)
      recipe.isFavorite = true
    }
  } catch {
    alert('Error al actualizar favoritos.')
  }
}
</script>

<template>
  <div class="recipes-page">
    <div class="recipes-header">
      <h1>🍳 Recetas</h1>
      <button v-if="auth.isAdmin" @click="$router.push('/admin')" class="btn-admin">
        Panel Admin
      </button>
    </div>

    <p v-if="loading">Cargando recetas...</p>
    <p v-else-if="error" class="error">{{ error }}</p>

    <div v-else class="recipes-grid">
      <div
        v-for="recipe in recipes"
        :key="recipe.id"
        class="recipe-card"
        @click="$router.push(`/recipes/${recipe.id}`)"
      >
        <img
          v-if="recipe.image_url"
          :src="recipe.image_url"
          :alt="recipe.title"
          class="recipe-img"
        />
        <div v-else class="recipe-img-placeholder">🍽️</div>

        <div class="recipe-info">
          <span class="recipe-category">{{ recipe.category || 'Sin categoría' }}</span>
          <h3>{{ recipe.title }}</h3>
          <p>{{ recipe.description || 'Sin descripción.' }}</p>
          <small>Por {{ recipe.author }}</small>
        </div>

        <button
          class="btn-fav"
          @click.stop="toggleFavorite(recipe)"
        >
          {{ recipe.isFavorite ? '❤️' : '🤍' }}
        </button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.recipes-page { max-width: 1100px; margin: 0 auto; padding: 2rem; }
.recipes-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; }
.btn-admin { background: #7c3aed; color: white; border: none; padding: .6rem 1.2rem; border-radius: 8px; cursor: pointer; }
.recipes-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 1.5rem; }
.recipe-card { background: #fff; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,.1); cursor: pointer; position: relative; overflow: hidden; transition: transform .2s; }
.recipe-card:hover { transform: translateY(-4px); }
.recipe-img { width: 100%; height: 160px; object-fit: cover; }
.recipe-img-placeholder { width: 100%; height: 160px; display: flex; align-items: center; justify-content: center; font-size: 3rem; background: #f3f4f6; }
.recipe-info { padding: 1rem; }
.recipe-category { font-size: .75rem; color: #7c3aed; font-weight: 600; text-transform: uppercase; }
.recipe-info h3 { margin: .3rem 0 .5rem; }
.recipe-info p { font-size: .9rem; color: #555; }
.recipe-info small { color: #999; }
.btn-fav { position: absolute; top: .7rem; right: .7rem; background: white; border: none; font-size: 1.3rem; border-radius: 50%; width: 36px; height: 36px; cursor: pointer; box-shadow: 0 2px 6px rgba(0,0,0,.2); }
.error { color: red; }
</style>