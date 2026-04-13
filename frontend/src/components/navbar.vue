<template>
  <nav class="navbar">
    <div class="nav-container">
      <router-link to="/home" class="nav-brand">
        <span class="brand-emoji">🍳</span>
        <span class="brand-text">Sazón de la Chef</span>
      </router-link>

      <div class="nav-links">
        <router-link to="/home"      class="nav-link" active-class="active">🏠 Inicio</router-link>
        <router-link to="/home"      class="nav-link">🍽️ Recetas</router-link>
        <router-link to="/favorites" class="nav-link" active-class="active">❤️ Mis Favoritas</router-link>
        <router-link to="/profile"   class="nav-link" active-class="active">👤 Perfil</router-link>
      </div>

      <div class="nav-user">
        <span class="user-chip" :class="auth.user?.role">
          {{ auth.user?.role === 'admin' ? '👑' : '🌸' }}
          {{ auth.user?.name?.split(' ')[0] }}
        </span>
        <button @click="handleLogout" class="btn-logout">Salir</button>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth.store.js'

const router = useRouter()
const auth   = useAuthStore()

function handleLogout() {
  auth.logout()
  router.push({ name: 'Login' })
}
</script>

<style scoped>
.navbar {
  position: fixed;
  top: 0; left: 0; right: 0;
  height: var(--navbar-height);
  background: rgba(255, 255, 255, 0.88);
  backdrop-filter: blur(14px);
  border-bottom: 1.5px solid var(--color-border);
  z-index: 100;
}
.nav-container {
  max-width: 1200px;
  margin: 0 auto;
  height: 100%;
  padding: 0 2rem;
  display: flex;
  align-items: center;
  gap: 2rem;
}
.nav-brand {
  display: flex;
  align-items: center;
  gap: .5rem;
  text-decoration: none;
  flex-shrink: 0;
}
.brand-emoji { font-size: 1.5rem; }
.brand-text {
  font-size: 1.05rem;
  font-weight: 900;
  color: var(--color-primary-dark);
  letter-spacing: -.3px;
}
.nav-links {
  display: flex;
  gap: .25rem;
  flex: 1;
}
.nav-link {
  padding: .45rem 1rem;
  border-radius: 99px;
  font-size: .88rem;
  font-weight: 700;
  color: var(--color-muted);
  text-decoration: none;
  transition: all .2s;
}
.nav-link:hover, .nav-link.active {
  background: var(--color-primary-light);
  color: var(--color-primary-dark);
}
.nav-user { display: flex; align-items: center; gap: .75rem; flex-shrink: 0; }
.user-chip {
  padding: .35rem .9rem;
  border-radius: 99px;
  font-size: .85rem;
  font-weight: 800;
  background: var(--color-primary-light);
  color: var(--color-primary-dark);
}
.user-chip.admin { background: #FFF3E8; color: #C27A2E; }
.btn-logout {
  padding: .35rem .9rem;
  border-radius: 99px;
  border: 1.5px solid var(--color-border);
  background: transparent;
  color: var(--color-muted);
  font-family: 'Nunito', sans-serif;
  font-size: .85rem;
  font-weight: 700;
  cursor: pointer;
  transition: all .2s;
}
.btn-logout:hover { background: #FFEEF3; border-color: #F5B8C8; color: #C0392B; }
</style>