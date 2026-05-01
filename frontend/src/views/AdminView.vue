<script setup>
import { ref, onMounted } from 'vue'
import api from '../services/api.js'

const activeTab = ref('recipes')
const loading = ref(true)

const recipes = ref([])
const users = ref([])
const showForm = ref(false)
const editMode = ref(false)
const currentId = ref(null)
const errorMsg = ref(null)
const successMsg = ref(null)

const form = ref({
  title: '', description: '', instructions: '',
  image_url: '', category: '', ingredients: ''
})

onMounted(loadData)

async function loadData() {
  loading.value = true
  try {
    if (activeTab.value === 'recipes') {
      const { data } = await api.get('/recipes')
      recipes.value = data.data
    } else if (activeTab.value === 'users') {
      const { data } = await api.get('/users')
      users.value = data.data
    }
  } finally {
    loading.value = false
  }
}

function switchTab(tab) {
  activeTab.value = tab
  loadData()
}

function openCreate() {
  editMode.value = false
  currentId.value = null
  form.value = { title: '', description: '', instructions: '', image_url: '', category: '', ingredients: '' }
  showForm.value = true
  errorMsg.value = null
}

function openEdit(recipe) {
  editMode.value = true
  currentId.value = recipe.id
  form.value = {
    title: recipe.title,
    description: recipe.description || '',
    instructions: recipe.instructions,
    image_url: recipe.image_url || '',
    category: recipe.category || '',
    ingredients: ''
  }
  showForm.value = true
  errorMsg.value = null
}

async function submitForm() {
  errorMsg.value = null
  successMsg.value = null

  const payload = { ...form.value }

  try {
    if (editMode.value) {
      await api.put(`/recipes/${currentId.value}`, payload)
      successMsg.value = 'Receta actualizada.'
    } else {
      await api.post('/recipes', payload)
      successMsg.value = 'Receta creada.'
    }
    showForm.value = false
    await loadData()
  } catch (err) {
    errorMsg.value = err.response?.data?.message || 'Error al guardar.'
  }
}

async function deleteRecipe(id) {
  if (!confirm('¿Eliminar esta receta?')) return
  try {
    await api.delete(`/recipes/${id}`)
    successMsg.value = 'Receta eliminada.'
    await loadData()
  } catch {
    errorMsg.value = 'Error al eliminar.'
  }
}

async function toggleBan(user) {
  try {
    await api.put(`/users/${user.id}/ban`)
    user.is_banned = !user.is_banned
    successMsg.value = user.is_banned ? 'Usuario baneado.' : 'Usuario desbaneado.'
  } catch {
    errorMsg.value = 'Error al cambiar estado.'
  }
}

async function deleteUser(id) {
  if (!confirm('¿Eliminar este usuario?')) return
  try {
    await api.delete(`/users/${id}`)
    successMsg.value = 'Usuario eliminado.'
    await loadData()
  } catch {
    errorMsg.value = 'Error al eliminar.'
  }
}
</script>

<template>
  <div class="admin-page">
    <div class="admin-header">
      <h1>🛠️ Panel de Administración</h1>
    </div>

    <div class="tabs">
      <button @click="switchTab('recipes')" :class="{ active: activeTab === 'recipes' }">Recetas</button>
      <button @click="switchTab('users')"    :class="{ active: activeTab === 'users' }">Usuarios</button>
    </div>

    <p v-if="successMsg" class="success" @click="successMsg = null">{{ successMsg }} ✕</p>
    <p v-if="errorMsg"   class="error"   @click="errorMsg = null">{{ errorMsg }} ✕</p>

    <!-- RECETAS -->
    <template v-if="activeTab === 'recipes'">
      <div class="toolbar">
        <button @click="openCreate" class="btn-create">+ Nueva Receta</button>
      </div>

      <div v-if="showForm" class="form-card">
        <h2>{{ editMode ? 'Editar Receta' : 'Nueva Receta' }}</h2>
        <input v-model="form.title"        placeholder="Título *" />
        <input v-model="form.category"     placeholder="Categoría" />
        <input v-model="form.image_url"    placeholder="URL de imagen" />
        <textarea v-model="form.description"  placeholder="Descripción" rows="2" />
        <textarea v-model="form.instructions" placeholder="Instrucciones *" rows="4" />
        <div class="form-actions">
          <button @click="submitForm"       class="btn-save">Guardar</button>
          <button @click="showForm = false" class="btn-cancel">Cancelar</button>
        </div>
      </div>

      <p v-if="loading">Cargando...</p>
      <table v-else class="table">
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
              <button @click="openEdit(recipe)"         class="btn-icon">✏️</button>
              <button @click="deleteRecipe(recipe.id)"  class="btn-icon">🗑️</button>
            </td>
          </tr>
        </tbody>
      </table>
    </template>

    <!-- USUARIOS -->
    <template v-if="activeTab === 'users'">
      <p v-if="loading">Cargando...</p>
      <table v-else class="table">
        <thead>
          <tr><th>ID</th><th>Nombre</th><th>Email</th><th>Rol</th><th>Estado</th><th>Acciones</th></tr>
        </thead>
        <tbody>
          <tr v-for="user in users" :key="user.id">
            <td>{{ user.id }}</td>
            <td>{{ user.name }}</td>
            <td>{{ user.email }}</td>
            <td><span class="badge" :class="user.role">{{ user.role }}</span></td>
            <td><span class="badge" :class="user.is_banned ? 'banned' : 'active'">{{ user.is_banned ? 'Baneado' : 'Activo' }}</span></td>
            <td>
              <button @click="toggleBan(user)"  class="btn-icon" :title="user.is_banned ? 'Desbanear' : 'Banear'">{{ user.is_banned ? '✅' : '🚫' }}</button>
              <button @click="deleteUser(user.id)" class="btn-icon" title="Eliminar">🗑️</button>
            </td>
          </tr>
        </tbody>
      </table>
    </template>
  </div>
