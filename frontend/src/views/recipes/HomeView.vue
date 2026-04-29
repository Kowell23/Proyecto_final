<template>
  <div class="home">

    <GuestModal v-if="showGuestModal" @close="showGuestModal = false" />

    <!-- Hero -->
    <section class="hero">
      <div class="hero-content">
        <p class="hero-greeting">
          {{ auth.isAuthenticated ? `¡Hola, ${auth.firstName}! 🌸` : '¡Bienvenido! 👋' }}
        </p>
        <h1 class="hero-title">¿Qué cocinamos<br>hoy? 🍳</h1>
        <p class="hero-subtitle">Descubre recetas deliciosas y fáciles de preparar</p>
      </div>
      <div class="hero-decoration">
        <span class="deco deco-1">🥑</span>
        <span class="deco deco-2">🍓</span>
        <span class="deco deco-3">🧁</span>
        <span class="deco deco-4">🍋</span>
        <span class="deco deco-5">🥕</span>
      </div>
    </section>

    <!-- Búsqueda -->
    <section class="search-section">
      <div class="container">
        <div class="search-box">
          <span class="search-icon">🔍</span>
          <input
            v-model="searchQuery"
            type="text"
            class="search-input"
            placeholder="Buscar recetas por nombre, categoría o autor..."
          />
          <button v-if="searchQuery" @click="searchQuery = ''" class="search-clear">✕</button>
        </div>
      </div>
    </section>

    <!-- Filtros -->
    <section class="filters-section">
      <div class="container">
        <div class="filters">
          <button
            v-for="f in FILTERS" :key="f.value"
            class="filter-chip"
            :class="{ active: activeFilter === f.value }"
            @click="activeFilter = f.value"
          >{{ f.emoji }} {{ f.label }}</button>
        </div>
      </div>
    </section>

    <!-- Grid de recetas -->
    <section class="recipes-section">
      <div class="container">
        <div class="section-header">
          <h2>
            <template v-if="searchQuery">Resultados para "{{ searchQuery }}"</template>
            <template v-else>
              {{ activeFilter === 'all' ? 'Todas las recetas ✨' : FILTERS.find(f => f.value === activeFilter)?.label }}
            </template>
          </h2>
          <span class="count">{{ filteredRecipes.length }} recetas</span>
        </div>

        <p v-if="loading" class="state-msg">🍳 Cargando recetas...</p>
        <p v-else-if="error" class="state-msg error">{{ error }}</p>

        <div v-else-if="filteredRecipes.length === 0" class="empty-state">
          <span>🫙</span>
          <p>No se encontraron recetas.</p>
        </div>

        <!-- ✅ Se llama RecipeCard — ya no se repite el HTML de la card -->
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
    </section>

    <div v-if="auth.isAdmin" class="admin-fab" @click="$router.push('/admin')">
      🛠️ Admin
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
const activeFilter   = ref('all')
const searchQuery    = ref('')
const showGuestModal = ref(false)

const CARD_COLORS = ['#EEE6FF', '#FFEEF3', '#FFF3E8', '#E8F8EF', '#FFF8E8']
const FILTERS = [
  { value: 'all',                emoji: '✨', label: 'Todas' },
  { value: 'Desayunos',          emoji: '🌅', label: 'Desayunos' },
  { value: 'Almuerzos',          emoji: '🍛', label: 'Almuerzos' },
  { value: 'Cenas',              emoji: '🌙', label: 'Cenas' },
  { value: 'Sin Horno',          emoji: '🔥', label: 'Sin Horno' },
  { value: 'Postres',            emoji: '🧁', label: 'Postres' },
  { value: 'Bebidas',            emoji: '🥤', label: 'Bebidas' },
  { value: 'Ensaladas',          emoji: '🥗', label: 'Ensaladas' },
  { value: 'Platos Principales', emoji: '🍽️', label: 'Platos Principales' },
  { value: 'Comida Típica',      emoji: '🇨🇴', label: 'Comida Típica' },
]

const filteredRecipes = computed(() => {
  let result = recipes.value
  if (activeFilter.value !== 'all')
    result = result.filter(r => r.category === activeFilter.value)
  if (searchQuery.value.trim()) {
    const q = searchQuery.value.toLowerCase()
    result = result.filter(r =>
      r.title?.toLowerCase().includes(q)       ||
      r.description?.toLowerCase().includes(q) ||
      r.category?.toLowerCase().includes(q)    ||
      r.author?.toLowerCase().includes(q)
    )
  }
  return result
})

