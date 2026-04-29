<script setup>
import { ref, onMounted } from 'vue'
import api from '../services/api.js'

const recipes    = ref([])
const loading    = ref(true)
const showForm   = ref(false)
const editMode   = ref(false)
const currentId  = ref(null)
const errorMsg   = ref(null)
const successMsg = ref(null)

const form = ref({
  title: '', description: '', instructions: '',
  image_url: '', category: '', ingredients: ''
})

onMounted(loadRecipes)

async function loadRecipes() {
  loading.value = true
  try {
    const { data } = await api.get('/recipes')
    recipes.value = data.data
  } finally {
    loading.value = false
  }
}

function openCreate() {
  editMode.value  = false
  currentId.value = null
  form.value = { title: '', description: '', instructions: '', image_url: '', category: '', ingredients: '' }
  showForm.value  = true
  errorMsg.value  = null
}

function openEdit(recipe) {
  editMode.value  = true
  currentId.value = recipe.id
  form.value = {
    title:        recipe.title,
    description:  recipe.description || '',
    instructions: recipe.instructions,
    image_url:    recipe.image_url || '',
    category:     recipe.category || '',
    ingredients:  ''
  }
  showForm.value = true
  errorMsg.value = null
}

async function submitForm() {
  errorMsg.value   = null
  successMsg.value = null

  const ingredients = form.value.ingredients
    ? form.value.ingredients.split(',').map(i => {
        const [name, quantity] = i.split(':')
        return { name: name?.trim(), quantity: quantity?.trim() || '' }
      })
    : []

  const payload = { ...form.value, ingredients }

  try {
    if (editMode.value) {
      await api.put(`/recipes/${currentId.value}`, payload)
      successMsg.value = '✅ Receta actualizada.'
    } else {
      await api.post('/recipes', payload)
      successMsg.value = '✅ Receta creada.'
    }
    showForm.value = false
    await loadRecipes()
  } catch (err) {
    errorMsg.value = err.response?.data?.message || 'Error al guardar.'
  }
}

async function deleteRecipe(id) {
  if (!confirm('¿Eliminar esta receta?')) return
  try {
    await api.delete(`/recipes/${id}`)
    successMsg.value = '✅ Receta eliminada.'
    await loadRecipes()
  } catch {
    errorMsg.value = 'Error al eliminar.'
  }
}
</script>

<template>
  <div class="admin-page">
    <div class="admin-header">
      <h1>🛠️ Panel de Administración</h1>
      <button @click="openCreate" class="btn-create">+ Nueva Receta</button>
    </div>

    <p v-if="successMsg" class="success">{{ successMsg }}</p>
    <p v-if="errorMsg"   class="error">{{ errorMsg }}</p>

    <!-- Formulario crear/editar -->
    <div v-if="showForm" class="form-card">
      <h2>{{ editMode ? 'Editar Receta' : 'Nueva Receta' }}</h2>
      <input v-model="form.title"        placeholder="Título *" />
      <input v-model="form.category"     placeholder="Categoría" />
      <input v-model="form.image_url"    placeholder="URL de imagen" />
      <textarea v-model="form.description"  placeholder="Descripción" rows="2" />
      <textarea v-model="form.instructions" placeholder="Instrucciones *" rows="4" />
      <input v-model="form.ingredients"  placeholder="Ingredientes: Arroz:2 tazas, Pollo:500g" />
      <div class="form-actions">
        <button @click="submitForm"       class="btn-save">Guardar</button>
        <button @click="showForm = false" class="btn-cancel">Cancelar</button>
      </div>
    </div>

    <!-- Tabla -->
    <p v-if="loading">Cargando...</p>
    <table v-else class="recipes-table">
      <thead>
        <tr><th>ID</th><th>Título</th><th>Categoría</th><th>Autor</th><th>Acciones</th></tr>
      </thead>
      <tbody>
        <tr v-for="recipe in recipes" :key="recipe.id">
          <td>{{ recipe.id }}</td>
          <td>{{ recipe.title }}</td>
          <td>{{ recipe.category || '—' }}</td>
          <td>{{ recipe.author }}</td>
          <td>
            <button @click="openEdit(recipe)"         class="btn-edit">✏️</button>
            <button @click="deleteRecipe(recipe.id)"  class="btn-delete">🗑️</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<style scoped>
.admin-page { max-width: 1000px; margin: 0 auto; padding: 2rem; }
.admin-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; }
.btn-create { background: var(--color-primary-dark); color: white; border: none; padding: .6rem 1.2rem; border-radius: 8px; cursor: pointer; font-family: 'Nunito', sans-serif; font-weight: 700; }
.form-card { background: white; border-radius: 12px; padding: 1.5rem; box-shadow: 0 2px 8px rgba(0,0,0,.1); margin-bottom: 2rem; display: flex; flex-direction: column; gap: .8rem; }
.form-card input, .form-card textarea { padding: .6rem; border: 1.5px solid var(--color-border); border-radius: 8px; font-size: .95rem; width: 100%; font-family: 'Nunito', sans-serif; box-sizing: border-box; }
.form-card input:focus, .form-card textarea:focus { outline: none; border-color: var(--color-primary-dark); }
.form-actions { display: flex; gap: 1rem; }
.btn-save   { background: #16a34a; color: white; border: none; padding: .6rem 1.2rem; border-radius: 8px; cursor: pointer; font-family: 'Nunito', sans-serif; font-weight: 700; }
.btn-cancel { background: #e5e7eb; border: none; padding: .6rem 1.2rem; border-radius: 8px; cursor: pointer; font-family: 'Nunito', sans-serif; font-weight: 700; }
.recipes-table { width: 100%; border-collapse: collapse; background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,.1); }
th { background: var(--color-primary-dark); color: white; padding: .8rem 1rem; text-align: left; }
td { padding: .8rem 1rem; border-bottom: 1px solid #f0f0f0; }
.btn-edit   { background: none; border: none; cursor: pointer; font-size: 1.1rem; margin-right: .5rem; }
.btn-delete { background: none; border: none; cursor: pointer; font-size: 1.1rem; }
.success { color: #16a34a; font-weight: 700; margin-bottom: 1rem; }
.error   { color: #C0392B; font-weight: 700; margin-bottom: 1rem; }
</style>