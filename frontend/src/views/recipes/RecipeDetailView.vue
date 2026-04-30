<template>
  <div class="detail-page">

    <!-- Modal para visitantes sin sesión -->
    <GuestModal v-if="showGuestModal" @close="showGuestModal = false" />

    <button @click="router.back()" class="btn-back">← Volver</button>

    <p v-if="loading" class="state-msg">🍳 Cargando receta...</p>
    <p v-else-if="error" class="error">{{ error }}</p>

    <div v-else-if="recipe" class="detail-card">
      <div class="detail-hero">
        <img
          v-if="recipe.image_url"
          :src="recipe.image_url"
          :alt="recipe.title"
          class="detail-img"
        />
        <div v-else class="detail-img-placeholder">{{ categoryEmoji(recipe.category) }}</div>

        <!-- Badge de categoría sobre la imagen -->
        <span class="detail-category-badge">{{ recipe.category || 'Sin categoría' }}</span>

        <!-- Botón de favorito -->
        <button class="btn-fav-detail" @click="handleFavorite">
          {{ recipe.isFavorite ? '❤️' : '🤍' }}
        </button>
      </div>

      <div class="detail-body">
        <h1 class="detail-title">{{ recipe.title }}</h1>
        <p class="detail-author">👩‍🍳 Por <strong>{{ recipe.author }}</strong></p>
        <p class="detail-description">{{ recipe.description }}</p>

        <div class="detail-section">
          <h3>🥕 Ingredientes</h3>
          <ul v-if="recipe.ingredients?.length" class="ingredients-list">
            <li v-for="ing in recipe.ingredients" :key="ing.name">
              <span class="ing-qty">{{ ing.quantity || '' }}</span>
              <span class="ing-name">{{ ing.name }}</span>
            </li>
          </ul>
          <p v-else class="no-data">No hay ingredientes registrados.</p>
        </div>

        <div class="detail-section">
          <h3>📋 Instrucciones</h3>
          <p class="instructions">{{ recipe.instructions }}</p>
        </div>
      </div>
    </div>

  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useAuthStore } from '../../stores/auth.store.js'
import api from '../../services/api.js'
import GuestModal from '../../components/GuestModal.vue'

const route  = useRoute()
const router = useRouter()
const auth   = useAuthStore()

const recipe         = ref(null)
const loading        = ref(true)
const error          = ref(null)
const showGuestModal = ref(false)

function categoryEmoji(category) {
  const map = {
    'Desayunos': '🌅', 'Almuerzos': '🍛', 'Cenas': '🌙',
    'Sin Horno': '🔥', 'Postres': '🧁', 'Bebidas': '🥤',
    'Ensaladas': '🥗', 'Platos Principales': '🍽️', 'Comida Típica': '🇨🇴',
  }
  return map[category] || '🍴'
}

function handleFavorite() {
  if (!auth.isAuthenticated) {
    showGuestModal.value = true
    return
  }
  toggleFavorite()
}

async function toggleFavorite() {
  try {
    if (recipe.value.isFavorite) {
      await api.delete(`/recipes/${recipe.value.id}/favorites`)
      recipe.value.isFavorite = false
    } else {
      await api.post(`/recipes/${recipe.value.id}/favorites`)
      recipe.value.isFavorite = true
    }
  } catch {
    alert('Error al actualizar favoritos.')
  }
}

onMounted(async () => {
  try {
    const { data } = await api.get(`/recipes/${route.params.id}`)
    recipe.value = data.data
  } catch {
    error.value = 'Receta no encontrada.'
  } finally {
    loading.value = false
  }
})
</script>

<style scoped>
.detail-page { max-width: 800px; margin: 0 auto; padding: 2rem; }

.btn-back {
  background: none;
  border: 1.5px solid var(--color-border);
  padding: .5rem 1.1rem;
  border-radius: 99px;
  cursor: pointer;
  margin-bottom: 1.5rem;
  font-family: 'Nunito', sans-serif;
  font-weight: 700;
  color: var(--color-muted);
  transition: all .2s;
}
.btn-back:hover { background: var(--color-primary-light); color: var(--color-primary-dark); }

.detail-card {
  background: white;
  border-radius: 20px;
  box-shadow: 0 4px 24px rgba(0,0,0,.08);
  overflow: hidden;
}

.detail-hero { position: relative; }
.detail-img { width: 100%; height: 320px; object-fit: cover; display: block; }
.detail-img-placeholder {
  width: 100%; height: 200px;
  background: var(--color-primary-light);
  display: flex; align-items: center; justify-content: center;
  font-size: 5rem;
}

.detail-category-badge {
  position: absolute;
  top: 1rem; left: 1rem;
  background: white;
  color: var(--color-primary-dark);
  font-size: .75rem;
  font-weight: 800;
  text-transform: uppercase;
  letter-spacing: .5px;
  padding: .3rem .8rem;
  border-radius: 99px;
  box-shadow: 0 2px 8px rgba(0,0,0,.1);
}

.btn-fav-detail {
  position: absolute;
  top: 1rem; right: 1rem;
  background: white;
  border: none;
  font-size: 1.4rem;
  border-radius: 99px;
  width: 46px; height: 46px;
  cursor: pointer;
  box-shadow: 0 2px 12px rgba(0,0,0,.15);
  display: flex; align-items: center; justify-content: center;
  transition: transform .2s;
}
.btn-fav-detail:hover { transform: scale(1.12); }

.detail-body { padding: 2rem; }
.detail-title  { font-size: 1.9rem; font-weight: 900; color: var(--color-text); margin-bottom: .4rem; }
.detail-author { color: var(--color-muted); font-size: .95rem; margin-bottom: 1rem; }
.detail-description { color: var(--color-muted); line-height: 1.7; margin-bottom: 1.5rem; font-size: 1rem; }

.detail-section { margin-bottom: 1.75rem; }
.detail-section h3 {
  font-size: 1.1rem;
  font-weight: 800;
  color: var(--color-text);
  margin-bottom: .75rem;
  padding-bottom: .4rem;
  border-bottom: 2px solid var(--color-primary-light);
}

.ingredients-list { list-style: none; padding: 0; display: flex; flex-direction: column; gap: .5rem; }
.ingredients-list li {
  display: flex;
  align-items: center;
  gap: .75rem;
  padding: .6rem 1rem;
  background: var(--color-primary-light);
  border-radius: 10px;
  font-size: .95rem;
}
.ing-qty  { font-weight: 800; color: var(--color-primary-dark); min-width: 60px; }
.ing-name { color: var(--color-text); font-weight: 600; }

.instructions {
  white-space: pre-line;
  color: var(--color-text);
  line-height: 1.8;
  font-size: .97rem;
}
.no-data  { color: var(--color-muted); font-style: italic; }
.state-msg { text-align: center; padding: 3rem; color: var(--color-muted); font-weight: 700; }
.error    { color: #C0392B; font-weight: 700; padding: 2rem; text-align: center; }
</style>