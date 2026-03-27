# 🍳 Recetas de Cocina

**Proyecto:** Programación Orientada a la Web  
**Universidad:** Santiago de Cali  
**Autor:** Nicolás Caicedo  
**Nivel:** 1 — Individual

---

## 📋 Descripción

Aplicación web fullstack para gestionar recetas de cocina. Permite filtrar recetas por ingredientes y marcar favoritos. Implementa autenticación completa con JWT, manejo de roles y base de datos relacional.

---

## 🏗️ Stack Tecnológico

| Capa | Tecnología |
|---|---|
| Frontend | Vue 3 + Vite + Pinia + Vue Router |
| HTTP Client | Axios con interceptores |
| Backend | Node.js + Express |
| Base de datos | MySQL |
| Autenticación | JWT (jsonwebtoken) |
| Cifrado | bcryptjs |
| Validación | Zod |

---

## 📁 Estructura del Proyecto

```
recetas-app/
├── backend/
│   ├── src/
│   │   ├── config/db.js              # Conexión MySQL (pool)
│   │   ├── middlewares/
│   │   │   ├── auth.middleware.js    # JWT + roles
│   │   │   └── error.middleware.js   # Errores globales
│   │   ├── modules/
│   │   │   └── auth/
│   │   │       ├── auth.controller.js
│   │   │       └── auth.routes.js
│   │   ├── validators/
│   │   │   └── auth.validator.js     # Esquemas Zod
│   │   └── app.js                    # Servidor Express
│   ├── database.sql                  # Schema + datos de prueba
│   ├── .env.example
│   └── package.json
│
└── frontend/
    ├── src/
    │   ├── services/api.js           # Axios + interceptores
    │   ├── stores/auth.store.js      # Pinia — sesión global
    │   ├── router/index.js           # Rutas + Navigation Guards
    │   ├── views/
    │   │   ├── LoginView.vue
    │   │   ├── RegisterView.vue
    │   │   └── HomeView.vue
    │   ├── App.vue
    │   └── main.js
    └── package.json
```

---

## 🚀 Instalación y ejecución

### 1. Clonar el repositorio
```bash
git clone https://github.com/tu-usuario/recetas-app.git
cd recetas-app
```

### 2. Configurar la base de datos
```bash
# Abrir MySQL Workbench y ejecutar:
backend/database.sql
```

### 3. Configurar el backend
```bash
cd backend
cp .env.example .env
# Editar .env con tus credenciales de MySQL y un JWT_SECRET seguro
npm install
npm run dev
```

### 4. Iniciar el frontend
```bash
cd frontend
npm install
npm run dev
```

### 5. Abrir en el navegador
- Frontend: http://localhost:5173
- Backend API: http://localhost:3000
- Health check: http://localhost:3000/health

---

## 🔐 Endpoints de Autenticación

| Método | Ruta | Descripción | Auth |
|--------|------|-------------|------|
| POST | `/api/auth/register` | Registrar nuevo usuario | No |
| POST | `/api/auth/login` | Iniciar sesión | No |
| GET | `/api/auth/me` | Obtener perfil propio | JWT |

### Ejemplo de registro
```json
POST /api/auth/register
{
  "name": "Nicolás Caicedo",
  "email": "nicolas@email.com",
  "password": "miclave123"
}
```

### Ejemplo de login
```json
POST /api/auth/login
{
  "email": "nicolas@email.com",
  "password": "miclave123"
}
```

### Respuesta exitosa (login/register)
```json
{
  "success": true,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "name": "Nicolás Caicedo",
    "email": "nicolas@email.com",
    "role": "user"
  }
}
```

---

## 🔑 Credenciales de prueba (admin)

| Campo | Valor |
|-------|-------|
| Email | admin@recetas.com |
| Contraseña | Admin123! |

---

## ✅ Estándar técnico implementado (CORE)

- [x] Autenticación con JWT (register + login)
- [x] Roles: `admin` y `user` con middleware de autorización
- [x] Contraseñas cifradas con bcryptjs (saltRounds: 10)
- [x] Validación de datos con Zod
- [x] Estado global con Pinia (`authStore`)
- [x] Navigation Guards en Vue Router
- [x] Axios con interceptores (adjunta JWT automáticamente)
- [x] API REST estructurada
- [x] Base de datos MySQL relacional
- [x] Controlador de errores global en Express
