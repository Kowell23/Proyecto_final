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

        <div class="nav-cards">
          <div class="nav-card" @click="router.push('/recipes')">
            <span class="nav-card-icon">📋</span>
            <h3>Ver Recetas</h3>
            <p>Explora todas las recetas disponibles y guarda tus favoritas.</p>
          </div>

          <div
            v-if="authStore.isAdmin"
            class="nav-card admin"
            @click="router.push('/admin')"
          >
            <span class="nav-card-icon">🛠️</span>
            <h3>Panel Admin</h3>
            <p>Crea, edita y elimina recetas del sistema.</p>
          </div>
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
.nav-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1rem;
  border-top: 1px solid var(--color-border);
  padding-top: 1.5rem;
}
.nav-card {
  padding: 1.5rem;
  border: 1.5px solid var(--color-border);
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.2s;
  text-align: center;
}
.nav-card:hover { border-color: var(--color-accent); transform: translateY(-2px); }
.nav-card.admin { border-color: #fef3c7; background: #fffbeb; }
.nav-card.admin:hover { border-color: #f59e0b; }
.nav-card-icon { font-size: 2rem; }
.nav-card h3 { margin: .5rem 0 .3rem; color: var(--color-text); }
.nav-card p { font-size: .85rem; color: var(--color-muted); margin: 0; }
</style>