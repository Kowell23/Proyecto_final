import { defineStore } from 'pinia'
import { ref } from 'vue'

// ── Store de navegación interna ───────────────────────────────────
// Controla qué sección se muestra dentro de HomeView
// sin cambiar la URL del navegador.
//
// Secciones disponibles:
//   'inicio'    → hero + búsqueda + grid de recetas
//   'recetas'   → listado completo de recetas
//   'favoritas' → recetas guardadas por el usuario
//   'perfil'    → datos del usuario

export const useNavigationStore = defineStore('navigation', () => {
  const currentSection = ref('inicio')

  function goTo(section) {
    currentSection.value = section
  }

  return { currentSection, goTo }
})