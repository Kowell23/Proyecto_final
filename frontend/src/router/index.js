import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '../stores/auth.store.js'

const routes = [
  {
    path: '/',
    redirect: '/home'
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/LoginView.vue'),
    meta: { requiresGuest: true } // Solo para NO autenticados
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('../views/RegisterView.vue'),
    meta: { requiresGuest: true }
  },
  {
    path: '/home',
    name: 'Home',
    component: () => import('../views/HomeView.vue'),
    meta: { requiresAuth: true } // Solo para autenticados
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// ─── Navigation Guard global ──────────────────────────────────────────────────
// Se ejecuta ANTES de cada cambio de ruta
// Es el "guardia de seguridad" de todas las páginas
router.beforeEach((to) => {
  const auth = useAuthStore()

  // Si la ruta requiere auth y no estás logueado → ir a login
  if (to.meta.requiresAuth && !auth.isAuthenticated) {
    return { name: 'Login' }
  }

  // Si la ruta es solo para guests (login/register) y ya estás logueado → ir a home
  if (to.meta.requiresGuest && auth.isAuthenticated) {
    return { name: 'Home' }
  }
})

export default router
