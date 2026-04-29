<template>
  <nav class="navbar">
    <div class="nav-container">

      <!-- Logo -->
      <RouterLink to="/home" class="nav-brand">
        <span class="brand-emoji">🍳</span>
        <span class="brand-text">Recetas de Cocina</span>
      </RouterLink>

      <!-- Links de navegación
           Visible para todos (guest, user, admin) -->
      <div class="nav-links">
        <RouterLink to="/home"    class="nav-link" active-class="active">🏠 Inicio</RouterLink>
        <RouterLink to="/recipes" class="nav-link" active-class="active">🍽️ Recetas</RouterLink>

        <!-- Solo para user y admin (requiresAuth) -->
        <RouterLink
          v-if="auth.isAuthenticated"
          to="/favorites"
          class="nav-link"
          active-class="active"
        >❤️ Favoritas</RouterLink>

        <RouterLink
          v-if="auth.isAuthenticated"
          to="/profile"
          class="nav-link"
          active-class="active"
        >👤 Perfil</RouterLink>

        <!-- Solo para admin -->
        <RouterLink
          v-if="auth.isAdmin"
          to="/admin"
          class="nav-link nav-link--admin"
          active-class="active"
        >🛠️ Admin</RouterLink>
      </div>

      <!-- Zona derecha: estado de sesión -->
      <div class="nav-user">

        <!-- Usuario con sesión activa -->
        <template v-if="auth.isAuthenticated">
          <div class="user-chip" :class="auth.user?.role">
            <span class="user-avatar">{{ auth.initials }}</span>
            <span class="user-name">{{ auth.firstName }}</span>
            <!-- Badge de rol -->
            <span class="role-badge" :class="auth.user?.role">
              {{ auth.isAdmin ? 'Admin' : 'User' }}
            </span>
          </div>
          <button @click="handleLogout" class="btn-logout">Salir</button>
        </template>

        <!-- Visitante sin sesión -->
        <template v-else>
          <RouterLink to="/login"    class="btn-guest btn-login">Iniciar sesión</RouterLink>
          <RouterLink to="/register" class="btn-guest btn-register">Registrarse</RouterLink>
        </template>

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

/* Logo */
.nav-brand  { display: flex; align-items: center; gap: .5rem; text-decoration: none; flex-shrink: 0; }
.brand-emoji { font-size: 1.4rem; }
.brand-text  { font-size: 1rem; font-weight: 900; color: var(--color-primary-dark); letter-spacing: -.3px; }

/* Links */
.nav-links { display: flex; gap: .25rem; flex: 1; }
.nav-link {
  padding: .4rem .9rem;
  border-radius: 99px;
  font-size: .88rem;
  font-weight: 700;
  color: var(--color-muted);
  text-decoration: none;
  transition: all .2s;
  white-space: nowrap;
}
.nav-link:hover, .nav-link.active {
  background: var(--color-primary-light);
  color: var(--color-primary-dark);
}
.nav-link--admin { color: #C27A2E; }
.nav-link--admin:hover, .nav-link--admin.active {
  background: #FFF3E8;
  color: #C27A2E;
}

/* Zona de usuario */
.nav-user { display: flex; align-items: center; gap: .75rem; flex-shrink: 0; }

.user-chip {
  display: flex;
  align-items: center;
  gap: .5rem;
  background: var(--color-primary-light);
  border-radius: 99px;
  padding: .3rem .3rem .3rem .4rem;
}
.user-chip.admin { background: #FFF3E8; }

.user-avatar {
  width: 28px; height: 28px;
  border-radius: 99px;
  background: var(--color-primary-dark);
  color: white;
  font-size: .75rem;
  font-weight: 900;
  display: flex;
  align-items: center;
  justify-content: center;
}
.user-chip.admin .user-avatar { background: #C27A2E; }

.user-name { font-size: .85rem; font-weight: 800; color: var(--color-primary-dark); }
.user-chip.admin .user-name { color: #C27A2E; }

.role-badge {
  font-size: .7rem;
  font-weight: 800;
  padding: .2rem .55rem;
  border-radius: 99px;
  background: var(--color-primary);
  color: white;
  text-transform: uppercase;
  letter-spacing: .3px;
}
.role-badge.admin { background: #C27A2E; }

.btn-logout {
  padding: .38rem .9rem;
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

/* Botones de visitante */
.btn-guest {
  padding: .38rem .9rem;
  border-radius: 99px;
  font-size: .85rem;
  font-weight: 700;
  text-decoration: none;
  transition: all .2s;
}
.btn-login { border: 1.5px solid var(--color-border); color: var(--color-muted); }
.btn-login:hover { background: var(--color-primary-light); color: var(--color-primary-dark); }
.btn-register { background: var(--color-primary-dark); color: white; border: 1.5px solid var(--color-primary-dark); }
.btn-register:hover { opacity: .88; }
</style>