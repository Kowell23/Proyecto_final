import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import api from '../services/api.js'

export const useAuthStore = defineStore('auth', () => {
  // ─── Estado ─────────────────────────────────────────────────
  const token = ref(localStorage.getItem('token') || null)
  const user  = ref(JSON.parse(localStorage.getItem('user') || 'null'))

  // ─── Getters (propiedades derivadas) ────────────────────────
  const isAuthenticated = computed(() => !!token.value)
  const isAdmin         = computed(() => user.value?.role === 'admin')

  // ─── Actions ────────────────────────────────────────────────
  async function register(name, email, password) {
    const { data } = await api.post('/auth/register', { name, email, password })
    _setSession(data.token, data.user)
    return data
  }

  async function login(email, password) {
    const { data } = await api.post('/auth/login', { email, password })
    _setSession(data.token, data.user)
    return data
  }

  function logout() {
    token.value = null
    user.value  = null
    localStorage.removeItem('token')
    localStorage.removeItem('user')
  }

  // Helper privado — guarda token y user en estado + localStorage
  function _setSession(newToken, newUser) {
    token.value = newToken
    user.value  = newUser
    localStorage.setItem('token', newToken)
    localStorage.setItem('user', JSON.stringify(newUser))
  }

  return { token, user, isAuthenticated, isAdmin, register, login, logout }
})
