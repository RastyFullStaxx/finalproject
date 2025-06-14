/* ============================================================
   FINALPROJECTDB – INITIAL SCHEMA + SEED DATA
   ============================================================ */

/* 0. Create the database (safe if it already exists) */
CREATE DATABASE IF NOT EXISTS finalprojectdb
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE finalprojectdb;

/* 1. Admins =================================================== */
CREATE TABLE admins (
  id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  username   VARCHAR(50)  NOT NULL UNIQUE,
  password   VARCHAR(255) NOT NULL,                -- store bcrypt/argon hash
  role       ENUM('admin','productmanager') NOT NULL DEFAULT 'admin',
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
                      ON UPDATE CURRENT_TIMESTAMP
);

/* Seed two admins in ONE insert (passwords = admin123 / manager123) */
INSERT INTO admins (username, password, role) VALUES
  ('admin',   '$2y$10$KbQi/ngAv8yfSgFD4Sm90OmjDqPRr31zlDHlXAHpENFpOq/RLitzK',  'admin'),
  ('manager', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa5v8uO4.fxrNdY/hOzXyLIP4G',   'productmanager');

/* 2. Products ================================================= */
CREATE TABLE products (
  id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title       VARCHAR(255) NOT NULL,
  price       DECIMAL(10,2) NOT NULL,          -- store raw number; format in view
  image_path  VARCHAR(255) NOT NULL,           -- e.g. storage/products/desk.jpg
  created_at  TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
                       ON UPDATE CURRENT_TIMESTAMP
);

/* 3. Product Descriptions ===================================== */
CREATE TABLE product_descriptions (
  id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  product_id  INT UNSIGNED NOT NULL,
  dimension   VARCHAR(255),
  inclusion1  VARCHAR(255),
  inclusion2  VARCHAR(255),
  inclusion3  VARCHAR(255),
  inclusion4  VARCHAR(255),
  created_at  TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
                       ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_product_desc_product
    FOREIGN KEY (product_id) REFERENCES products(id)
    ON DELETE CASCADE
);
