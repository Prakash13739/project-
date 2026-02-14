# Mini-Amazon E-Commerce Website

A Spring Boot-based e-commerce application with a premium "Glassmorphism" UI design, MySQL persistence, and secure authentication.

## Prerequisites

1.  **Java 17+**
2.  **Maven** (or use an IDE like IntelliJ IDEA)
3.  **MySQL Server** running on `localhost:3306`

## Database Setup

1.  Create a database named `ecommerce_db` in your MySQL server:
    ```sql
    CREATE DATABASE ecommerce_db;
    ```
2.  Update `src/main/resources/application.properties` with your MySQL username and password if they are different from `root` / `password`:
    ```properties
    spring.datasource.username=root
    spring.datasource.password=password
    ```

## How to Run

1.  Open the project in your terminal or IDE.
2.  Run the application using Maven:
    ```bash
    mvn spring-boot:run
    ```
3.  Access the application at: [http://localhost:8080](http://localhost:8080)

## Features

-   **User Authentication**: Register and Login with secure password hashing.
-   **Product Catalog**: Browse products in a glossy grid layout.
-   **Shopping Cart**: Add items, view cart, and remove items.
-   **Checkout**: Process orders and get confirmation.
-   **Design**: Modern Glassmorphism UI with animated backgrounds.

## Default Data

The application will automatically seed 3 demo products (Smartphone, Laptop, Headphones) upon the first run.
