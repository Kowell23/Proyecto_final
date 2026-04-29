<template>
  <div class="recipes-page">

    <!-- Modal visitante -->
    <div v-if="showGuestModal" class="modal-overlay" @click.self="showGuestModal = false">
      <div class="modal-card">
        <span class="modal-icon">🔐</span>
        <h2>¡Necesitas una cuenta!</h2>
        <p>Para guardar recetas favoritas debes iniciar sesión o registrarte.</p>
        <div class="modal-actions">
          <button @click="$router.push({ name: 'Login' })"    class="btn-modal-primary">Iniciar sesión</button>
          <button @click="$router.push({ name: 'Register' })" class="btn-modal-secondary">Registrarse</button>
        </div>
        <button @click="showGuestModal = false" class="btn-modal-close">Seguir explorando</button>
      </div>
    </div>

    <div class="recipes-header">
      <h1>🍽️ Todas las Recetas</h1>
    </div>

    <!-- Búsqueda -->
    <div class="search-wrapper">
      <div class="search-box">
        <span>🔍</span>
        <input
          v-model="searchQuery"
          type="text"
          placeholder="Buscar recetas..."
          class="search-input"
        />
        <button v-if="searchQuery" @click="searchQuery = ''" class="search-clear">✕</button>
      </div>
    </div>

    <p v-if="loading">Cargando recetas...</p>
    <p v-else-if="error" class="error">{{ error }}</p>

    <div v-else class="recipes-grid">
      <div
        v-for="(recipe, i) in filteredRecipes"
        :key="recipe.id"
        class="recipe-card"
        :style="{ '--card-color': cardColors[i % cardColors.length] }"
        @click="$router.push(`/recipes/${recipe.id}`)"
      >
        <div class="card-top">
          <div class="card-emoji">{{ categoryEmoji(recipe.category) }}</div>
          <button class="btn-fav" @click.stop="handleFavorite(recipe)">
            {{ recipe.isFavorite ? '❤️' : '🤍' }}
          </button>
        </div>
        <img v-if="recipe.image_url" :src="recipe.image_url" :alt="recipe.title" class="card-img" />
        <div class="card-body">
          <span class="card-category">{{ recipe.category || 'Receta' }}</span>
          <h3 class="card-title">{{ recipe.title }}</h3>
          <p class="card-desc">{{ recipe.description || 'Sin descripción.' }}</p>
          <div class="card-footer">
            <span class="card-author">👩‍🍳 {{ recipe.author }}</span>
            <span class="card-arrow">→</span>
          </div>
        </div>
      </div>
    </div>

    <div v-if="!loading && filteredRecipes.length === 0" class="empty-state">
      <span>🫙</span>
      <p>No se encontraron recetas.</p>
    </div>

  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useAuthStore } from '../../stores/auth.store.js'
import api from '../../services/api.js'

const auth           = useAuthStore()
const recipes        = ref([])
const loading        = ref(true)
const error          = ref(null)
const searchQuery    = ref('')
const showGuestModal = ref(false)

const cardColors = ['#EEE6FF', '#FFEEF3', '#FFF3E8', '#E8F8EF', '#FFF8E8']

const filteredRecipes = computed(() => {
  if (!searchQuery.value.trim()) return recipes.value
  const q = searchQuery.value.toLowerCase().trim()
  return recipes.value.filter(r =>
    r.title?.toLowerCase().includes(q) ||
    r.category?.toLowerCase().includes(q) ||
    r.author?.toLowerCase().includes(q)
  )
})

function categoryEmoji(category) {
  const map = {
    'Desayunos': '🌅', 'Almuerzos': '🍛', 'Cenas': '🌙',
    'Sin Horno': '🔥', 'Postres': '🧁', 'Bebidas': '🥤',
    'Ensaladas': '🥗', 'Platos Principales': '🍽️', 'Comida Típica': '🇨🇴',
  }
  return map[category] || '🍴'
}

function handleFavorite(recipe) {
  if (!auth.isAuthenticated) {
    showGuestModal.value = true
    return
  }
  toggleFavorite(recipe)
}

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

onMounted(async () => {
  try {
    const { data } = await api.get('/recipes')
    recipes.value = data.data
  } catch {
    error.value = 'No se pudieron cargar las recetas.'
  } finally {
    loading.value = false
  }
})
</script>

