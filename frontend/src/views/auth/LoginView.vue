<template>
  <div class="auth-wrapper">
    <div class="auth-card">
      <div class="auth-header">
        <span class="auth-icon">🍳</span>
        <h1 class="auth-title">Recetas de Cocina</h1>
        <p class="auth-subtitle">Inicia sesión para continuar</p>
      </div>

      <form class="auth-form" @submit.prevent="handleLogin">
        <div v-if="errorMsg" class="alert alert-error">{{ errorMsg }}</div>

        <div class="form-group">
          <label for="email">Correo electrónico</label>
          <input
            id="email"
            v-model="form.email"
            type="email"
            placeholder="tu@email.com"
            required
            autocomplete="email"
          />
        </div>

        <div class="form-group">
          <label for="password">Contraseña</label>
          <input
            id="password"
            v-model="form.password"
            type="password"
            placeholder="••••••••"
            required
            autocomplete="current-password"
          />
        </div>

        <button type="submit" class="btn-primary" :disabled="loading">
          <span v-if="loading">Iniciando sesión...</span>
          <span v-else>Iniciar sesión</span>
        </button>
      </form>

      <!-- Acceso rápido como visitante -->
      <div class="guest-divider">
        <span>o</span>
      </div>
      <button @click="$router.push({ name: 'Home' })" class="btn-guest-access">
        👀 Explorar sin registrarse
      </button>

      <p class="auth-footer">
        ¿No tienes cuenta?
        <RouterLink to="/register">Regístrate aquí</RouterLink>
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../../stores/auth.store.js'

const router    = useRouter()
const authStore = useAuthStore()

const form     = ref({ email: '', password: '' })
const loading  = ref(false)
const errorMsg = ref('')

async function handleLogin() {
  errorMsg.value = ''
  loading.value  = true
  try {
    await authStore.login(form.value.email, form.value.password)
    router.push({ name: 'Home' })
  } catch (err) {
    errorMsg.value = err.response?.data?.message || 'Error al iniciar sesión.'
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
.guest-divider {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin: 1.25rem 0 .75rem;
  color: var(--color-muted);
  font-size: .85rem;
}
.guest-divider::before,
.guest-divider::after {
  content: '';
  flex: 1;
  height: 1px;
  background: var(--color-border);
}
.btn-guest-access {
  width: 100%;
  padding: .75rem;
  border-radius: 8px;
  border: 1.5px solid var(--color-border);
  background: transparent;
  color: var(--color-muted);
  font-family: 'Nunito', sans-serif;
  font-size: .9rem;
  font-weight: 700;
  cursor: pointer;
  transition: all .2s;
}
.btn-guest-access:hover { background: var(--color-primary-light); color: var(--color-primary-dark); border-color: var(--color-primary); }
.auth-footer { text-align: center; margin-top: 1.5rem; color: var(--color-muted); font-size: 0.9rem; }
.auth-footer a { color: var(--color-accent); font-weight: 600; text-decoration: none; }
</style>