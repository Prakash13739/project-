-- MySQL Database Setup Script for E-Commerce Application
-- Run this script in MySQL Workbench or command line

-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS ecommerce_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Use the database
USE ecommerce_db;

-- Drop existing tables (if you want to start fresh)
-- DROP TABLE IF EXISTS cart_items;
-- DROP TABLE IF EXISTS cart;
-- DROP TABLE IF EXISTS orders;
-- DROP TABLE IF EXISTS products;
-- DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'ROLE_USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create products table
CREATE TABLE IF NOT EXISTS products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    image_url VARCHAR(500),
    category VARCHAR(100),
    stock INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create cart table
CREATE TABLE IF NOT EXISTS cart (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create cart_items table
CREATE TABLE IF NOT EXISTS cart_items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cart_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INT DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id) REFERENCES cart(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    INDEX idx_cart_id (cart_id),
    INDEX idx_product_id (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create orders table
CREATE TABLE IF NOT EXISTS orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'PENDING',
    shipping_address TEXT,
    payment_info TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status),
    INDEX idx_order_date (order_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert sample products (with Amazon-like items)
INSERT INTO products (name, description, price, image_url, category, stock) VALUES
('Apple iPhone 15 Pro', '6.1-inch Super Retina XDR display, A17 Pro chip, Pro camera system', 999.99, 'https://images.unsplash.com/photo-1592286927505-67dd2b5f7a90?w=500', 'Electronics', 50),
('Samsung Galaxy S24 Ultra', 'Latest flagship with AI features, 200MP camera, S Pen included', 1199.99, 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=500', 'Electronics', 30),
('Sony WH-1000XM5 Headphones', 'Industry-leading noise cancellation, premium sound quality', 399.99, 'https://images.unsplash.com/photo-1545127398-14699f92334b?w=500', 'Electronics', 100),
('MacBook Pro 16"', 'M3 Pro chip, 18GB RAM, 512GB SSD, Stunning Liquid Retina XDR display', 2499.99, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500', 'Computers', 25),
('Dell XPS 15', 'Intel Core i7, 16GB RAM, 1TB SSD, 15.6" 4K OLED display', 1799.99, 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=500', 'Computers', 40),
('iPad Air', '10.9-inch Liquid Retina display, M1 chip, Touch ID', 599.99, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500', 'Tablets', 60),
('Samsung Galaxy Tab S9', '11-inch AMOLED display, Snapdragon 8 Gen 2, S Pen included', 799.99, 'https://images.unsplash.com/photo-1561154464-82e9adf32764?w=500', 'Tablets', 45),
('Nike Air Max 270', 'Mens running shoes, breathable mesh, Max Air cushioning', 150.00, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500', 'Shoes', 200),
('Adidas Ultraboost 23', 'Premium running shoes with Boost technology', 180.00, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=500', 'Shoes', 150),
('Canon EOS R6 Mark II', 'Full-frame mirrorless camera, 24.2MP, 8K video', 2499.99, 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=500', 'Cameras', 15),
('Sony A7 IV', 'Full-frame hybrid camera, 33MP, 4K 60fps video', 2499.99, 'https://images.unsplash.com/photo-1606980598821-1b228e93ff48?w=500', 'Cameras', 20),
('Apple Watch Series 9', 'GPS + Cellular, Advanced health features, Always-on Retina display', 429.99, 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=500', 'Wearables', 80),
('Fitbit Charge 6', 'Advanced fitness tracker, GPS, heart rate monitoring', 159.99, 'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?w=500', 'Wearables', 120),
('PlayStation 5', 'Next-gen gaming console, 4K gaming, Ultra HD Blu-ray', 499.99, 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?w=500', 'Gaming', 35),
('Xbox Series X', '4K gaming at 120fps, 1TB SSD, Backwards compatible', 499.99, 'https://images.unsplash.com/photo-1621259182978-fbf93132d53d?w=500', 'Gaming', 40),
('Bose QuietComfort Earbuds', 'Premium wireless earbuds with world-class noise cancellation', 299.99, 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500', 'Audio', 90),
('JBL Flip 6', 'Portable Bluetooth speaker, 12 hours playtime, waterproof', 129.99, 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500', 'Audio', 150),
('Kindle Paperwhite', '6.8" display, adjustable warm light, waterproof, 16GB', 139.99, 'https://images.unsplash.com/photo-1592853518729-2ddad6d00d94?w=500', 'Books', 200),
('Amazon Echo Dot (5th Gen)', 'Smart speaker with Alexa, improved sound quality', 49.99, 'https://images.unsplash.com/photo-1543512214-318c7553f230?w=500', 'Smart Home', 300),
('Ring Video Doorbell Pro', '1080p HD video, advanced motion detection, two-way talk', 249.99, 'https://images.unsplash.com/photo-1558089687-e354d3753d1e?w=500', 'Smart Home', 100);

-- Verify data insertion
SELECT COUNT(*) as total_products FROM products;
SELECT * FROM products LIMIT 5;

COMMIT;

-- Display summary
SELECT 
    'Database Setup Complete!' as Status,
    (SELECT COUNT(*) FROM users) as Total_Users,
    (SELECT COUNT(*) FROM products) as Total_Products;
