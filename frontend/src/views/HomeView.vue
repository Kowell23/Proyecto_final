<template>
  <div class="home-wrapper">
    <nav class="navbar">
      <div class="nav-brand">🍳 Recetas de Cocina</div>
      <div class="nav-user">
        <span class="user-badge" :class="authStore.user?.role">
          {{ authStore.user?.role === 'admin' ? '👑 Admin' : '👤 Usuario' }}
        </span>
        <span class="user-name">{{ authStore.user?.name }}</span>
        <button class="btn-logout" @click="handleLogout">Cerrar sesión</button>
      </div>
    </nav>

    <main class="home-main">
      <div class="welcome-card">
        <h2>¡Bienvenido, {{ authStore.user?.name }}! 🎉</h2>
        <p>
          Has iniciado sesión correctamente. Tu cuenta tiene el rol
          <strong>{{ authStore.user?.role }}</strong>.
        </p>
        <div class="info-grid">
          <div class="info-item">
            <span class="info-label">Email</span>
            <span class="info-value">{{ authStore.user?.email }}</span>
          </div>
          <div class="info-item">
            <span class="info-label">Rol</span>
            <span class="info-value">{{ authStore.user?.role }}</span>
          </div>
          <div class="info-item">
            <span class="info-label">Token JWT</span>
            <span class="info-value token-preview">
              {{ authStore.token?.slice(0, 30) }}...
            </span>
          </div>
        </div>

        <div class="coming-soon">
          <h3>🚧 Próximas funcionalidades</h3>
          <ul>
            <li>📋 Listado de recetas con filtro por ingredientes</li>
            <li>❤️ Marcar recetas como favoritas</li>
            <li>➕ Crear y editar recetas (solo admin)</li>
          </ul>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth.store.js'

const router    = useRouter()
const authStore = useAuthStore()

function handleLogout() {
  authStore.logout()
  router.push({ name: 'Login' })
}
</script>

<style scoped>
.home-wrapper { min-height: 100vh; background: var(--color-bg); }
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 2rem;
  background: var(--color-card);
  border-bottom: 1px solid var(--color-border);
}
.nav-brand { font-size: 1.2rem; font-weight: 700; color: var(--color-text); }
.nav-user { display: flex; align-items: center; gap: 1rem; }
.user-badge {
  padding: 0.25rem 0.75rem;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 700;
}
.user-badge.admin { background: #fef3c7; color: #92400e; }
.user-badge.user  { background: #dbeafe; color: #1e40af; }
.user-name { color: var(--color-muted); font-size: 0.9rem; }
.btn-logout {
  padding: 0.4rem 1rem;
  background: transparent;
  border: 1.5px solid var(--color-border);
  border-radius: 8px;
  color: var(--color-text);
  cursor: pointer;
  font-size: 0.9rem;
  transition: all 0.2s;
}
.btn-logout:hover { background: #fde8e8; border-color: #f5c6c6; color: #c0392b; }
.home-main { padding: 2rem; max-width: 800px; margin: 0 auto; }
.welcome-card {
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: 16px;
  padding: 2rem;
}
.welcome-card h2 { margin: 0 0 0.5rem; color: var(--color-text); font-size: 1.5rem; }
.welcome-card > p { color: var(--color-muted); margin-bottom: 1.5rem; }
.info-grid { display: grid; gap: 0.75rem; margin-bottom: 2rem; }
.info-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.75rem 1rem;
  background: var(--color-bg);
  border-radius: 8px;
  border: 1px solid var(--color-border);
}
.info-label { font-size: 0.85rem; font-weight: 600; color: var(--color-muted); }
.info-value { font-size: 0.9rem; color: var(--color-text); }
.token-preview { font-family: monospace; font-size: 0.78rem; color: var(--color-accent); }
.coming-soon {
  border-top: 1px solid var(--color-border);
  padding-top: 1.5rem;
}
.coming-soon h3 { margin: 0 0 1rem; color: var(--color-text); font-size: 1rem; }
.coming-soon ul { margin: 0; padding-left: 1.25rem; display: flex; flex-direction: column; gap: 0.5rem; }
.coming-soon li { color: var(--color-muted); font-size: 0.9rem; }
</style>
