import axios from 'axios'

// Instancia personalizada de Axios
// La URL base apunta siempre al backend — no hay que repetirla en cada llamada
const api = axios.create({
  baseURL: 'http://localhost:3000/api',
  headers: { 'Content-Type': 'application/json' }
})

// ─── Interceptor de REQUEST ────────────────────────────────────────────────────
// Antes de que CUALQUIER petición salga, este gancho le pega el JWT en el header
// Así no tienes que escribir el header manualmente en cada llamada
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token')
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`
    }
    return config
  },
  (error) => Promise.reject(error)
)

// ─── Interceptor de RESPONSE ──────────────────────────────────────────────────
// Si el servidor responde 401 (token expirado/inválido),
// limpia el storage y redirige al login automáticamente
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      localStorage.removeItem('token')
      localStorage.removeItem('user')
      window.location.href = '/login'
    }
    return Promise.reject(error)
  }
)

export default api
