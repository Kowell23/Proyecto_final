import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '../stores/auth.store.js'

// ── Layouts ───────────────────────────────────────────────────────
import AuthLayout from '../layouts/AuthLayout.vue'
import MainLayout from '../layouts/MainLayout.vue'

// ── Vistas de autenticación ───────────────────────────────────────
import LoginView    from '../views/auth/LoginView.vue'
import RegisterView from '../views/auth/RegisterView.vue'

// ── Vistas de recetas ─────────────────────────────────────────────
import HomeView         from '../views/recipes/HomeView.vue'
import RecipesView      from '../views/recipes/RecipesView.vue'
import RecipeDetailView from '../views/recipes/RecipeDetailView.vue'
import FavoritesView    from '../views/recipes/FavoritesView.vue'

// ── Vistas individuales ───────────────────────────────────────────
import ProfileView from '../views/ProfileView.vue'
import AdminView   from '../views/AdminView.vue'

// ─────────────────────────────────────────────────────────────────
//  RUTAS ANIDADAS (Nested Routes)
//
//  Estructura visual:
//
//  AuthLayout              MainLayout
//  └── /login              ├── /home          (guest, user, admin)
//  └── /register           ├── /recipes       (guest, user, admin)
//                          ├── /recipes/:id   (guest, user, admin)
//                          ├── /favorites     (user, admin)
//                          ├── /profile       (user, admin)
//                          └── /admin         (admin)
//
//  meta.requiresGuest  → redirige al home si ya hay sesión
//  meta.requiresAuth   → redirige al login si no hay sesión
//  meta.requiresAdmin  → redirige al home si no es admin
// ─────────────────────────────────────────────────────────────────

const routes = [
  { path: '/', redirect: '/home' },

  // ── Familia AUTH (sin navbar) ─────────────────────────────────
  {
    path: '/',
    component: AuthLayout,
    children: [
      {
        path: 'login',
        name: 'Login',
        component: LoginView,
        meta: { requiresGuest: true }, // si ya hay sesión → va a Home
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
      // Públicas: cualquier visitante puede entrar
      {
        path: 'home',
        name: 'Home',
        component: HomeView,
      },
      {
        path: 'recipes',
        name: 'Recipes',
        component: RecipesView,
      },
      {
        path: 'recipes/:id',
        name: 'RecipeDetail',
        component: RecipeDetailView,
      },

      // Protegidas: solo usuarios con sesión (user o admin)
      {
        path: 'favorites',
        name: 'Favorites',
        component: FavoritesView,
        meta: { requiresAuth: true },
      },
      {
        path: 'profile',
        name: 'Profile',
        component: ProfileView,
        meta: { requiresAuth: true },
      },

      // Solo admin
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

// ── Navigation Guard: gestión de roles ───────────────────────────
// Se ejecuta ANTES de cada cambio de ruta.
router.beforeEach((to) => {
  const auth = useAuthStore()

  // 1. Ruta solo para visitantes → si ya hay sesión, manda al home
  if (to.meta.requiresGuest && auth.isAuthenticated) {
    return { name: 'Home' }
  }

  // 2. Ruta que requiere sesión → si no hay token, manda al login
  if (to.meta.requiresAuth && !auth.isAuthenticated) {
    return { name: 'Login' }
  }

  // 3. Ruta exclusiva de admin → si no es admin, manda al home
  if (to.meta.requiresAdmin && !auth.isAdmin) {
    return { name: 'Home' }
  }

  // Si todo está bien → deja pasar
})

export default router