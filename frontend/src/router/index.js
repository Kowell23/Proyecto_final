import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '../stores/auth.store.js'

// ── Layouts ───────────────────────────────────────────────────────
import AuthLayout from '../layouts/AuthLayout.vue'
import MainLayout from '../layouts/MainLayout.vue'

// ── Auth ──────────────────────────────────────────────────────────
import LoginView    from '../views/auth/LoginView.vue'
import RegisterView from '../views/auth/RegisterView.vue'

// ── Vistas principales ────────────────────────────────────────────
import HomeView         from '../views/recipes/HomeView.vue'
import RecipeDetailView from '../views/recipes/RecipeDetailView.vue'
import AdminView        from '../views/AdminView.vue'

const routes = [
  // La raíz manda al home — accesible sin sesión
  { path: '/', redirect: '/home' },

  // ── AUTH: login/register — SOLO para NO logueados, sin navbar/footer
  {
    path: '/',
    component: AuthLayout,
    children: [
      { path: 'login',    name: 'Login',    component: LoginView },
      { path: 'register', name: 'Register', component: RegisterView },
    ],
  },

  // ── MAIN: con navbar y footer — públicas + protegidas
  {
    path: '/',
    component: MainLayout,
    children: [
      // PÚBLICA — cualquier visitante entra sin sesión
      { path: 'home',        name: 'Home',        component: HomeView },
      { path: 'recipes/:id', name: 'RecipeDetail', component: RecipeDetailView },

      // SOLO ADMIN
      {
        path: 'admin',
        name: 'Admin',
        component: AdminView,
        meta: { requiresAuth: true, requiresAdmin: true },
      },
    ],
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior: () => ({ top: 0 }),
})

// ── Navigation Guard — solo protección, SIN redirect de guest a home
router.beforeEach((to) => {
  const auth = useAuthStore()

  const requiresAuth  = to.matched.some(r => r.meta.requiresAuth)
  const requiresAdmin = to.matched.some(r => r.meta.requiresAdmin)

  // 1. Página protegida + sin sesión → Login
  if (requiresAuth && !auth.isAuthenticated) {
    return { name: 'Login' }
  }

  // 2. Página de admin + usuario NO es admin → Home
  if (requiresAdmin && !auth.isAdmin) {
    return { name: 'Home' }
  }
})

export default router