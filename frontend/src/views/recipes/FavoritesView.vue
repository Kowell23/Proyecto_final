<template>
  <div class="favorites-page">
    <GuestModal v-if="showGuestModal" @close="showGuestModal = false" />

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
          <button @click="$router.push('/home')" class="btn-explore">Explorar recetas ✨</button>
        </div>

        <div v-else class="recipes-grid">
          <RecipeCard
            v-for="(recipe, i) in favorites"
            :key="recipe.id"
            :recipe="recipe"
            :color="CARD_COLORS[i % CARD_COLORS.length]"
            @toggle-favorite="removeFavorite"
          />
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import api from '../../services/api.js'
import { useAuthStore } from '../../stores/auth.store.js'
import GuestModal from '../../components/GuestModal.vue'
import RecipeCard from '../../components/RecipeCard.vue'

const router = useRouter()
const auth = useAuthStore()

const favorites = ref([])
const loading = ref(true)
const showGuestModal = ref(false)
const CARD_COLORS = ['#EEE6FF', '#FFEEF3', '#FFF3E8', '#E8F8EF', '#FFF8E8']

async function removeFavorite(recipe) {
  if (!auth.isAuthenticated) {
    showGuestModal.value = true
    return
  }
  try {
    await api.delete(`/recipes/${recipe.id}/favorites`)
    favorites.value = favorites.value.filter(r => r.id !== recipe.id)
  } catch { alert('Error al eliminar de favoritos.') }
}

onMounted(async () => {
  if (!auth.isAuthenticated) {
    showGuestModal.value = true
    loading.value = false
    return
  }
  try {
    const { data } = await api.get('/recipes/favorites')
    favorites.value = data.data
  } catch {
    router.push({ name: 'Login' })
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
.page-hero p  { color: var(--color-muted); font-weight: 600; }
.content { padding: 2rem; }
.state-msg { text-align: center; color: var(--color-muted); font-weight: 700; padding: 3rem; }
.recipes-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); gap: 1.25rem; }
.empty-state { text-align: center; padding: 3rem; }
.empty-state span { font-size: 3rem; display: block; margin-bottom: 1rem; }
.empty-state p { color: var(--color-muted); font-weight: 700; margin-bottom: 1.5rem; }
.btn-explore {
  background: var(--color-primary); color: white;
  border: none; padding: .75rem 1.5rem; border-radius: 99px;
  font-family: 'Nunito', sans-serif; font-size: .9rem; font-weight: 800;
  cursor: pointer; transition: transform .2s;
}
.btn-explore:hover { transform: scale(1.03); }
</style>