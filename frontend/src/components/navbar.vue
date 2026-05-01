<template>
  <nav class="navbar">
    <div class="nav-container">

      <!-- Logo → siempre va a inicio -->
      <button class="nav-brand" @click="navigateTo('inicio')">
        <span class="brand-emoji">🍳</span>
        <span class="brand-text">Recetas de Cocina</span>
      </button>

      <!-- Links de navegación -->
      <div class="nav-links">
        <!-- Públicos: cualquier visitante -->
        <button
          class="nav-link"
          :class="{ active: nav.currentSection === 'inicio' && isHome }"
          @click="navigateTo('inicio')"
        >🏠 Inicio</button>

        <button
          class="nav-link"
          :class="{ active: nav.currentSection === 'recetas' && isHome }"
          @click="navigateTo('recetas')"
        >🍽️ Recetas</button>

        <!-- Protegidos: solo user y admin -->
        <button
          v-if="auth.isAuthenticated"
          class="nav-link"
          :class="{ active: nav.currentSection === 'favoritas' && isHome }"
          @click="navigateTo('favoritas')"
        >❤️ Favoritas</button>

        <button
          v-if="auth.isAuthenticated"
          class="nav-link"
          :class="{ active: nav.currentSection === 'perfil' && isHome }"
          @click="navigateTo('perfil')"
        >👤 Perfil</button>

        <!-- Solo admin y moderador -->
        <button
          v-if="auth.isAdmin || auth.isModerator"
          class="nav-link nav-link--admin"
          :class="{ active: route.name === 'Admin' }"
          @click="$router.push({ name: 'Admin' })"
        >🛠️ Admin</button>
      </div>

      <!-- Zona de usuario -->
      <div class="nav-user">
        <!-- Con sesión -->
        <template v-if="auth.isAuthenticated">
          <div class="user-chip" :class="auth.user?.role">
            <span class="user-avatar">{{ auth.initials }}</span>
            <span class="user-name">{{ auth.firstName }}</span>
            <span class="role-badge" :class="auth.user?.role">
              {{ auth.isAdmin ? 'Admin' : 'User' }}
            </span>
          </div>
          <button @click="handleLogout" class="btn-logout">Salir</button>
        </template>

        <!-- Sin sesión (visitante) -->
        <template v-else>
          <RouterLink to="/login"    class="btn-guest btn-login">Iniciar sesión</RouterLink>
          <RouterLink to="/register" class="btn-guest btn-register">Registrarse</RouterLink>
        </template>
      </div>

    </div>
  </nav>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useAuthStore }       from '../stores/auth.store.js'
import { useNavigationStore } from '../stores/navigation.store.js'

const route  = useRoute()
const router = useRouter()
const auth   = useAuthStore()
const nav    = useNavigationStore()

// Saber si estamos en la ruta /home para activar los links correctos
const isHome = computed(() => route.name === 'Home')

function navigateTo(section) {
  // Solo perfil requiere sesión obligatoriamente
  if (section === 'perfil' && !auth.isAuthenticated) {
    router.push({ name: 'Login' })
    return
  }
  // Cambia la sección en el store
  nav.goTo(section)
  // Si no estamos en /home, navega ahí primero
  if (route.name !== 'Home') {
    router.push({ name: 'Home' })
  }
}

function handleLogout() {
  auth.logout()
  nav.goTo('inicio')        // resetea la sección al cerrar sesión
  router.push({ name: 'Login' })
}
</script>

<style scoped>
.navbar {
  position: fixed;
  top: 0; left: 0; right: 0;
  height: var(--navbar-height);
  background: rgba(255, 255, 255, 0.92);
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
  gap: 1.5rem;
}

.nav-brand {
  display: flex; align-items: center; gap: .5rem;
  background: none; border: none; cursor: pointer; flex-shrink: 0;
  text-decoration: none;
}
.brand-emoji { font-size: 1.4rem; }
.brand-text  { font-size: 1rem; font-weight: 900; color: var(--color-primary-dark); letter-spacing: -.3px; }

.nav-links { display: flex; gap: .25rem; flex: 1; }
.nav-link {
  padding: .4rem .9rem; border-radius: 99px;
  font-size: .88rem; font-weight: 700;
  color: var(--color-muted);
  background: none; border: none;
  font-family: 'Nunito', sans-serif;
  cursor: pointer; transition: all .2s; white-space: nowrap;
}
.nav-link:hover, .nav-link.active {
  background: var(--color-primary-light);
  color: var(--color-primary-dark);
}
.nav-link--admin { color: #C27A2E; }
.nav-link--admin:hover, .nav-link--admin.active { background: #FFF3E8; color: #C27A2E; }

.nav-user { display: flex; align-items: center; gap: .75rem; flex-shrink: 0; }
.user-chip {
  display: flex; align-items: center; gap: .5rem;
  background: var(--color-primary-light);
  border-radius: 99px; padding: .3rem .3rem .3rem .4rem;
}
.user-chip.admin { background: #FFF3E8; }
.user-avatar {
  width: 28px; height: 28px; border-radius: 99px;
  background: var(--color-primary-dark); color: white;
  font-size: .75rem; font-weight: 900;
  display: flex; align-items: center; justify-content: center;
}
.user-chip.admin .user-avatar { background: #C27A2E; }
.user-name { font-size: .85rem; font-weight: 800; color: var(--color-primary-dark); }
.user-chip.admin .user-name { color: #C27A2E; }
.role-badge {
  font-size: .7rem; font-weight: 800;
  padding: .2rem .55rem; border-radius: 99px;
  background: var(--color-primary); color: white;
  text-transform: uppercase; letter-spacing: .3px;
}
.role-badge.admin { background: #C27A2E; }
.btn-logout {
  padding: .38rem .9rem; border-radius: 99px;
  border: 1.5px solid var(--color-border); background: transparent;
  color: var(--color-muted); font-family: 'Nunito', sans-serif;
  font-size: .85rem; font-weight: 700; cursor: pointer; transition: all .2s;
}
.btn-logout:hover { background: #FFEEF3; border-color: #F5B8C8; color: #C0392B; }
.btn-guest {
  padding: .38rem .9rem; border-radius: 99px;
  font-size: .85rem; font-weight: 700;
  text-decoration: none; transition: all .2s;
}
.btn-login { border: 1.5px solid var(--color-border); color: var(--color-muted); }
.btn-login:hover { background: var(--color-primary-light); color: var(--color-primary-dark); }
.btn-register { background: var(--color-primary-dark); color: white; border: 1.5px solid var(--color-primary-dark); }
.btn-register:hover { opacity: .88; }
</style>