<template>
  <div class="auth-wrapper">
    <div class="auth-card">
      <div class="auth-header">
        <span class="auth-icon">🍳</span>
        <h1 class="auth-title">Crear cuenta</h1>
        <p class="auth-subtitle">Únete y descubre nuevas recetas</p>
      </div>

      <form class="auth-form" @submit.prevent="handleRegister">
        <div v-if="errorMsg" class="alert alert-error">{{ errorMsg }}</div>
        <div v-if="successMsg" class="alert alert-success">{{ successMsg }}</div>

        <div class="form-group">
          <label for="name">Nombre completo</label>
          <input
            id="name"
            v-model="form.name"
            type="text"
            placeholder="Tu nombre"
            required
            minlength="2"
          />
        </div>

        <div class="form-group">
          <label for="email">Correo electrónico</label>
          <input
            id="email"
            v-model="form.email"
            type="email"
            placeholder="tu@email.com"
            required
          />
        </div>

        <div class="form-group">
          <label for="password">Contraseña</label>
          <input
            id="password"
            v-model="form.password"
            type="password"
            placeholder="Mínimo 6 caracteres"
            required
            minlength="6"
          />
          <span class="field-hint">Mínimo 6 caracteres</span>
        </div>

        <button type="submit" class="btn-primary" :disabled="loading">
          <span v-if="loading">Creando cuenta...</span>
          <span v-else>Crear cuenta</span>
        </button>
      </form>

      <p class="auth-footer">
        ¿Ya tienes cuenta?
        <RouterLink to="/login">Inicia sesión</RouterLink>
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth.store.js'

const router    = useRouter()
const authStore = useAuthStore()

const form       = ref({ name: '', email: '', password: '' })
const loading    = ref(false)
const errorMsg   = ref('')
const successMsg = ref('')

async function handleRegister() {
  errorMsg.value   = ''
  successMsg.value = ''
  loading.value    = true
  try {
    await authStore.register(form.value.name, form.value.email, form.value.password)
    successMsg.value = '¡Cuenta creada! Redirigiendo...'
    setTimeout(() => router.push({ name: 'Home' }), 1000)
  } catch (err) {
    errorMsg.value = err.response?.data?.message || 'Error al crear la cuenta.'
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.auth-wrapper {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--color-bg);
  padding: 1rem;
}
.auth-card {
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: 16px;
  padding: 2.5rem;
  width: 100%;
  max-width: 420px;
}
.auth-header { text-align: center; margin-bottom: 2rem; }
.auth-icon { font-size: 3rem; }
.auth-title { font-size: 1.6rem; font-weight: 700; margin: 0.5rem 0 0.25rem; color: var(--color-text); }
.auth-subtitle { color: var(--color-muted); font-size: 0.9rem; margin: 0; }
.auth-form { display: flex; flex-direction: column; gap: 1.25rem; }
.form-group { display: flex; flex-direction: column; gap: 0.4rem; }
.form-group label { font-size: 0.9rem; font-weight: 600; color: var(--color-text); }
.form-group input {
  padding: 0.75rem 1rem;
  border: 1.5px solid var(--color-border);
  border-radius: 8px;
  font-size: 1rem;
  background: var(--color-input);
  color: var(--color-text);
  transition: border-color 0.2s;
}
.form-group input:focus { outline: none; border-color: var(--color-accent); }
.field-hint { font-size: 0.8rem; color: var(--color-muted); }
.btn-primary {
  padding: 0.85rem;
  background: var(--color-accent);
  color: #fff;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: opacity 0.2s;
  margin-top: 0.5rem;
}
.btn-primary:disabled { opacity: 0.6; cursor: not-allowed; }
.btn-primary:hover:not(:disabled) { opacity: 0.88; }
.alert-error {
  background: #fde8e8;
  color: #c0392b;
  border: 1px solid #f5c6c6;
  border-radius: 8px;
  padding: 0.75rem 1rem;
  font-size: 0.9rem;
}
.alert-success {
  background: #e8f8ee;
  color: #1e7e3e;
  border: 1px solid #b7e4c7;
  border-radius: 8px;
  padding: 0.75rem 1rem;
  font-size: 0.9rem;
}
.auth-footer { text-align: center; margin-top: 1.5rem; color: var(--color-muted); font-size: 0.9rem; }
.auth-footer a { color: var(--color-accent); font-weight: 600; text-decoration: none; }
</style>
