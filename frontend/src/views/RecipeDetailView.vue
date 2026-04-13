<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import api from '../services/api.js'

const route   = useRoute()
const router  = useRouter()
const recipe  = ref(null)
const loading = ref(true)
const error   = ref(null)

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

<template>
  <div class="detail-page">
    <button @click="router.back()" class="btn-back">← Volver</button>

    <p v-if="loading">Cargando...</p>
    <p v-else-if="error" class="error">{{ error }}</p>

    <div v-else class="detail-card">
      <img v-if="recipe.image_url" :src="recipe.image_url" :alt="recipe.title" class="detail-img" />

      <div class="detail-body">
        <span class="category">{{ recipe.category || 'Sin categoría' }}</span>
        <h1>{{ recipe.title }}</h1>
        <p class="author">Por <strong>{{ recipe.author }}</strong></p>
        <p class="description">{{ recipe.description }}</p>

        <h3>🥕 Ingredientes</h3>
        <ul v-if="recipe.ingredients?.length">
          <li v-for="ing in recipe.ingredients" :key="ing.name">
            {{ ing.quantity ? `${ing.quantity} de ` : '' }}{{ ing.name }}
          </li>
        </ul>
        <p v-else>No hay ingredientes registrados.</p>

        <h3>📋 Instrucciones</h3>
        <p class="instructions">{{ recipe.instructions }}</p>
      </div>
    </div>
  </div>
</template>

<style scoped>
.detail-page { max-width: 800px; margin: 0 auto; padding: 2rem; }
.btn-back { background: none; border: 1px solid #ccc; padding: .5rem 1rem; border-radius: 8px; cursor: pointer; margin-bottom: 1.5rem; }
.detail-card { background: white; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,.1); overflow: hidden; }
.detail-img { width: 100%; height: 300px; object-fit: cover; }
.detail-body { padding: 2rem; }
.category { font-size: .8rem; color: #7c3aed; font-weight: 700; text-transform: uppercase; }
h1 { margin: .5rem 0; }
.author { color: #777; margin-bottom: 1rem; }
.description { color: #555; margin-bottom: 1.5rem; }
h3 { margin: 1.5rem 0 .5rem; color: #333; }
ul { padding-left: 1.2rem; }
li { margin-bottom: .3rem; }
.instructions { white-space: pre-line; color: #444; line-height: 1.7; }
.error { color: red; }
</style>