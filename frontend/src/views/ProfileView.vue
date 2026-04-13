<template>
  <div class="profile-page">
    <div class="container">
      <div class="profile-card">

        <div class="avatar">{{ initials }}</div>

        <h1 class="profile-name">{{ auth.user?.name }}</h1>
        <span class="profile-role" :class="auth.user?.role">
          {{ auth.user?.role === 'admin' ? '👑 Administradora' : '🌸 Usuaria' }}
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

        <button @click="handleLogout" class="btn-logout">
          Cerrar sesión 👋
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth.store.js'

const router = useRouter()
const auth   = useAuthStore()

const initials = computed(() =>
  (auth.user?.name || '')
    .split(' ')
    .map(n => n[0])
    .join('')
    .slice(0, 2)
    .toUpperCase()
)

function handleLogout() {
  auth.logout()
  router.push({ name: 'Login' })
}
</script>

<style scoped>
.profile-page {
  min-height: 100vh;
  padding: 3rem 2rem;
  background: linear-gradient(135deg, var(--color-primary-light) 0%, #FFEEF3 100%);
}
.container { max-width: 480px; margin: 0 auto; }
.profile-card {
  background: white;
  border-radius: 24px;
  padding: 2.5rem;
  text-align: center;
  box-shadow: 0 8px 32px rgba(201,184,232,.3);
}
.avatar {
  width: 90px; height: 90px;
  border-radius: 99px;
  background: linear-gradient(135deg, var(--color-primary), var(--color-secondary));
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.8rem;
  font-weight: 900;
  color: white;
  margin: 0 auto 1rem;
}
.profile-name { font-size: 1.5rem; font-weight: 900; color: var(--color-text); margin-bottom: .5rem; }
.profile-role {
  display: inline-block;
  padding: .3rem .9rem;
  border-radius: 99px;
  font-size: .85rem;
  font-weight: 800;
  margin-bottom: 2rem;
}
.profile-role.admin { background: #FFF3E8; color: #C27A2E; }
.profile-role.user  { background: var(--color-primary-light); color: var(--color-primary-dark); }

.profile-info { display: flex; flex-direction: column; gap: 1rem; margin-bottom: 2rem; text-align: left; }
.info-row {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  background: var(--color-bg);
  border-radius: 14px;
  border: 1.5px solid var(--color-border);
}
.info-icon { font-size: 1.3rem; }
.info-label { display: block; font-size: .75rem; font-weight: 700; color: var(--color-muted); text-transform: uppercase; letter-spacing: .5px; }
.info-value { display: block; font-size: .95rem; font-weight: 700; color: var(--color-text); }

.btn-logout {
  width: 100%;
  padding: .85rem;
  border-radius: 14px;
  border: none;
  background: #FFEEF3;
  color: #C0392B;
  font-family: 'Nunito', sans-serif;
  font-size: 1rem;
  font-weight: 800;
  cursor: pointer;
  transition: all .2s;
}
.btn-logout:hover { background: #FFD6D6; }
</style>