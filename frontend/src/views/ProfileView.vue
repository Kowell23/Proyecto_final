<template>
  <div class="profile-page">
    <div class="container">

      <!-- Visitante sin sesión -->
      <div v-if="!auth.isAuthenticated" class="guest-state">
        <span class="guest-icon">👤</span>
        <h2>Sin sesión activa</h2>
        <p>Crea una cuenta para personalizar tu experiencia, guardar recetas favoritas y acceder a tu perfil.</p>
        <div class="guest-actions">
          <button @click="nav.showRegister()" class="btn-register">Crear cuenta gratis 🚀</button>
          <RouterLink to="/login" class="btn-login">Ya tengo cuenta</RouterLink>
        </div>
      </div>

      <!-- Usuario con sesión -->
      <div v-else class="profile-card">
        <div class="avatar">{{ auth.initials }}</div>
        <h1 class="profile-name">{{ auth.user?.name }}</h1>
        <span class="profile-role" :class="auth.user?.role">
          {{ auth.user?.role === 'admin' ? '👑 Administrador' : '🌸 Usuario' }}
        </span>

        <div class="profile-info">
          <div class="info-row">
            <span class="info-icon">📧</span>
            <div>
              <span class="info-label">Email</span>
              <span class="info-value">{{ auth.user?.email }}</span>
            </div>
          </div>
          <div class="info-row">
            <span class="info-icon">🎭</span>
            <div>
              <span class="info-label">Rol</span>
              <span class="info-value">{{ auth.user?.role }}</span>
            </div>
          </div>
        </div>

        <button @click="handleLogout" class="btn-logout">Cerrar sesión 👋</button>
      </div>

    </div>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { useAuthStore }       from '../stores/auth.store.js'
import { useNavigationStore } from '../stores/navigation.store.js'

const router = useRouter()
const auth   = useAuthStore()
const nav    = useNavigationStore()

function handleLogout() {
  auth.logout()
  nav.goTo('inicio')
  router.push({ name: 'Login' })
}
</script>

<style scoped>
.profile-page {
  min-height: 80vh;
  padding: 3rem 2rem;
  background: linear-gradient(135deg, var(--color-primary-light) 0%, #FFEEF3 100%);
}
.container { max-width: 480px; margin: 0 auto; }

/* Visitante */
.guest-state {
  background: white; border-radius: 24px; padding: 3rem 2rem;
  text-align: center; box-shadow: 0 8px 32px rgba(201,184,232,.3);
}
.guest-icon { font-size: 3.5rem; display: block; margin-bottom: 1rem; }
.guest-state h2 { font-size: 1.4rem; font-weight: 900; color: var(--color-text); margin-bottom: .5rem; }
.guest-state p  { color: var(--color-muted); line-height: 1.6; margin-bottom: 2rem; font-size: .95rem; }
.guest-actions  { display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap; }
.btn-register {
  padding: .75rem 1.5rem; background: var(--color-primary-dark); color: white;
  border: none; border-radius: 99px; font-family: 'Nunito', sans-serif;
  font-size: .95rem; font-weight: 800; cursor: pointer; transition: opacity .2s;
}
.btn-register:hover { opacity: .88; }
.btn-login {
  padding: .75rem 1.5rem; background: transparent; color: var(--color-primary-dark);
  border: 2px solid var(--color-primary-dark); border-radius: 99px;
  font-size: .95rem; font-weight: 800; text-decoration: none; transition: all .2s;
}
.btn-login:hover { background: var(--color-primary-light); }

/* Usuario con sesión */
.profile-card {
  background: white; border-radius: 24px; padding: 2.5rem;
  text-align: center; box-shadow: 0 8px 32px rgba(201,184,232,.3);
}
.avatar {
  width: 90px; height: 90px; border-radius: 99px;
  background: linear-gradient(135deg, var(--color-primary), var(--color-secondary));
  display: flex; align-items: center; justify-content: center;
  font-size: 1.8rem; font-weight: 900; color: white; margin: 0 auto 1rem;
}
.profile-name { font-size: 1.5rem; font-weight: 900; color: var(--color-text); margin-bottom: .5rem; }
.profile-role {
  display: inline-block; padding: .3rem .9rem; border-radius: 99px;
  font-size: .85rem; font-weight: 800; margin-bottom: 2rem;
}
.profile-role.admin { background: #FFF3E8; color: #C27A2E; }
.profile-role.user  { background: var(--color-primary-light); color: var(--color-primary-dark); }
.profile-info { display: flex; flex-direction: column; gap: 1rem; margin-bottom: 2rem; text-align: left; }
.info-row {
  display: flex; align-items: center; gap: 1rem; padding: 1rem;
  background: var(--color-bg); border-radius: 14px; border: 1.5px solid var(--color-border);
}
.info-icon  { font-size: 1.3rem; }
.info-label { display: block; font-size: .75rem; font-weight: 700; color: var(--color-muted); text-transform: uppercase; letter-spacing: .5px; }
.info-value { display: block; font-size: .95rem; font-weight: 700; color: var(--color-text); }
.btn-logout {
  width: 100%; padding: .85rem; border-radius: 14px; border: none;
  background: #FFEEF3; color: #C0392B; font-family: 'Nunito', sans-serif;
  font-size: 1rem; font-weight: 800; cursor: pointer; transition: all .2s;
}
.btn-logout:hover { background: #FFD6D6; }
</style>