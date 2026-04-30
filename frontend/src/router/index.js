import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '../stores/auth.store.js'

// ── Layouts ───────────────────────────────────────────────────────
import AuthLayout from '../layouts/AuthLayout.vue'
import MainLayout from '../layouts/MainLayout.vue'

// ── Auth ──────────────────────────────────────────────────────────
import LoginView    from '../views/auth/LoginView.vue'
import RegisterView from '../views/auth/RegisterView.vue'

// ── Recetas ───────────────────────────────────────────────────────
import HomeView         from '../views/recipes/HomeView.vue'
import RecipesView      from '../views/recipes/RecipesView.vue'
import RecipeDetailView from '../views/recipes/RecipeDetailView.vue'
import FavoritesView    from '../views/recipes/FavoritesView.vue'

// ── Individuales ──────────────────────────────────────────────────
import ProfileView from '../views/ProfileView.vue'
import AdminView   from '../views/AdminView.vue'

// ─────────────────────────────────────────────────────────────────
//  RUTAS ANIDADAS — dos familias según su layout:
//
//  AuthLayout  → sin navbar (login, register)
//  MainLayout  → con navbar + footer (todo lo demás)
//
//  meta.requiresGuest  → si ya hay sesión activa → redirige a Home
//  meta.requiresAuth   → si NO hay sesión        → redirige a Login
//  meta.requiresAdmin  → si NO es admin          → redirige a Home
// ─────────────────────────────────────────────────────────────────
const routes = [
  { path: '/', redirect: '/home' },

  // ── Familia AUTH (sin navbar ni footer) ───────────────────────
  {
    path: '/',
    component: AuthLayout,
    children: [
      {
        path: 'login',
        name: 'Login',
        component: LoginView,
        meta: { requiresGuest: true },
      },
      {
        path: 'register',
        name: 'Register',
        component: RegisterView,
        meta: { requiresGuest: true },
      },
    ],
  },

  // ── Familia MAIN (con navbar y footer) ────────────────────────
  {
    path: '/',
    component: MainLayout,
    children: [
      // Públicas — cualquier visitante (guest, user, admin)
      { path: 'home',        name: 'Home',        component: HomeView         },
      { path: 'recipes',     name: 'Recipes',     component: RecipesView      },
      { path: 'recipes/:id', name: 'RecipeDetail', component: RecipeDetailView },

      // Protegidas — solo user y admin
      { path: 'favorites', name: 'Favorites', component: FavoritesView, meta: { requiresAuth: true } },
      { path: 'profile',   name: 'Profile',   component: ProfileView,   meta: { requiresAuth: true } },

      // Exclusiva — solo admin
      // requiresAdmin bloquea a cualquier user normal que escriba /admin en la URL
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
// Se ejecuta ANTES de cargar cualquier ruta. Tres checks en orden:
router.beforeEach((to) => {
  const auth = useAuthStore()

  // 1. Página de auth + ya logueado → no tiene sentido, manda al Home
  if (to.meta.requiresGuest && auth.isAuthenticated) {
    return { name: 'Home' }
  }

  // 2. Página protegida + sin sesión → manda al Login
  if (to.meta.requiresAuth && !auth.isAuthenticated) {
    return { name: 'Login' }
  }

  // 3. Página de admin + role !== 'admin' → manda al Home
  //    Cubre el caso: user normal escribe /admin en la barra del navegador
  if (to.meta.requiresAdmin && !auth.isAdmin) {
    return { name: 'Home' }
  }
})

export default router