import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '../stores/auth.store.js'

// ── Layouts ───────────────────────────────────────────────────────
import AuthLayout from '../layouts/AuthLayout.vue'
import MainLayout from '../layouts/MainLayout.vue'

// ── Auth ──────────────────────────────────────────────────────────
import LoginView    from '../views/auth/LoginView.vue'
import RegisterView from '../views/auth/RegisterView.vue'

// ── Vistas principales ────────────────────────────────────────────
// HomeView es el contenedor polimórfico — carga Inicio, Recetas,
// Favoritas y Perfil internamente sin cambiar la URL.
import HomeView         from '../views/recipes/HomeView.vue'
import RecipeDetailView from '../views/recipes/RecipeDetailView.vue'
import AdminView        from '../views/AdminView.vue'

// ─────────────────────────────────────────────────────────────────
//  RUTAS — simplificadas gracias al polimorfismo:
//
//  Antes:  /home /recipes /favorites /profile  (4 rutas)
//  Ahora:  /home                               (1 ruta — todo nace aquí)
//
//  /recipes/:id sigue teniendo su propia ruta porque
//  necesita un parámetro dinámico (:id) en la URL.
// ─────────────────────────────────────────────────────────────────
const routes = [
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
      // Contenedor polimórfico — URL fija, contenido dinámico
      { path: 'home', name: 'Home', component: HomeView },

      // Detalle de receta — necesita su propia ruta por el :id
      { path: 'recipes/:id', name: 'RecipeDetail', component: RecipeDetailView },

      // Admin — exclusiva para rol admin
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
router.beforeEach((to) => {
  const auth = useAuthStore()

  // 1. Página de auth + ya logueado → Home
  if (to.meta.requiresGuest && auth.isAuthenticated) {
    return { name: 'Home' }
  }

  // 2. Página protegida + sin sesión → Login
  if (to.meta.requiresAuth && !auth.isAuthenticated) {
    return { name: 'Login' }
  }

  // 3. Admin + no es admin → Home
  if (to.meta.requiresAdmin && !auth.isAdmin) {
    return { name: 'Home' }
  }
})

export default router