<style scoped>
.recipes-page { max-width: 1100px; margin: 0 auto; padding: 2rem; }
.recipes-header { margin-bottom: 1.5rem; }
.recipes-header h1 { font-size: 1.8rem; font-weight: 900; }

.search-wrapper { margin-bottom: 1.5rem; }
.search-box {
  display: flex;
  align-items: center;
  gap: .75rem;
  background: var(--color-input);
  border: 1.5px solid var(--color-border);
  border-radius: 99px;
  padding: .6rem 1.25rem;
  transition: border-color .2s;
}
.search-box:focus-within { border-color: var(--color-primary-dark); }
.search-input { flex: 1; border: none; background: transparent; font-family: 'Nunito', sans-serif; font-size: .95rem; font-weight: 600; color: var(--color-text); outline: none; }
.search-input::placeholder { color: var(--color-muted); }
.search-clear { background: none; border: none; color: var(--color-muted); cursor: pointer; font-size: .85rem; padding: .2rem .4rem; border-radius: 99px; }
.search-clear:hover { background: var(--color-border); }

.recipes-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 1.25rem; }
.recipe-card { background: var(--card-color, #EEE6FF); border-radius: 20px; overflow: hidden; cursor: pointer; transition: transform .2s, box-shadow .2s; position: relative; }
.recipe-card:hover { transform: translateY(-4px); box-shadow: 0 12px 30px rgba(0,0,0,.1); }
.card-top { display: flex; justify-content: space-between; align-items: center; padding: 1rem 1rem .5rem; }
.card-emoji { font-size: 2rem; }
.btn-fav { background: white; border: none; font-size: 1.2rem; border-radius: 99px; width: 34px; height: 34px; cursor: pointer; box-shadow: 0 2px 8px rgba(0,0,0,.1); display: flex; align-items: center; justify-content: center; }
.card-img { width: 100%; height: 150px; object-fit: cover; }
.card-body { padding: 1rem; background: white; margin: .5rem; border-radius: 14px; }
.card-category { font-size: .72rem; font-weight: 800; color: var(--color-primary-dark); text-transform: uppercase; letter-spacing: .5px; }
.card-title { font-size: 1.05rem; font-weight: 800; color: var(--color-text); margin: .25rem 0 .4rem; }
.card-desc { font-size: .83rem; color: var(--color-muted); line-height: 1.4; margin-bottom: .75rem; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
.card-footer { display: flex; justify-content: space-between; align-items: center; }
.card-author { font-size: .8rem; font-weight: 700; color: var(--color-muted); }
.card-arrow { font-weight: 800; color: var(--color-primary-dark); }
.empty-state { text-align: center; padding: 3rem; color: var(--color-muted); }
.empty-state span { font-size: 3rem; display: block; margin-bottom: 1rem; }
.empty-state p { font-weight: 700; }
.error { color: red; }

/* Modal */
.modal-overlay { position: fixed; inset: 0; background: rgba(45,27,78,.45); display: flex; align-items: center; justify-content: center; z-index: 200; padding: 1rem; }
.modal-card { background: white; border-radius: 20px; padding: 2rem; max-width: 380px; width: 100%; text-align: center; box-shadow: 0 20px 60px rgba(0,0,0,.2); }
.modal-icon { font-size: 2.5rem; display: block; margin-bottom: .75rem; }
.modal-card h2 { font-size: 1.3rem; font-weight: 900; color: var(--color-text); margin-bottom: .5rem; }
.modal-card p  { font-size: .9rem; color: var(--color-muted); line-height: 1.5; margin-bottom: 1.5rem; }
.modal-actions { display: flex; gap: .75rem; margin-bottom: .75rem; }
.btn-modal-primary { flex: 1; padding: .75rem; background: var(--color-primary-dark); color: white; border: none; border-radius: 10px; font-family: 'Nunito', sans-serif; font-size: .9rem; font-weight: 800; cursor: pointer; }
.btn-modal-secondary { flex: 1; padding: .75rem; background: var(--color-primary-light); color: var(--color-primary-dark); border: none; border-radius: 10px; font-family: 'Nunito', sans-serif; font-size: .9rem; font-weight: 800; cursor: pointer; }
.btn-modal-close { width: 100%; background: none; border: none; color: var(--color-muted); font-family: 'Nunito', sans-serif; font-size: .85rem; font-weight: 700; cursor: pointer; padding: .4rem; }
</style>