</template>

<style scoped>
.admin-page { max-width: 1100px; margin: 0 auto; padding: 2rem; }
.admin-header { margin-bottom: 1.5rem; }
.admin-header h1 { font-size: 1.8rem; font-weight: 900; color: var(--color-text); }

.tabs { display: flex; gap: .5rem; margin-bottom: 1.5rem; }
.tabs button {
  padding: .6rem 1.5rem; border: none; border-radius: 8px 8px 0 0;
  background: var(--color-primary-light); color: var(--color-muted);
  font-family: 'Nunito', sans-serif; font-weight: 700; cursor: pointer;
}
.tabs button.active { background: var(--color-primary-dark); color: white; }

.toolbar { margin-bottom: 1rem; }
.btn-create { background: var(--color-primary-dark); color: white; border: none; padding: .6rem 1.2rem; border-radius: 8px; cursor: pointer; font-family: 'Nunito', sans-serif; font-weight: 700; }

.form-card { background: white; border-radius: 12px; padding: 1.5rem; box-shadow: 0 2px 8px rgba(0,0,0,.1); margin-bottom: 1.5rem; display: flex; flex-direction: column; gap: .8rem; }
.form-card input, .form-card textarea { padding: .6rem; border: 1.5px solid var(--color-border); border-radius: 8px; font-size: .95rem; width: 100%; font-family: 'Nunito', sans-serif; box-sizing: border-box; }
.form-actions { display: flex; gap: 1rem; }
.btn-save   { background: #16a34a; color: white; border: none; padding: .6rem 1.2rem; border-radius: 8px; cursor: pointer; font-family: 'Nunito', sans-serif; font-weight: 700; }
.btn-cancel { background: #e5e7eb; border: none; padding: .6rem 1.2rem; border-radius: 8px; cursor: pointer; font-family: 'Nunito', sans-serif; font-weight: 700; }

.table { width: 100%; border-collapse: collapse; background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,.1); }
th { background: var(--color-primary-dark); color: white; padding: .8rem 1rem; text-align: left; font-size: .85rem; }
td { padding: .8rem 1rem; border-bottom: 1px solid #f0f0f0; }
.btn-icon { background: none; border: none; cursor: pointer; font-size: 1.1rem; margin-right: .5rem; }
.badge { display: inline-block; padding: .2rem .6rem; border-radius: 99px; font-size: .75rem; font-weight: 700; text-transform: uppercase; }
.badge.admin { background: #FFF3E8; color: #C27A2E; }
.badge.moderator { background: #E8F8EF; color: #16a34a; }
.badge.user { background: var(--color-primary-light); color: var(--color-primary-dark); }
.badge.active { background: #dcfce7; color: #16a34a; }
.badge.banned { background: #FEE2E2; color: #C0392B; }

.success { color: #16a34a; font-weight: 700; margin-bottom: 1rem; cursor: pointer; }
.error   { color: #C0392B; font-weight: 700; margin-bottom: 1rem; cursor: pointer; }
</style>