import { createApp } from 'vue'
import { createPinia } from 'pinia'
import router from './router/index.js'
import App from './App.vue'

const app = createApp(App)

app.use(createPinia()) // Siempre ANTES del router (el guard usa el store)
app.use(router)

app.mount('#app')
