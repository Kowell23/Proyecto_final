import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import api from '../services/api.js'

// ── Los 3 roles del sistema ───────────────────────────────────────
// guest  → sin sesión         (cualquier visitante)
// user   → sesión iniciada    (usuario registrado)
// admin  → sesión + rol admin (administrador)
// Cada nivel hereda los permisos del anterior: guest ⊂ user ⊂ admin

export const useAuthStore = defineStore('auth', () => {

  // ── Estado ─────────────────────────────────────────────────────
  const token = ref(localStorage.getItem('token') || '')
  const user  = ref(JSON.parse(localStorage.getItem('user') || 'null'))

  // ── Getters (propiedades calculadas) ───────────────────────────

  // ¿Hay sesión activa?
  const isAuthenticated = computed(() => !!token.value)

  // ¿Es administrador?
  const isAdmin = computed(() => user.value?.role === 'admin')

  // ¿Es usuario normal (no admin)?
  const isUser  = computed(() => user.value?.role === 'user')

  // Primer nombre del usuario para el saludo
  const firstName = computed(() => user.value?.name?.split(' ')[0] || '')

  // Iniciales para el avatar
  const initials = computed(() =>
    (user.value?.name || '')
      .split(' ')
      .map(n => n[0])
      .join('')
      .slice(0, 2)
      .toUpperCase()
  )

  // Rol actual como string (útil para el guard del router)
  const role = computed(() => {
    if (!token.value) return 'guest'
    return user.value?.role || 'user'
  })

  // ── Acciones ───────────────────────────────────────────────────

  async function login(email, password) {
    const { data } = await api.post('/auth/login', { email, password })
    _saveSession(data.token, data.user)
  }

  async function register(name, email, password) {
    const { data } = await api.post('/auth/register', { name, email, password })
    _saveSession(data.token, data.user)
  }

  function logout() {
    token.value = ''
    user.value  = null
    localStorage.removeItem('token')
    localStorage.removeItem('user')
  }

  // ── Privado: guarda sesión en estado y localStorage ────────────
  function _saveSession(newToken, newUser) {
    token.value = newToken
    user.value  = newUser
    localStorage.setItem('token', newToken)
    localStorage.setItem('user', JSON.stringify(newUser))
  }

  return {
    token, user,
    isAuthenticated, isAdmin, isUser, firstName, initials, role,
    login, register, logout,
  }
})