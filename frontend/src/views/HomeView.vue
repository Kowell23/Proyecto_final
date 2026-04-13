<template>
  <div class="home">

    <!-- Hero -->
    <section class="hero">
      <div class="hero-content">
        <p class="hero-greeting">¡Hola, {{ auth.user?.name?.split(' ')[0] }}! 🌸</p>
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

    <!-- Filtros -->
    <section class="filters-section">
      <div class="container">
        <div class="filters">
          <button
            v-for="f in filters"
            :key="f.value"
            class="filter-chip"
            :class="{ active: activeFilter === f.value }"
            @click="activeFilter = f.value"
          >
            {{ f.emoji }} {{ f.label }}
          </button>
        </div>
      </div>
    </section>

    <!-- Recetas -->
    <section class="recipes-section">
      <div class="container">
        <div class="section-header">
          <h2>{{ activeFilter === 'all' ? 'Todas las recetas ✨' : filters.find(f => f.value === activeFilter)?.label }}</h2>
          <span class="count">{{ filteredRecipes.length }} recetas</span>
        </div>

        <p v-if="loading" class="state-msg">🍳 Cargando recetas...</p>
        <p v-else-if="error" class="state-msg error">{{ error }}</p>

        <div v-else-if="filteredRecipes.length === 0" class="empty-state">
          <span>🫙</span>
          <p>No hay recetas en esta categoría todavía.</p>
        </div>

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
              <button class="btn-fav" @click.stop="toggleFavorite(recipe)">
                {{ recipe.isFavorite ? '❤️' : '🤍' }}
              </button>
            </div>
            <img v-if="recipe.image_url" :src="recipe.image_url" :alt="recipe.title" class="card-img" />
            <div class="card-body">
              <span class="card-category">{{ recipe.category || 'Receta' }}</span>
              <h3 class="card-title">{{ recipe.title }}</h3>
              <p class="card-desc">{{ recipe.description || 'Una deliciosa receta.' }}</p>
              <div class="card-footer">
                <span class="card-author">👩‍🍳 {{ recipe.author }}</span>
                <span class="card-arrow">→</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- FAB Admin -->
    <div v-if="auth.isAdmin" class="admin-fab" @click="$router.push('/admin')">
      🛠️ Admin
    </div>

  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useAuthStore } from '../stores/auth.store.js'
import api from '../services/api.js'

const auth         = useAuthStore()
const recipes      = ref([])
const loading      = ref(true)
const error        = ref(null)
const activeFilter = ref('all')

const filters = [
  { value: 'all',              emoji: '✨', label: 'Todas' },
  { value: 'Desayunos',        emoji: '🌅', label: 'Desayunos' },
  { value: 'Almuerzos',        emoji: '🍛', label: 'Almuerzos' },
  { value: 'Cenas',            emoji: '🌙', label: 'Cenas' },
  { value: 'Sin Horno',        emoji: '🔥', label: 'Sin Horno' },
  { value: 'Postres',          emoji: '🧁', label: 'Postres' },
  { value: 'Bebidas',          emoji: '🥤', label: 'Bebidas' },
  { value: 'Ensaladas',        emoji: '🥗', label: 'Ensaladas' },
  { value: 'Platos Principales', emoji: '🍽️', label: 'Platos Principales' },
  { value: 'Comida Típica',    emoji: '🇨🇴', label: 'Comida Típica' },
]

const cardColors = ['#EEE6FF', '#FFEEF3', '#FFF3E8', '#E8F8EF', '#FFF8E8']

const filteredRecipes = computed(() => {
  if (activeFilter.value === 'all') return recipes.value
  return recipes.value.filter(r => r.category === activeFilter.value)
})

