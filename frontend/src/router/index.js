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

  // ── Familia AUTH (sin navbar ni footer) ───────────────────────
  {
    path: '/',
    component: AuthLayout,
    children: [
      { path: 'login',    name: 'Login',    component: LoginView,    meta: { requiresGuest: true } },
      { path: 'register', name: 'Register', component: RegisterView, meta: { requiresGuest: true } },
    ],
  },

  // ── Familia MAIN (con navbar y footer) ────────────────────────
  {
    path: '/',
    component: MainLayout,
    children: [
      // PÚBLICA — cualquier visitante entra sin sesión
      { path: 'home',        name: 'Home',        component: HomeView         },
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

// ── Navigation Guard ─────────────────────────────────────────────
// ✅ FIX: con rutas anidadas, to.meta solo lee el meta del padre.
//    to.matched.some() recorre TODOS los segmentos de la ruta
//    (padre + hijo) y encuentra el meta correctamente.
router.beforeEach((to) => {
  const auth = useAuthStore()

  const requiresGuest = to.matched.some(r => r.meta.requiresGuest)
  const requiresAuth  = to.matched.some(r => r.meta.requiresAuth)
  const requiresAdmin = to.matched.some(r => r.meta.requiresAdmin)

  // 1. Página de auth + ya logueado → Home
  if (requiresGuest && auth.isAuthenticated) {
    return { name: 'Home' }
  }

  // 2. Página protegida + sin sesión → Login
  if (requiresAuth && !auth.isAuthenticated) {
    return { name: 'Login' }
  }

  // 3. Página de admin + usuario NO es admin → Home
  //    Cubre: user normal que escribe /admin en la barra del navegador
  if (requiresAdmin && !auth.isAdmin) {
    return { name: 'Home' }
  }
})

export default router