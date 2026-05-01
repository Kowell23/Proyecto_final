# Recetas App — AGENTS.md

## Project Structure
```
recetas-app/
├── backend/          # Express API (port 3000)
└── frontend/        # Vue 3 + Vite (port 5173)
```

## Commands
```bash
# Backend (needs MySQL running first)
cd backend && npm install && npm run dev

# Frontend
cd frontend && npm install && npm run dev
```

## Prerequisites
1. **MySQL must be running** before starting backend
2. Execute `backend/database.sql` in MySQL Workbench to create schema
3. Configure `backend/.env` with your MySQL credentials (copy from `.env.example` if needed)

## Key Files
- `backend/src/app.js` — Express entrypoint
- `backend/src/config/db.js` — MySQL connection pool
- `backend/src/middlewares/auth.middleware.js` — JWT + role verification
- `frontend/src/services/api.js` — Axios with JWT interceptor
- `frontend/src/stores/auth.store.js` — Pinia session store
- `frontend/src/router/index.js` — Routes + navigation guards

## Login
- Admin: `admin@recetas.com` / `Admin123!`

## Routes
- `/` → redirects to `/home`
- `/home` — main route with **polymorphism**: renders `InicioSection`, `RecipesView`, `FavoritesView`, or `ProfileView` via `<component :is="">` based on `nav.currentSection`
- `/login`, `/register` — auth pages (public, but redirects to Home if already logged in)
- `/recipes/:id` — recipe detail (public)
- `/admin` — only for admin role

## Navigation Flow (Key for Polymorphism)
- Navbar sections: **Inicio** and **Recetas** are always accessible to visitors
- **Favoritas**: clicks work without login (shows `GuestModal`), but viewing the section requires auth → shows modal on mount
- **Perfil**: requires auth, redirects to Login if not logged in
- Login/Register buttons navigate to `/home` (not stuck in auth pages)

## Notes
- All recipe endpoints require JWT in Authorization header
- Admin-only routes: POST/PUT/DELETE `/api/recipes`
- Frontend state is in Pinia (`authStore`), not localStorage directly
- Polymorphism uses `navigation.store.js` (`nav.currentSection`) to switch components without changing URL