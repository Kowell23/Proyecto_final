# 🍳 Recetas de Cocina

**Proyecto:** Programación Orientada a la Web  
**Universidad:** Santiago de Cali  
**Autor:** Nicolás Caicedo  
**Nivel:** 1 — Individual

---

## 📋 Descripción

Aplicación web fullstack para gestionar recetas de cocina. Permite explorar recetas, ver su detalle con ingredientes e instrucciones, y marcar favoritos. Implementa autenticación completa con JWT, manejo de roles (admin/usuario) y base de datos relacional.

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
│   │   ├── config/db.js                    # Conexión MySQL (pool)
│   │   ├── middlewares/
│   │   │   ├── auth.middleware.js           # JWT + roles (authenticate, authorizeRole)
│   │   │   └── error.middleware.js          # Handler global de errores
│   │   ├── modules/
│   │   │   ├── auth/
│   │   │   │   ├── auth.controller.js       # register, login, getMe
│   │   │   │   └── auth.routes.js
│   │   │   └── recipes/
│   │   │       ├── recipes.controller.js    # CRUD + favoritos
│   │   │       └── recipes.routes.js        # Rutas protegidas por rol
│   │   ├── validators/
│   │   │   ├── auth.validator.js            # Esquemas Zod para auth
│   │   │   └── recipes.validator.js         # Esquemas Zod para recetas
│   │   └── app.js                           # Servidor Express
│   ├── database.sql                         # Schema + datos de prueba
│   ├── .env.example
│   └── package.json
│
└── frontend/
    ├── src/
    │   ├── services/api.js                  # Axios + interceptores JWT
    │   ├── stores/auth.store.js             # Pinia — sesión global
    │   ├── router/index.js                  # Rutas + Navigation Guards
    │   ├── views/
    │   │   ├── LoginView.vue
    │   │   ├── RegisterView.vue
    │   │   ├── HomeView.vue
    │   │   ├── RecipesView.vue              # Listado de recetas + favoritos
    │   │   ├── RecipeDetailView.vue         # Detalle con ingredientes
    │   │   └── AdminView.vue                # Panel admin (solo rol admin)
    │   ├── App.vue
    │   └── main.js
    └── package.json
```

---

## 🚀 Instalación y ejecución

### 1. Clonar el repositorio
```bash
git clone https://github.com/Kowell23/Proyecto_final.git
cd Proyecto_final
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

## 🔐 Endpoints de la API

### Autenticación

| Método | Ruta | Descripción | Auth |
|--------|------|-------------|------|
| POST | `/api/auth/register` | Registrar nuevo usuario | No |
| POST | `/api/auth/login` | Iniciar sesión | No |
| GET | `/api/auth/me` | Obtener perfil propio | JWT |

### Recetas

| Método | Ruta | Descripción | Auth |
|--------|------|-------------|------|
| GET | `/api/recipes` | Listar todas las recetas | JWT |
| GET | `/api/recipes/:id` | Ver detalle de una receta | JWT |
| POST | `/api/recipes` | Crear receta | Admin |
| PUT | `/api/recipes/:id` | Editar receta | Admin |
| DELETE | `/api/recipes/:id` | Eliminar receta | Admin |
| GET | `/api/recipes/favorites` | Ver mis favoritos | JWT |
| POST | `/api/recipes/:id/favorites` | Añadir a favoritos | JWT |
| DELETE | `/api/recipes/:id/favorites` | Quitar de favoritos | JWT |

### Ejemplo de registro
```json
POST /api/auth/register
{
  "name": "Nicolás Caicedo",
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
- [x] Navigation Guards en Vue Router (rutas privadas y de admin)
- [x] Axios con interceptores (adjunta JWT automáticamente)
- [x] API REST estructurada con módulos separados
- [x] Base de datos MySQL relacional
- [x] Controlador de errores global en Express

---

## 🧠 Decisiones técnicas

| Decisión | Por qué |
|---|---|
| MySQL sobre MongoDB | Los datos tienen relaciones claras entre recetas, ingredientes y usuarios — una BD relacional es la opción correcta |
| Pinia sobre props/events | Evita prop drilling y centraliza la sesión en toda la app desde un solo store |
| Zod en backend | Valida y sanitiza datos antes de tocar la base de datos, previniendo inyecciones y datos corruptos |
| Módulos separados por feature | Cada módulo tiene su propio controller, routes y validator — más mantenible y escalable |
| `authorizeRole` como middleware reutilizable | Se puede aplicar en cualquier ruta sin repetir lógica de verificación de roles |
| Guard `requiresAdmin` en el router | El frontend no espera al backend para bloquear rutas — la protección ocurre en dos capas |

---

## 📝 Conclusiones

- **JWT** enseña cómo funciona la autenticación stateless — el servidor no guarda sesión, toda la información del usuario viaja firmada dentro del token.
- **El sistema de roles** demuestra que la seguridad no es solo login: es controlar qué puede hacer cada usuario dentro del sistema, tanto en el backend (middleware) como en el frontend (guards).
- **Pinia** elimina la necesidad de pasar props entre componentes — el estado de sesión está disponible en cualquier vista sin importar la profundidad del árbol de componentes.
- **Separar el proyecto en módulos** desde el inicio hace el código mantenible: agregar una nueva funcionalidad significa crear su propio módulo sin tocar los existentes.
- **La validación con Zod** en el backend es la última línea de defensa antes de la base de datos — nunca se debe confiar únicamente en la validación del frontend.
