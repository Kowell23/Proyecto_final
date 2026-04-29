<template>
  <div class="recipes-page">

    <GuestModal v-if="showGuestModal" @close="showGuestModal = false" />

    <div class="page-header">
      <h1>🍽️ Todas las Recetas</h1>
      <span class="count">{{ filteredRecipes.length }} recetas</span>
    </div>

    <div class="search-wrapper">
      <div class="search-box">
        <span>🔍</span>
        <input v-model="searchQuery" type="text" placeholder="Buscar recetas..." class="search-input" />
        <button v-if="searchQuery" @click="searchQuery = ''" class="search-clear">✕</button>
      </div>
    </div>

    <p v-if="loading" class="state-msg">🍳 Cargando recetas...</p>
    <p v-else-if="error" class="state-msg error">{{ error }}</p>

    <div v-else-if="filteredRecipes.length === 0" class="empty-state">
      <span>🫙</span><p>No se encontraron recetas.</p>
    </div>

    <!-- ✅ RecipeCard llamado — sin repetir el HTML -->
    <div v-else class="recipes-grid">
      <RecipeCard
        v-for="(recipe, i) in filteredRecipes"
        :key="recipe.id"
        :recipe="recipe"
        :color="CARD_COLORS[i % CARD_COLORS.length]"
        @toggle-favorite="handleFavorite"
      />
    </div>

  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useAuthStore } from '../../stores/auth.store.js'
import api from '../../services/api.js'
import RecipeCard from '../../components/RecipeCard.vue'
import GuestModal from '../../components/GuestModal.vue'

const auth           = useAuthStore()
const recipes        = ref([])
const loading        = ref(true)
const error          = ref(null)
const searchQuery    = ref('')
const showGuestModal = ref(false)

const CARD_COLORS = ['#EEE6FF', '#FFEEF3', '#FFF3E8', '#E8F8EF', '#FFF8E8']

const filteredRecipes = computed(() => {
  if (!searchQuery.value.trim()) return recipes.value
  const q = searchQuery.value.toLowerCase()
  return recipes.value.filter(r =>
    r.title?.toLowerCase().includes(q)    ||
    r.category?.toLowerCase().includes(q) ||
    r.author?.toLowerCase().includes(q)
  )
})

function handleFavorite(recipe) {
  if (!auth.isAuthenticated) { showGuestModal.value = true; return }
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
  } catch { alert('Error al actualizar favoritos.') }
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
.page-header  { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; }
.page-header h1 { font-size: 1.8rem; font-weight: 900; }
.count { font-size: .85rem; font-weight: 700; color: var(--color-muted); background: var(--color-primary-light); padding: .3rem .8rem; border-radius: 99px; }

.search-wrapper { margin-bottom: 1.5rem; }
.search-box {
  display: flex; align-items: center; gap: .75rem;
  background: var(--color-input); border: 1.5px solid var(--color-border);
  border-radius: 99px; padding: .6rem 1.25rem; transition: border-color .2s;
}
.search-box:focus-within { border-color: var(--color-primary-dark); }
.search-input { flex: 1; border: none; background: transparent; font-family: 'Nunito', sans-serif; font-size: .95rem; font-weight: 600; color: var(--color-text); outline: none; }
.search-input::placeholder { color: var(--color-muted); }
.search-clear { background: none; border: none; color: var(--color-muted); cursor: pointer; font-size: .85rem; padding: .2rem .4rem; border-radius: 99px; }

.recipes-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 1.25rem; }
.state-msg { text-align: center; color: var(--color-muted); font-weight: 700; padding: 3rem; }
.state-msg.error { color: #C0392B; }
.empty-state { text-align: center; padding: 3rem; color: var(--color-muted); }
.empty-state span { font-size: 3rem; display: block; margin-bottom: 1rem; }
.empty-state p { font-weight: 700; }
</style>