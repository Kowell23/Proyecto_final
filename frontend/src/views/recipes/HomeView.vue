<template>
  <div class="home-container">
    <!--
      ✅ POLIMORFISMO con <component :is="">
      Una sola etiqueta renderiza distintos componentes
      según el valor de nav.currentSection.
      La URL permanece en /home siempre.
    -->
    <component :is="sections[nav.currentSection]" />

    <!-- FAB de Admin — visible desde cualquier sección -->
    <div v-if="auth.isAdmin" class="admin-fab" @click="$router.push('/admin')">
      🛠️ Admin
    </div>
  </div>
</template>

<script setup>
import { useAuthStore }       from '../../stores/auth.store.js'
import { useNavigationStore } from '../../stores/navigation.store.js'

// ── Componentes que se alternan (polimorfismo) ────────────────────
// Cada sección es un componente distinto, pero se renderizan
// todos en la misma URL /home a través de <component :is="">
import InicioSection from './InicioSection.vue'
import RecipesView   from './RecipesView.vue'
import FavoritesView from './FavoritesView.vue'
import ProfileView   from '../ProfileView.vue'

const auth = useAuthStore()
const nav  = useNavigationStore()

// Mapa de sección → componente (esto ES polimorfismo en Vue)
const sections = {
  inicio:    InicioSection,
  recetas:   RecipesView,
  favoritas: FavoritesView,
  perfil:    ProfileView,
}
</script>

<style scoped>
.home-container { min-height: 100vh; position: relative; }

.admin-fab {
  position: fixed;
  bottom: 2rem; right: 2rem;
  background: var(--color-primary-dark);
  color: white;
  padding: .75rem 1.25rem;
  border-radius: 99px;
  font-weight: 800;
  font-size: .9rem;
  cursor: pointer;
  box-shadow: 0 4px 20px rgba(123, 94, 167, .4);
  transition: transform .2s;
  z-index: 50;
}
.admin-fab:hover { transform: scale(1.05); }
</style>