<template>
  <div class="favorites-page">
    <section class="page-hero">
      <div class="container">
        <h1>❤️ Mis Favoritas</h1>
        <p>Las recetas que más te encantan</p>
      </div>
    </section>

    <section class="content">
      <div class="container">
        <p v-if="loading" class="state-msg">Cargando favoritas... 🍳</p>

        <div v-else-if="favorites.length === 0" class="empty-state">
          <span>🤍</span>
          <p>Aún no tienes recetas favoritas.</p>
          <button @click="$router.push('/home')" class="btn-explore">
            Explorar recetas ✨
          </button>
        </div>

        <div v-else class="recipes-grid">
          <div
            v-for="(recipe, i) in favorites"
            :key="recipe.id"
            class="recipe-card"
            :style="{ '--card-color': cardColors[i % cardColors.length] }"
            @click="$router.push(`/recipes/${recipe.id}`)"
          >
            <div class="card-top">
              <div class="card-emoji">{{ categoryEmoji(recipe.category) }}</div>
              <span class="fav-badge">❤️</span>
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
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import api from '../services/api.js'

const favorites  = ref([])
const loading    = ref(true)
const cardColors = ['#EEE6FF', '#FFEEF3', '#FFF3E8', '#E8F8EF', '#FFF8E8']

function categoryEmoji(category) {
  const map = {
    'Desayunos': '🌅', 'Almuerzos': '🍛', 'Cenas': '🌙',
    'Sin Horno': '🔥', 'Postres': '🧁', 'Bebidas': '🥤',
    'Ensaladas': '🥗', 'Platos Principales': '🍽️', 'Comida Típica': '🇨🇴'
  }
  return map[category] || '🍴'
}

onMounted(async () => {
  try {
    const { data } = await api.get('/recipes/favorites')
    favorites.value = data.data
  } finally {
    loading.value = false
  }
})
</script>

<style scoped>
.favorites-page { min-height: 100vh; }
.page-hero {
  background: linear-gradient(135deg, #FFEEF3 0%, var(--color-primary-light) 100%);
  padding: 2.5rem 2rem;
}
.container { max-width: 1200px; margin: 0 auto; }
.page-hero h1 { font-size: 2rem; font-weight: 900; color: var(--color-text); margin-bottom: .3rem; }
.page-hero p { color: var(--color-muted); font-weight: 600; }
.content { padding: 2rem; }

.state-msg { text-align: center; color: var(--color-muted); font-weight: 700; padding: 3rem; }
.empty-state { text-align: center; padding: 3rem; }
.empty-state span { font-size: 3rem; display: block; margin-bottom: 1rem; }
.empty-state p { color: var(--color-muted); font-weight: 700; margin-bottom: 1.5rem; }
.btn-explore {
  background: var(--color-primary);
  color: white;
  border: none;
  padding: .75rem 1.5rem;
  border-radius: 99px;
  font-family: 'Nunito', sans-serif;
  font-size: .9rem;
  font-weight: 800;
  cursor: pointer;
  transition: transform .2s;
}
.btn-explore:hover { transform: scale(1.03); }

.recipes-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 1.25rem; }
.recipe-card {
  background: var(--card-color, #EEE6FF);
  border-radius: 20px;
  overflow: hidden;
  cursor: pointer;
  transition: transform .2s, box-shadow .2s;
}
.recipe-card:hover { transform: translateY(-4px); box-shadow: 0 12px 30px rgba(0,0,0,.1); }
.card-top { display: flex; justify-content: space-between; align-items: center; padding: 1rem 1rem .5rem; }
.card-emoji { font-size: 2rem; }
.fav-badge { font-size: 1.3rem; }
.card-img { width: 100%; height: 150px; object-fit: cover; }
.card-body { padding: 1rem; background: white; margin: .5rem; border-radius: 14px; }
.card-category { font-size: .72rem; font-weight: 800; color: var(--color-primary-dark); text-transform: uppercase; letter-spacing: .5px; }
.card-title { font-size: 1rem; font-weight: 800; color: var(--color-text); margin: .25rem 0 .4rem; }
.card-desc { font-size: .83rem; color: var(--color-muted); line-height: 1.4; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; margin-bottom: .75rem; }
.card-footer { display: flex; justify-content: space-between; align-items: center; }
.card-author { font-size: .8rem; font-weight: 700; color: var(--color-muted); }
.card-arrow { font-weight: 800; color: var(--color-primary-dark); }
</style>