function categoryEmoji(category) {
  const map = {
    'Desayunos': '🌅', 'Almuerzos': '🍛', 'Cenas': '🌙',
    'Sin Horno': '🔥', 'Postres': '🧁', 'Bebidas': '🥤',
    'Ensaladas': '🥗', 'Platos Principales': '🍽️', 'Comida Típica': '🇨🇴'
  }
  return map[category] || '🍴'
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
.home { min-height: 100vh; }

/* Hero */
.hero {
  background: linear-gradient(135deg, var(--color-primary-light) 0%, #FFEEF3 100%);
  padding: 3rem 2rem 2rem;
  position: relative;
  overflow: hidden;
}
.hero-content { max-width: 1200px; margin: 0 auto; position: relative; z-index: 1; }
.hero-greeting { font-size: 1rem; font-weight: 700; color: var(--color-primary-dark); margin-bottom: .3rem; }
.hero-title { font-size: 2.5rem; font-weight: 900; color: var(--color-text); line-height: 1.2; margin-bottom: .75rem; }
.hero-subtitle { font-size: 1rem; color: var(--color-muted); font-weight: 600; }
.hero-decoration { position: absolute; top: 0; right: 0; bottom: 0; width: 300px; pointer-events: none; }
.deco { position: absolute; font-size: 2.5rem; animation: float 3s ease-in-out infinite; }
.deco-1 { top: 10%; right: 15%; animation-delay: 0s; }
.deco-2 { top: 50%; right: 5%;  animation-delay: .5s; }
.deco-3 { top: 20%; right: 35%; animation-delay: 1s; }
.deco-4 { bottom: 10%; right: 20%; animation-delay: 1.5s; }
.deco-5 { top: 60%; right: 40%; animation-delay: 2s; }
@keyframes float {
  0%, 100% { transform: translateY(0); }
  50%       { transform: translateY(-10px); }
}

/* Filtros */
.filters-section {
  padding: 1.25rem 2rem;
  background: white;
  border-bottom: 1.5px solid var(--color-border);
  position: sticky;
  top: var(--navbar-height);
  z-index: 50;
}
.container { max-width: 1200px; margin: 0 auto; }
.filters { display: flex; gap: .5rem; flex-wrap: wrap; }
.filter-chip {
  padding: .45rem 1rem;
  border-radius: 99px;
  border: 1.5px solid var(--color-border);
  background: white;
  color: var(--color-muted);
  font-family: 'Nunito', sans-serif;
  font-size: .85rem;
  font-weight: 700;
  cursor: pointer;
  transition: all .2s;
  white-space: nowrap;
}
.filter-chip:hover  { border-color: var(--color-primary); color: var(--color-primary-dark); }
.filter-chip.active { background: var(--color-primary); border-color: var(--color-primary); color: white; }

/* Grid de recetas */
.recipes-section { padding: 2rem; }
.section-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; }
.section-header h2 { font-size: 1.3rem; font-weight: 800; color: var(--color-text); }
.count { font-size: .85rem; font-weight: 700; color: var(--color-muted); background: var(--color-primary-light); padding: .3rem .8rem; border-radius: 99px; }

.recipes-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 1.25rem; }

.recipe-card {
  background: var(--card-color, #EEE6FF);
  border-radius: 20px;
  overflow: hidden;
  cursor: pointer;
  transition: transform .2s, box-shadow .2s;
  position: relative;
}
.recipe-card:hover { transform: translateY(-4px); box-shadow: 0 12px 30px rgba(0,0,0,.1); }

.card-top { display: flex; justify-content: space-between; align-items: center; padding: 1rem 1rem .5rem; }
.card-emoji { font-size: 2rem; }
.btn-fav {
  background: white;
  border: none;
  font-size: 1.2rem;
  border-radius: 99px;
  width: 34px; height: 34px;
  cursor: pointer;
  box-shadow: 0 2px 8px rgba(0,0,0,.1);
  display: flex; align-items: center; justify-content: center;
}

.card-img { width: 100%; height: 150px; object-fit: cover; }

.card-body { padding: 1rem; background: white; margin: .5rem; border-radius: 14px; }
.card-category { font-size: .72rem; font-weight: 800; color: var(--color-primary-dark); text-transform: uppercase; letter-spacing: .5px; }
.card-title { font-size: 1.05rem; font-weight: 800; color: var(--color-text); margin: .25rem 0 .4rem; }
.card-desc { font-size: .83rem; color: var(--color-muted); line-height: 1.4; margin-bottom: .75rem; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
.card-footer { display: flex; justify-content: space-between; align-items: center; }
.card-author { font-size: .8rem; font-weight: 700; color: var(--color-muted); }
.card-arrow { font-weight: 800; color: var(--color-primary-dark); }

.state-msg { text-align: center; color: var(--color-muted); font-weight: 700; padding: 3rem; font-size: 1rem; }
.state-msg.error { color: #C0392B; }
.empty-state { text-align: center; padding: 3rem; color: var(--color-muted); }
.empty-state span { font-size: 3rem; display: block; margin-bottom: 1rem; }
.empty-state p { font-weight: 700; }

.admin-fab {
  position: fixed;
  bottom: 2rem; right: 2rem;
  background: var(--color-primary-dark);
  color: white;
  padding: .75rem 1.25rem;
  border-radius: 99px;
  font-weight: 800;
  font-size: .9rem;
  cursor: pointer;
  box-shadow: 0 4px 20px rgba(123,94,167,.4);
  transition: transform .2s;
  z-index: 50;
}
.admin-fab:hover { transform: scale(1.05); }
</style>