CREATE DATABASE IF NOT EXISTS recetas_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE recetas_db;

CREATE TABLE IF NOT EXISTS users (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  name          VARCHAR(100)  NOT NULL,
  email         VARCHAR(150)  NOT NULL UNIQUE,
  password_hash VARCHAR(255)  NOT NULL,
  role          ENUM('admin', 'user') NOT NULL DEFAULT 'user',
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS recipes (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  title        VARCHAR(200) NOT NULL,
  description  TEXT,
  instructions TEXT         NOT NULL,
  image_url    VARCHAR(500),
  category     VARCHAR(100),
  created_by   INT          NOT NULL,
  created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ingredients (
  id   INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE IF NOT EXISTS recipe_ingredients (
  recipe_id     INT         NOT NULL,
  ingredient_id INT         NOT NULL,
  quantity      VARCHAR(50),
  PRIMARY KEY (recipe_id, ingredient_id),
  FOREIGN KEY (recipe_id)     REFERENCES recipes(id)     ON DELETE CASCADE,
  FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS favorites (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  user_id    INT NOT NULL,
  recipe_id  INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_favorite (user_id, recipe_id),
  FOREIGN KEY (user_id)   REFERENCES users(id)   ON DELETE CASCADE,
  FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE
);

-- ─── DATOS DE PRUEBA ─────────────────────────────────────────
-- Contraseña: Admin123! (hash generado con bcrypt, saltRounds=10)
INSERT IGNORE INTO users (name, email, password_hash, role) VALUES
('Admin', 'admin@recetas.com', '$2a$10$YqK9VZu2DMd.PxhN1sK3rO6dEJ5s.XwPe5aBVtBH6PKQU2K3t.U5e', 'admin');

-- Ingredientes base
INSERT IGNORE INTO ingredients (name) VALUES
('Arroz'), ('Pollo'), ('Cebolla'), ('Ajo'), ('Tomate'),
('Sal'), ('Pimienta'), ('Aceite de oliva'), ('Huevo'), ('Leche'),
('Harina'), ('Azúcar'), ('Mantequilla'), ('Zanahoria'), ('Papa'),
('Cilantro'), ('Limón'), ('Aguacate'), ('Fríjoles'), ('Plátano');

-- Receta de ejemplo
INSERT IGNORE INTO recipes (title, description, instructions, category, created_by) VALUES
('Arroz con Pollo', 'Clásico plato colombiano fácil de preparar.',
 '1. Sofría el pollo con cebolla y ajo.\n2. Agregue el arroz y el agua.\n3. Cocine a fuego medio por 20 minutos.',
 'Platos Principales', 1);

-- Ingredientes de la receta de ejemplo
INSERT IGNORE INTO recipe_ingredients (recipe_id, ingredient_id, quantity) VALUES
(1, 1, '2 tazas'),   -- Arroz
(1, 2, '500g'),      -- Pollo
(1, 3, '1 unidad'),  -- Cebolla
(1, 4, '3 dientes'), -- Ajo
(1, 6, 'Al gusto'),  -- Sal
(1, 7, 'Al gusto');  -- Pimienta