// Guard de favoritos: visitante → modal, usuario → API
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
.home { min-height: 100vh; }

.hero {
  background: linear-gradient(135deg, var(--color-primary-light) 0%, #FFEEF3 100%);
  padding: 3rem 2rem 2rem;
  position: relative;
  overflow: hidden;
}
.hero-content { max-width: 1200px; margin: 0 auto; position: relative; z-index: 1; }
.hero-greeting  { font-size: 1rem; font-weight: 700; color: var(--color-primary-dark); margin-bottom: .3rem; }
.hero-title     { font-size: 2.5rem; font-weight: 900; color: var(--color-text); line-height: 1.2; margin-bottom: .75rem; }
.hero-subtitle  { font-size: 1rem; color: var(--color-muted); font-weight: 600; }
.hero-decoration { position: absolute; top: 0; right: 0; bottom: 0; width: 300px; pointer-events: none; }
.deco { position: absolute; font-size: 2.5rem; animation: float 3s ease-in-out infinite; }
.deco-1 { top: 10%; right: 15%; }
.deco-2 { top: 50%; right: 5%;  animation-delay: .5s; }
.deco-3 { top: 20%; right: 35%; animation-delay: 1s; }
.deco-4 { bottom: 10%; right: 20%; animation-delay: 1.5s; }
.deco-5 { top: 60%; right: 40%; animation-delay: 2s; }
@keyframes float { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-10px); } }

.search-section { padding: 1.25rem 2rem .5rem; background: white; }
.container { max-width: 1200px; margin: 0 auto; }
.search-box {
  display: flex; align-items: center; gap: .75rem;
  background: var(--color-input);
  border: 1.5px solid var(--color-border);
  border-radius: 99px;
  padding: .6rem 1.25rem;
  transition: border-color .2s;
}
.search-box:focus-within { border-color: var(--color-primary-dark); }
.search-icon { font-size: 1rem; flex-shrink: 0; }
.search-input { flex: 1; border: none; background: transparent; font-family: 'Nunito', sans-serif; font-size: .95rem; font-weight: 600; color: var(--color-text); outline: none; }
.search-input::placeholder { color: var(--color-muted); }
.search-clear { background: none; border: none; color: var(--color-muted); cursor: pointer; font-size: .85rem; padding: .2rem .4rem; border-radius: 99px; }
.search-clear:hover { background: var(--color-border); }

.filters-section {
  padding: 1rem 2rem 1.25rem;
  background: white;
  border-bottom: 1.5px solid var(--color-border);
  position: sticky;
  top: var(--navbar-height);
  z-index: 50;
}
.filters { display: flex; gap: .5rem; flex-wrap: wrap; }
.filter-chip {
  padding: .45rem 1rem; border-radius: 99px;
  border: 1.5px solid var(--color-border);
  background: white; color: var(--color-muted);
  font-family: 'Nunito', sans-serif; font-size: .85rem; font-weight: 700;
  cursor: pointer; transition: all .2s; white-space: nowrap;
}
.filter-chip:hover  { border-color: var(--color-primary); color: var(--color-primary-dark); }
.filter-chip.active { background: var(--color-primary); border-color: var(--color-primary); color: white; }

.recipes-section { padding: 2rem; }
.section-header  { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; }
.section-header h2 { font-size: 1.3rem; font-weight: 800; color: var(--color-text); }
.count { font-size: .85rem; font-weight: 700; color: var(--color-muted); background: var(--color-primary-light); padding: .3rem .8rem; border-radius: 99px; }
.recipes-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 1.25rem; }
.state-msg { text-align: center; color: var(--color-muted); font-weight: 700; padding: 3rem; }
.state-msg.error { color: #C0392B; }
.empty-state { text-align: center; padding: 3rem; color: var(--color-muted); }
.empty-state span { font-size: 3rem; display: block; margin-bottom: 1rem; }
.empty-state p { font-weight: 700; }

.admin-fab {
  position: fixed; bottom: 2rem; right: 2rem;
  background: var(--color-primary-dark); color: white;
  padding: .75rem 1.25rem; border-radius: 99px;
  font-weight: 800; font-size: .9rem; cursor: pointer;
  box-shadow: 0 4px 20px rgba(123, 94, 167, .4);
  transition: transform .2s; z-index: 50;
}
.admin-fab:hover { transform: scale(1.05); }
</style>